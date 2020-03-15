import struct


def errmsg(ad, ad_max):

    i = 0
    while ad < ad_max:
        c = ord(f.read(1))
        mot = ''

        while c < 0x80:
            if c < 27:
                mot = mot + commun[c]
            else:
                mot = mot + chr(c)

            ad = ad + 1
            c = ord(f.read(1))

        c = c & 0x7f

        if c < 27:
            mot = mot + commun[c]
        else:
            mot = mot + chr(c)

        ad = ad + 1
        print i, mot
        i = i + 1

    return ad


ad = 0xdfb9

with open('original/hyperbas.rom', 'rb') as f:

    debut = f.read(ad - 0xc000)

    while True:
        lfa = struct.unpack('<H', f.read(2))[0]

        f.read(4)
        nfa_len = ord(f.read(1)) - 7

        nfa = f.read(nfa_len)

        nfa = nfa.replace('"', '\\"')
        if nfa == chr(0):
            nfa = 'null'

        print ''
        print 'range { start $%04x; end $%04x; type addrtable; name "%s_lfa"; };' % (ad, ad + 1, nfa)
        ad = ad + 2
        print 'range { start $%04x; end $%04x; type bytetable; name "%s_pfa"; };' % (ad, ad + 4, nfa)
        ad = ad + 5
        print 'range { start $%04x; end $%04x; type texttable; name "%s"; };' % (ad, ad + nfa_len - 1, nfa)
        ad = ad + nfa_len
        print 'range { start $%04x; end $%04x; type bytetable; };' % (ad, ad + 1)

        if lfa > ad:
            ad = lfa
            f.seek(ad - 0xc000, 0)

        else:
            break

    ad = 0xd5e0
    f.seek(ad - 0xc000, 0)
    commun = []
    i = 0
    while ad < 0xd697:
        c = ord(f.read(1))
        mot = ''

        while c < 0x80:
            mot = mot + chr(c)
            ad = ad + 1
            c = ord(f.read(1))

        mot = mot + chr(c & 0x7f)
        ad = ad + 1

        commun.append(mot)

    print "\nTable 1:\n"
    ad = errmsg(ad, 0xd771)
    print "\nTable 2:\n"
    ad = errmsg(ad, 0xd7d7)
    print "\nTable 3:\n"
    ad = errmsg(ad, 0xd831)
    print "\nTable 4:\n"
    ad = errmsg(ad, 0xd8a0)

f.close()
