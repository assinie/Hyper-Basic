#!/usr/bin/python
# -*- coding: utf8 -*-

from __future__ import print_function

from pprint import pprint

import stat    # for file properties
import os      # for filesystem modes (O_RDONLY, etc)
import errno   # for error number codes (ENOENT, etc)
               # - note: these must be returned as negatives
import sys

import struct   # Pour unpack
import re
import textwrap

import argparse

__version__ = '0.1'


FILTER=''.join([(len(repr(chr(x)))==3) and chr(x) or '.' for x in range(256)])
fDebug = False

def hyperbasic_dump(fname):

    with open(fname,"rb") as fsource:

        #                    +---+---------------------------------------------------------> Addresse debut chargement
        #                    |   | +---+---------------------------------------------------> Adresse fin chargement
        #                    |   | |   | +----------------+--------------------------------> ???
        #                    |   | |   | |                | +---+--------------------------> Adresse debut des variables
        # 00000000  a0 0f ff 00 08 b3 10 18  39 26 39 00 40 db 0b 00  |........9&9.@...|


        header = fsource.read(16)

        start = struct.unpack('<H', header[3:5])[0]
        end = struct.unpack('<H', header[5:7])[0]
        table = struct.unpack('<H', header[13:15])[0]

        print('Chargement: %04x' % (start))
        print('Fin       : %04x' % (end))
        print('Table     : %04x' % (table))

        if start != 0x800:
            print('*** Erreur: fichier incorrect')
            return False

        address = start
        while address < table-1:
            offset = ord(fsource.read(1))
            line_n = struct.unpack('<H', fsource.read(2))[0]
            lm_len = ord(fsource.read(1))
            line = fsource.read(offset-4)

            print('%d: %04x %02x' % (line_n, address, offset))
            print(dump(line))

            address += offset
            print('%4x < %04x' % (address, table))

        eof = ord(fsource.read(1))
        address += 1

        if eof > 0:
            print('ERROR')
            return False

        print('-------- TABLE --------')

        entry_type = -1
        while address and entry_type:
            offset = struct.unpack('<H', fsource.read(2))[0]
            entry_type = struct.unpack('<H', fsource.read(2))[0]
            entry_id = struct.unpack('<H', fsource.read(2))[0]
            entry_len = ord(fsource.read(1))

            print('%04x: %04x %02x %02x' % (address, offset, entry_type, entry_len))

            address += 7

            entry_val = fsource.read(offset-address)

            print(dump(entry_val))

            address = offset

    return True


def list_source(fname):

    table = load_table(fname)
    if not table:
        print('*** Erreur: fichier incorrect')
        return False

    tokens = load_tokens()

    # pprint(table)

    with open(fname,"rb") as fsource:

        header = fsource.read(16)

        start = struct.unpack('<H', header[3:5])[0]
        end = struct.unpack('<H', header[5:7])[0]
        table_start = struct.unpack('<H', header[13:15])[0]

        debug('Chargement: %04x' % (start))
        debug('Fin       : %04x' % (end))
        debug('Table     : %04x' % (table_start))

        address = start
        indent = 2
        step = 0
        while address < table_start-1:
            offset = ord(fsource.read(1))
            line_n = struct.unpack('<H', fsource.read(2))[0]
            lm_len = ord(fsource.read(1))
            line = fsource.read(offset-4)

            ptr = 0
            source = ''
            while ptr < len(line):
                token = ord(line[ptr])
                if token >= 0xd0:
                    inst = table[struct.unpack('<H', line[ptr:ptr+2])[0]]
                    ptr += 1
                elif token == 0xc0:
                    inst = tokens[token][ord(line[ptr+1])]
                    ptr += 1
                else:
                    if token in tokens:
                        inst = tokens[token]
                    else:
                        #inst = chr(token)
                        inst = '[$%02x]' % token

                if inst in [']', "'", 'RETURN', 'END'] and source == '':
                    indent = 0
                    step = 2

                elif inst in ['NEXT', 'UNTIL', 'UNCOUNT', 'WEND']:
                    indent -= 1

                if inst in ['FOR', 'REPEAT', 'COUNT', 'WHILE']:
                    step = 1

                if inst:
                    if token in range(29,32) or token >=178 and token <=181:
                        source = source + ' ' + inst +' '
                    elif token in range(5,15) or token in range(160, 173) or token == 192:
                        source = source + inst + ' '
                    else:
                        source = source + inst

                ptr += 1

            print('%5d %s' % (line_n, ' '*indent+source))

            indent += step
            step = 0

            address += offset

    return

def load_table(fname):

    table = {}

    with open(fname,"rb") as fsource:

        #                    +---+---------------------------------------------------------> Addresse debut chargement
        #                    |   | +---+---------------------------------------------------> Adresse fin chargement
        #                    |   | |   | +----------------+--------------------------------> ???
        #                    |   | |   | |                | +---+--------------------------> Adresse debut des variables
        # 00000000  a0 0f ff 00 08 b3 10 18  39 26 39 00 40 db 0b 00  |........9&9.@...|


        header = fsource.read(16)

        start = struct.unpack('<H', header[3:5])[0]
        end = struct.unpack('<H', header[5:7])[0]
        table_start = struct.unpack('<H', header[13:15])[0]

        debug('Chargement: %04x' % (start))
        debug('Fin       : %04x' % (end))
        debug('Table     : %04x' % (table_start))

        if start != 0x0800:
            return False

        fsource.seek(table_start-0x800+0x10, 0)
        address = table_start

        entry_type = -1
        while address and entry_type:
            offset = struct.unpack('<H', fsource.read(2))[0]
            entry_type = ord(fsource.read(1))
            entry_subtype = ord(fsource.read(1))
            entry_id = struct.unpack('<H', fsource.read(2))[0]
            entry_len = ord(fsource.read(1))

            #debug('%04x: %04x %02x:%02x %02x' % (address, offset, entry_type, entry_subtype, entry_len))

            address += 7

            entry_val = fsource.read(offset-address)

            debug(dump(entry_val))


            if entry_type == 0x10:
                entry = '"' + entry_val[0:entry_len-7] +'"'
            else:
                entry = entry_val[0:entry_len-7]

            table[entry_id] = controle_car(entry)

            debug('')
            address = offset

    return table

def load_tokens():
    tokens = {}

    tokens[0] = ']'
    tokens[1] = 'RETURN'
    tokens[3] = 'END'
    tokens[4] = 'STOP'
    tokens[5] = "'"
    tokens[8] = 'FOR'
    tokens[9] = 'REPEAT'
    tokens[10] = 'COUNT'
    tokens[11] = 'WHILE'
    tokens[13] = 'NEXT'
    tokens[14] = 'UNTIL'
    tokens[15] = 'UNCOUNT'
    tokens[16] = 'WEND'
    tokens[18] = '^'
    tokens[19] = '*'
    tokens[20] = '/'
    tokens[21] = '+'
    tokens[22] = '-'
    tokens[23] = '='
    tokens[24] = '>='
    tokens[25] = '<='
    tokens[26] = '<>'
    tokens[27] = '>'
    tokens[28] = '<'
    tokens[29] = 'XOR'
    tokens[30] = 'AND'
    tokens[31] = 'OR'

    tokens[32] = ':'
    tokens[33] = ','
    tokens[34] = ','
    tokens[36] = ''
    tokens[37] = ''
    tokens[38] = ''

    tokens[35] = ';'

    tokens[36] = ''
    tokens[37] = ''
    tokens[38] = ''
    tokens[40] = ''
    tokens[42] = ''

    tokens[44] = '='
    tokens[45] = '('
    tokens[46] = ')'

    tokens[47] = ''
    tokens[48] = ''
    tokens[49] = ''
    tokens[51] = ''
    tokens[52] = ''
    tokens[54] = ''

    # Paramètres pour xSAVE,...
    tokens[55] = 'A'
    tokens[56] = 'E'

    tokens[58] = ''
    tokens[59] = ','
    tokens[60] = ','
    tokens[61] = ''
    # Print
    tokens[66] = ','
    tokens[67] = ''
    tokens[68] = '@'

    tokens[128] = 'COS'
    tokens[129] = 'SIN'
    tokens[130] = 'ABS'
    tokens[131] = 'ATN'
    tokens[132] = 'DEEK'
    tokens[133] = 'DEG'
    tokens[134] = 'EXP'
    tokens[135] = 'LN'
    tokens[136] = 'LOG'
    tokens[137] = 'PEEK'
    tokens[138] = 'RAD'
    tokens[139] = 'RND'
    tokens[140] = 'SQR'
    tokens[141] = 'TAN'
    tokens[142] = 'LOB$'
    tokens[143] = 'LO$'
    tokens[144] = 'UP$'
    tokens[145] = 'BIN$'
    tokens[146] = 'CHR$'
    tokens[147] = 'HEX$'
    tokens[148] = 'SPC$'
    tokens[149] = 'STR$'
    tokens[150] = 'ASC'
    tokens[151] = 'LEN'
    tokens[152] = 'VAL'
    tokens[153] = 'TRUE'
    tokens[154] = 'FALSE'
    tokens[155] = 'PI'
    tokens[156] = 'SGN'
    tokens[157] = 'INT'
    tokens[158] = 'KEY$'
    tokens[159] = 'RAND'
    tokens[160] = 'REM'
    tokens[161] = 'GOTO'
    tokens[162] = 'GOSUB'
    tokens[163] = 'CLS'
    tokens[164] = 'PRINT'
    tokens[165] = 'LPRINT'
    tokens[166] = 'SPRINT'
    tokens[167] = 'MPRINT'
    tokens[168] = 'GET'
    tokens[169] = 'INPUT'
    # null
    tokens[170] = ''
    tokens[171] = 'IF'
    tokens[172] = 'ERRGOTO'
    tokens[173] = 'MID$'
    tokens[174] = 'LEFT$'
    tokens[175] = 'RIGHT$'

    tokens[176] = 'SET'
    tokens[177] = 'OFF'
    tokens[178] = 'TO'
    tokens[179] = 'STEP'
    tokens[180] = 'ELSE'
    tokens[181] = 'THEN'

    tokens[192] = {}
    tokens[192][0] = 'HIRES'
    tokens[192][1] = 'TEXT'
    tokens[192][2] = 'LIST'
    tokens[192][3] = 'TRACE'
    tokens[192][4] = 'WORD'
    tokens[192][5] = 'NEW'
    tokens[192][7] = 'RUN'
    tokens[192][8] = 'OUPS'
    tokens[192][9] = 'HELP'
    tokens[192][10] = 'POKE'
    tokens[192][11] = 'DOKE'
    tokens[192][12] = 'CALL'
    tokens[192][15] = 'PING'
    tokens[192][16] = 'SHOOT'
    tokens[192][17] = 'EXPLODE'
    tokens[192][18] = 'ZAP'
    tokens[192][19] = 'NMI'
    tokens[192][20] = 'RESET'
    tokens[192][21] = 'WIDTH'
    tokens[192][22] = 'LWIDTH'
    tokens[192][23] = 'GRAB'
    tokens[192][24] = 'RELEASE'
    tokens[192][25] = 'LLIST'
    tokens[192][26] = 'MLIST'
    tokens[192][27] = 'SLIST'
    tokens[192][28] = 'LFEED'
    tokens[192][29] = 'AIDE'
    tokens[192][30] = 'FUNCTION'
    tokens[192][31] = 'MOVE'
    tokens[192][32] = 'HIMEM'
    tokens[192][33] = 'CURSOR'
    tokens[192][34] = 'LOUT'
    tokens[192][35] = 'WAIT'
    tokens[192][36] = 'PATTERN'
    tokens[192][39] = 'DRV$'
    tokens[192][41] = 'EXT$'
    tokens[192][42] = 'EXT'
    tokens[192][43] = 'TCOPY'
    tokens[192][44] = 'HCOPY'
    tokens[192][52] = 'AZERTY'
    tokens[192][53] = 'QWERTY'
    tokens[192][54] = 'FRENCH'
    tokens[192][55] = 'ACCENT'
    tokens[192][56] = 'DELETE'
    tokens[192][61] = 'ASCII'
    tokens[192][62] = 'TALK'
    tokens[192][72] = 'CLOCKOFF'
    tokens[192][73] = 'CLOCKSET'
    tokens[192][74] = 'SSPEED'
    tokens[192][75] = 'SMODE'
    tokens[192][76] = 'ERRLIST'
    tokens[192][77] = 'TIME'
    tokens[192][78] = 'TIME$'
    tokens[192][79] = 'LBUF'
    tokens[192][80] = 'SRBUF'
    tokens[192][81] = 'SEBUF'
    tokens[192][82] = 'PLOT'
    tokens[192][83] = 'POP'
    tokens[192][84] = 'SSAVEA'
    tokens[192][85] = 'SLOADA'
    tokens[192][86] = 'SLOAD'
    tokens[192][87] = 'SSAVE'
    tokens[192][88] = 'SDUMP'
    tokens[192][90] = 'CONSOLE'
    tokens[192][91] = 'MLOADA'
    tokens[192][92] = 'MSAVEA'
    tokens[192][93] = 'MLOAD'
    tokens[192][94] = 'MSAVE'
    tokens[192][95] = 'RING'
    tokens[192][96] = 'CONNECT'
    tokens[192][97] = 'WCXFIN'
    tokens[192][98] = 'UNCONNECT'
    tokens[192][99] = 'SOUT'
    tokens[192][100] = 'MOUT'
    tokens[192][101] = 'POS'
    tokens[192][104] = 'DIR'
    tokens[192][106] = 'DELBAK'
    tokens[192][112] = 'DEL'
    tokens[192][113] = 'PROT'
    tokens[192][114] = 'UNPROT'
    tokens[192][51] = 'INIT'
    tokens[192][116] = 'LOAD'
    tokens[192][117] = 'SAVEM'
    tokens[192][118] = 'SAVEO'
    tokens[192][119] = 'SAVEU'
    tokens[192][120] = 'SAVE'
    tokens[192][121] = 'BACKUP'
    tokens[192][123] = 'LDIR'
    tokens[192][124] = 'DNAME'
    tokens[192][125] = 'COPYO'
    tokens[192][126] = 'COPYM'
    tokens[192][127] = 'COPY'
    tokens[192][128] = 'REN'
    tokens[192][131] = 'ESAVE'
    tokens[192][132] = 'OPEN'
    tokens[192][133] = 'CLOSE'
    tokens[192][134] = 'PUT'
    tokens[192][135] = 'TAKE'
    tokens[192][136] = 'JUMP'
    tokens[192][137] = 'APPEND'
    tokens[192][138] = 'REWIND'
    tokens[192][139] = 'SPUT'
    tokens[192][140] = 'STAKE'
    tokens[192][143] = 'FST'
    tokens[192][144] = 'FILE'
    tokens[192][145] = 'MERGE'
    tokens[192][160] = 'CURSET'
    tokens[192][161] = 'CURMOV'
    tokens[192][162] = 'DRAW'
    tokens[192][163] = 'ADRAW'
    tokens[192][164] = 'CIRCLE'
    tokens[192][165] = 'BOX'
    tokens[192][166] = 'ABOX'
    tokens[192][167] = 'PAPER'
    tokens[192][168] = 'INK'
    tokens[192][169] = 'RADIAN'
    tokens[192][170] = 'DEGRE'
    tokens[192][172] = 'CLCH'
    tokens[192][173] = 'OPCH'
    tokens[192][174] = 'CROSSX'
    tokens[192][175] = 'CROSS'
    tokens[192][176] = 'RANDOM'
    tokens[192][177] = 'WINDOW'
    tokens[192][178] = 'PLAY'
    tokens[192][179] = 'SOUND'
    tokens[192][180] = 'MUSIC'
    tokens[192][182] = 'LORES'
    tokens[192][183] = 'LPR'
    tokens[192][184] = 'SEI'
    tokens[192][185] = 'CLI'
    tokens[192][192] = 'ERRNB'
    tokens[192][193] = 'ERRNL'
    tokens[192][194] = 'ERROR'
    tokens[192][195] = 'RESUME'
    tokens[192][196] = 'ERROFF'
    tokens[192][197] = 'CLEAR'
    tokens[192][198] = 'VCOPY'
    tokens[192][204] = 'DIM'
    tokens[192][205] = 'FRE'
    tokens[192][206] = 'PAGE$'
    tokens[192][207] = 'SERVEUR'
    tokens[192][208] = 'MINITEL'
    tokens[192][209] = 'APLIC'
    tokens[192][210] = 'TINPUT'
    tokens[192][212] = 'MIDDLE$'
    tokens[192][213] = 'NOT'
    tokens[192][214] = 'FILL'
    tokens[192][215] = 'CHAR'
    tokens[192][216] = 'SCHAR'
    tokens[192][217] = 'CONT'

    return tokens

def controle_car(chaine):
    csi = chr(27)+'['
    accents = {
        '`': chr(184),
        '@': 'à',
        '{': 'é',
        '}': 'è',
        '~': 'ê',
        '|': 'ù',
        '\\': 'ç'
        }

    couleurs = {}
    for i in range(0, 8):
        couleurs[chr(0x90+i)] = csi+('1;%sm' % (i+40))+' '
        couleurs[chr(0x80+i)] = csi+('1;%sm' % (i+30))+' '

    for code, car in accents.items():
        chaine = chaine.replace(code, car)

    for code, car in couleurs.items():
        chaine = chaine.replace(code, car)

    if chr(27) in chaine:
        chaine += csi+'0m'

    chaine = chaine.replace('{', 'é')

    return chaine


def dump(src, offset=0, length=16):
    N=0; result=''
    while src:
        s,src = src[:length],src[length:]
        hexa = ' '.join(["%02X"%ord(x) for x in s])
        s = s.translate(FILTER)
        result += "%04X   %-*s   %s\n" % (N+offset, length*3, hexa, s)
        N+=length
    return result

def debug(chaine):
    if fDebug:
        print(chaine)

    return


def main():
    parser = argparse.ArgumentParser(prog='list', description='List Hyperbasic file', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('file', type=str, nargs='+', metavar='file', help='Hyperbasic filename')
    parser.add_argument('--color', '-c', default=False, action='store_true', help='Color output')
    parser.add_argument('--version', '-v', action='version', version= '%%(prog)s v%s' % __version__)

    args = parser.parse_args()

    # hyperbasic_dump(args.file[0])
    # table = load_table(args.file[0])
    list_source(args.file[0])


if __name__ == '__main__':
    main()

