; da65 V2.17 - Git d4088f9e
; Created:    2018-12-13 00:02:30
; Input file: hyperbas.rom
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
RES             := $0000
RESB            := $0002
DECDEB          := $0004                        ; Paramètres pour décalage
DECFIN          := $0006                        ; Paramètres pour décalage
DECCIB          := $0008                        ; Paramètres pour décalage
DECTRV          := $000A                        ; Paramètres pour décalage
TR0             := $000C                        ; Travail, utilisation par HyperBasic à déterminer
TR1             := $000D                        ; Travail, utilisation par HyperBasic à déterminer
TR2             := $000E                        ; Travail, utilisation par HyperBasic à déterminer
TR3             := $000F                        ; Travail, utilisation par HyperBasic à déterminer
TR4             := $0010                        ; Travail, utilisation par HyperBasic à déterminer
TR5             := $0011                        ; Travail, utilisation par HyperBasic à déterminer
TR6             := $0012                        ; Travail, utilisation par HyperBasic à déterminer
TR7             := $0013                        ; Travail, utilisation par HyperBasic à déterminer
DEFAFF          := $0014                        ; Caractère aà afficher par défaut lors de conversion décimale (justification)
SCEDEB          := $005C
SCEFIN          := $005E
FACC1E          := $0060
FACC1M          := $0061
FACC1S          := $0065
FACC1EX         := $0066
FACC1J          := $0067
FACC2E          := $0068
FACC2M          := $0069
FACC2S          := $006D
FACC2PS         := $006E
FLERR           := $008B                        ; 1:sortie par overflow, 3: division par 0
fFlags          := $008C                        ; b7: 0->TRACE OFF, 1->SET b6: 0->RELEASE/GRAB, b2: 0->ERROFF, 1->ERRGOTO
fTalk           := $008D                        ; Flag TALK, b7: 0->SET, 1->OFF
ptr00BE         := $00BE                        ; Pointeur pour xxx
ptr00C0         := $00C0                        ; Pointeur pour xxx

L0100           := $0100

TABDRV          := $0208                        ; Activation des lecteurs
DRVDEF          := $020C                        ; Numéro (0-3) du lecteur par défaut
FLGTEL          := $020D                        ; b7:1-> haute résolution, b6:1-> mode minitel, b5:1-> mode degrés (0->radian), b2:1->BONJOUR.COM existe, b1:1->imprimante CENTRONICS détectée, b0:1-> STRATSED absent
TIMES           := $0210                        ; Horloge: 1/10 secondes
TIMES           := $0211                        ; Horloge: secondes
TIMEM           := $0212                        ; Horloge: minutes
TIMEH           := $0213                        ; Horloge: heures
SCRX            := $0220                        ; Coordonnée X pour chaque fenêtre
SCRY            := $0224                        ; Coordonnée Y
SCRDX           := $0228                        ; Début de la fenêtre
SCRFX           := $022C                        ; Fin de la fenêtre
SCRDY           := $0230                        ; Début de la fenêtre
SCRFY           := $0234                        ; Fin de la fenêtre
KBDCTC          := $027E                        ; b7:1 Ctrl+C
LPRX            := $0286                        ; Position dans la ligne
LPRY            := $0287                        ; Position dans la page
LPRFX           := $0288                        ; Largeur d'impression
FLGLPR          := $028A                        ; Parametrage imprimante. b7: prete, b6: pas gerer CRLF, b2: RS232/Centronics, b1: echo SCR, b0: pas de CR apres LF
HRSPAT          := $02AA                        ; Pattern
HRSERR          := $02AB                        ; Indicateur d'erreur dans les paramètres
IOTAB1          := $02B2                        ; Table des IO pour le canal 1
IOTAB2          := $02B6                        ; Table des IO pour le canal 2
CSRND           := $02F0                        ; Nombre aleatoire (RANDOM)
vnmi            := $02F4                        ; Vecteur NMI (n° de banque, adresse)
virq            := $02FA                        ; Vecteur IRQ
vaplic          := $02FD                        ; N° banque, adresse TELEMATIC->LANGAGE

V1T1CL          := $0304                        ; VIA1 T1CL
V1T2CH          := $0309                        ; VIA1 T2CH
V2T1CL          := $0324                        ; VIA2 T1CL

ACIADR          := $031C                        ; ACIA Registre de Données
ACIASR          := $031D                        ; ACIA Registre d'état
ACIACR          := $031E                        ; ACIA Registre de Commande
ACIACT          := $031F                        ; ACIA Registre de Controle
v2dra           := $0321

EXBNK           := $040C
VEXBNK          := $0414
BNKCID          := $0417

DRIVE           := $0500                        ; N° de lecteur
SAVES           := $0513                        ; Sauvegarde de S avant appel au STRATSED
BUFNOM          := $0517                        ; Nom de fichier (drive+nom+extension)
VASALO0         := $0528                        ; Flag lecture/écriture
FTYPE           := $052C                        ; Type du fichier
DESALO          := $052D                        ; Adresse de début du fichier
FISALO          := $052F                        ; Adresse de fin du fichier
EXSALO          := $0531                        ; Adresse d'exécution
TAMPFC          := $0542                        ; Adresse de début des tampons fichier (initialisé à DOSBUFFERS par STARTUP)
BITMFC          := $0544                        ; (word) BitMap des tampons logiques (même convention que la BitMap disquette, 0->occupé, 1->libre))
FICNUM          := $0548                        ; Numéro logique du fichier (1 ou 2)
NBFIC           := $0549                        ; Nombre de fichiers autorisés par FILE
XFIELD          := $054C                        ; Pour fichier accès direct: xfield=n° de banque, xfield+1=adresse
EXTDEF          := $055D                        ; Extension par défaut
BUFEDT          := $0590                        ; Buffer Editeur de Texte

SP              := $0700                        ; Pointeur de la pile
Stack           := $0701                        ; Pile pour xxx
errnb           := $07B7                        ; Code erreur
errnl           := $07B8                        ; N° de la ligne contenant l'erreur ($ffff si mode direct)
errgotonl       := $07BA                        ; Adresse de la ligne pour le ERRGOTO
saveb_S         := $07BE                        ; Sauvegarde du registre S pendant l'exécution du programme compilé
L07C0           := $07C0                        ; Adresse code assembleur de la ligne courante?
L07EA           := $07EA                        ; BRK xx RTS
L07ED           := $07ED                        ; BRK fct RTS (utilisé pour les fonctions deTrigo)
savem_S         := $07F1                        ; Sauvegarde du registre S lors de l'appel à une appli Minitel
ptr_07F9        := $07F9                        ; Pointeur pour les chaines?
HIMEM_val       := $07FB                        ; Valeur de HIMEM (valeur initiale: $9800)
L07FD           := $07FD                        ; Pointeur pour ...
L0810           := $0810
L2710           := $2710
; ----------------------------------------------------------------------------
LC000:
        jmp     LFFAC                           ; C000 4C AC FF

; ----------------------------------------------------------------------------
        nop                                     ; C003 EA
        nop                                     ; C004 EA
LC005:
        ldx     #$00                            ; C005 A2 00
        stx     fFlags                          ; C007 86 8C
        stx     $07FF                           ; C009 8E FF 07
        stx     L07ED                           ; C00C 8E ED 07
        stx     L07EA                           ; C00F 8E EA 07
        ldx     #$80                            ; C012 A2 80
        stx     fTalk                           ; C014 86 8D
        dex                                     ; C016 CA
        stx     $02A2                           ; C017 8E A2 02

        lda     #$0D                            ; C01A A9 0D
        sta     $029F                           ; C01C 8D 9F 02

        ; Place un RTS
        lda     #$60                            ; C01F A9 60
        sta     L07ED+2                         ; C021 8D EF 07
        sta     L07EA+2                         ; C024 8D EC 07

        ; L07F3 := $0800
        lda     #$00                            ; C027 A9 00
        ldy     #$08                            ; C029 A0 08
        sta     $07F3                           ; C02B 8D F3 07
        sty     $07F4                           ; C02E 8C F4 07

        ; HIMEM := $9800
        ldy     #$98                            ; C031 A0 98
        sta     HIMEM_val                       ; C033 8D FB 07
        sty     HIMEM_val+1                     ; C036 8C FC 07

        jsr     LC384                           ; C039 20 84 C3

        ; Suavegarde la banque courante
        lda     v2dra                           ; C03C AD 21 03
        and     #$07                            ; C03F 29 07
        sta     vnmi                            ; C041 8D F4 02
        sta     vaplic                          ; C044 8D FD 02

        ; VNMI := $C068
        lda     #$68                            ; C047 A9 68
        ldy     #$C0                            ; C049 A0 C0
        sta     vnmi+1                          ; C04B 8D F5 02
        sty     vnmi+2                          ; C04E 8C F6 02

        ; VAPLIC := $FE8A
        lda     #$8A                            ; C051 A9 8A
        ldy     #$FE                            ; C053 A0 FE
        sta     vaplic+1                        ; C055 8D FE 02
        sty     vaplic+2                        ; C058 8C FF 02

        ; Si 'BONJOUR.COM' n'existe pas -> LC068
        lda     FLGTEL                          ; C05B AD 0D 02
        and     #$04                            ; C05E 29 04
        beq     LC068                           ; C060 F0 06

        ;'BONJOUR.COM' présent
        jsr     LC4DE                           ; C062 20 DE C4
        ; LOAD
        jsr     LF50B                           ; C065 20 0B F5

LC068:
        ldx     #$00                            ; C068 A2 00
        ldy     #$00                            ; C06A A0 00
        .byte   $2C                             ; C06C 2C

LC06D:
        ; Déplacement de 6 caractères à droite
        ldx     #$06                            ; C06D A2 06
LC06F:
        lda     #$01                            ; C06F A9 01
        sta     $9B                             ; C071 85 9B

        ; Place XWR0 en L07EA
        lda     #$10                            ; C073 A9 10
        sta     L07EA+1                         ; C075 8D EB 07

        ; Longueur maximale de la ligne: $6E
        lda     #$6E                            ; C078 A9 6E
        XEDT                                    ; C07A 00 2D
        ; ACC: mode de sortie de XEDT
        ; X: Début réel de la ligne (après le n° de la ligne)
        ; Y: nombre d'espaces en début de ligne
        ; RES: N° de ligne

        asl     KBDCTC                          ; C07C 0E 7E 02
        cmp     #$03                            ; C07F C9 03
        beq     LC068                           ; C081 F0 E5

        ; Sauvegarde Y et A en $8E-8F
        sty     $8E                             ; C083 84 8E
        sta     $8F                             ; C085 85 8F

        lda     fFlags                          ; C087 A5 8C
        ora     #$02                            ; C089 09 02
        sta     fFlags                          ; C08B 85 8C
        jsr     LC4DE                           ; C08D 20 DE C4

        ; Sauvegarde X sur la pile 6502
        txa                                     ; C090 8A
        pha                                     ; C091 48
        .byte   $24                             ; C092 24

LC093:
        ; Saute les espaces
        inx                                     ; C093 E8
        lda     BUFEDT,x                        ; C094 BD 90 05
        cmp     #$20                            ; C097 C9 20
        beq     LC093                           ; C099 F0 F8

        ; TR0-TR1 := BUFEDT+x
        ; ie (TR0) pointe au début réel de la ligne
        txa                                     ; C09B 8A
        clc                                     ; C09C 18
        adc     #$90                            ; C09D 69 90
        sta     TR0                             ; C09F 85 0C
        lda     #$00                            ; C0A1 A9 00
        adc     #$05                            ; C0A3 69 05
        sta     TR1                             ; C0A5 85 0D

        ; Cherche la fin de la ligne
        ldy     #$00                            ; C0A7 A0 00
LC0A9:
        lda     (TR0),y                         ; C0A9 B1 0C
        beq     LC0B0                           ; C0AB F0 03
        iny                                     ; C0AD C8
        bne     LC0A9                           ; C0AE D0 F9

LC0B0:
        ; mode HIRES?
        bit     FLGTEL                          ; C0B0 2C 0D 02
        bmi     LC0CF                           ; C0B3 30 1A

        ; Ici mode TEXT
        ; Sauvegarde RES-RES+1 en $00AE-00AF
        ; (RES contient le n° de la ligne après l'appel à XEDT)
        jsr     LC49B                           ; C0B5 20 9B C4

        ; Sauvegarde SCRX et SCRY
        lda     SCRX                            ; C0B8 AD 20 02
        pha                                     ; C0BB 48
        lda     SCRY                            ; C0BC AD 24 02
        pha                                     ; C0BF 48

        ;
        ldx     #$02                            ; C0C0 A2 02
        jsr     PrintErrMsg4                    ; C0C2 20 87 D5

        ; Restaure SCRX et SCRY et y replace le curseur
        pla                                     ; C0C5 68
        tay                                     ; C0C6 A8
        pla                                     ; C0C7 68
        tax                                     ; C0C8 AA
        jsr     LC3AB                           ; C0C9 20 AB C3

        ; Restaure RES-RES+1 depuis $00AE-00AF
        jsr     LC4A6                           ; C0CC 20 A6 C4

LC0CF:
        ; Valeur de X sauvegardée à la ligne $C090
        ; (début réel de la ligne)
        pla                                     ; C0CF 68
        bne     LC112                           ; C0D0 D0 40

        lda     #$03                            ; C0D2 A9 03
        sta     $02A8                           ; C0D4 8D A8 02
        sta     $02A6                           ; C0D7 8D A6 02
        ldy     #$00                            ; C0DA A0 00
        lda     (TR0),y                         ; C0DC B1 0C
        beq     LC14B                           ; C0DE F0 6B

        sec                                     ; C0E0 38
        lda     TR0                             ; C0E1 A5 0C
        sbc     #$90                            ; C0E3 E9 90
        tax                                     ; C0E5 AA

        ; Sauvegarde RES-RES+1 en $00AE-00AF
        jsr     LC49B                           ; C0E6 20 9B C4

        jsr     LC4E7                           ; C0E9 20 E7 C4

        ; Restaure RES-RES+1 depuis $00AE-00AF
        jsr     LC4A6                           ; C0EC 20 A6 C4

        bcs     LC14E                           ; C0EF B0 5D
        tya                                     ; C0F1 98
        tax                                     ; C0F2 AA
        jsr     LDA03                           ; C0F3 20 03 DA
        ; Affiche le curseur de la fenêtre 0
        ldx     #$00                            ; C0F6 A2 00
        XCSSCR                                  ; C0F8 00 35
        ; Ecrit le prompt
        XECRPR                                  ; C0FA 00 33

        ; Exécution de la ligne de commande
        jsr     LC10F                           ; C0FC 20 0F C1

LC0FF:
        sec                                     ; C0FF 38
        lda     SCRX                            ; C100 AD 20 02
        sbc     SCRDX                           ; C103 ED 28 02
        cmp     #$02                            ; C106 C9 02
        bcc     LC10C                           ; C108 90 02
        XCRLF                                   ; C10A 00 25
LC10C:
        jmp     LC068                           ; C10C 4C 68 C0

; ----------------------------------------------------------------------------
LC10F:
        jmp     (SCEFIN)                        ; C10F 6C 5E 00

; ----------------------------------------------------------------------------
; Entrée:
;        $8F: mode de sortie de XEDT
;        $8E: nombre d'espace en début de ligne
LC112:
        ; Mode de sortie par flèche bas?
        ldx     $8F                             ; C112 A6 8F
        cpx     #$0A                            ; C114 E0 0A
        beq     LC155                           ; C116 F0 3D

        ; Mode de sortie par flèche haut?
        cpx     #$0B                            ; C118 E0 0B
        beq     LC175                           ; C11A F0 59

        ; Ici mode de sortie: CTRL+C ou <RETURN>
        ldy     #$00                            ; C11C A0 00
        lda     (TR0),y                         ; C11E B1 0C
        beq     LC133                           ; C120 F0 11

        sec                                     ; C122 38
        lda     TR0                             ; C123 A5 0C
        sbc     #$90                            ; C125 E9 90
        tax                                     ; C127 AA

        ; Sauvegarde RES-RES+1 en $00AE-00AF
        jsr     LC49B                           ; C128 20 9B C4

        jsr     LC4E7                           ; C12B 20 E7 C4

        ; Restaure RES-RES+1 depuis $00AE-00AF
        jsr     LC4A6                           ; C12E 20 A6 C4

        bcs     LC14E                           ; C131 B0 1B
LC133:
        ;Insertion de ligne
        ; ACC: longueur utile
        ; TR0-TR1: adresse du buffer à insérer
        tya                                     ; C133 98
        XINSER                                  ; C134 00 2E
        ; Sortie: ligne insérée selon SCEDEB et SCEFIN
        ; différence dans AY et TR3-TR4

LC136:
        ; Ajoute AY à (L07FD-L07FE)
        ; Résultat aussi dans XA
        clc                                     ; C136 18
        adc     L07FD                           ; C137 6D FD 07
        sta     L07FD                           ; C13A 8D FD 07
        tax                                     ; C13D AA
        tya                                     ; C13E 98
        adc     L07FD+1                         ; C13F 6D FE 07
        sta     L07FD+1                         ; C142 8D FE 07

        ; Mise à jour des liens (fin lorsque le poids fort d'un lien = 0)
        ; Adresse premier lien dans XA, déplacement dans TR3-TR4
        jsr     LC3C2                           ; C145 20 C2 C3

        jsr     LC3DC                           ; C148 20 DC C3

LC14B:
        jmp     LC068                           ; C14B 4C 68 C0

; ----------------------------------------------------------------------------
LC14E:
        lda     #$0B                            ; C14E A9 0B
        XWR0                                    ; C150 00 10
        jmp     LC06F                           ; C152 4C 6F C0

; ----------------------------------------------------------------------------
; Traitement mode de sortie de XEDT par flèche bas
LC155:
        ; Recherche la ligne (RES)
        ;C=1 si trouvée
        XSCELG                                  ; C155 00 2F
        bcc     LC14B                           ; C157 90 F2

        clc                                     ; C159 18
        ldy     #$00                            ; C15A A0 00
        lda     (RESB),y                        ; C15C B1 02
        adc     RESB                            ; C15E 65 02
        sta     RESB                            ; C160 85 02
        bcc     LC166                           ; C162 90 02
        inc     RESB+1                          ; C164 E6 03
LC166:
        lda     (RESB),y                        ; C166 B1 02
        beq     LC172                           ; C168 F0 08
LC16A:
        jsr     LC224                           ; C16A 20 24 C2
        ldy     #$80                            ; C16D A0 80
        jmp     LC06D                           ; C16F 4C 6D C0

; ----------------------------------------------------------------------------
LC172:
        jmp     LC068                           ; C172 4C 68 C0

; ----------------------------------------------------------------------------
; Traitement mode de sortie de XEDT par flèche bas
LC175:
        ; Recherche la ligne (RES)
        ;C=1 si trouvée
        XSCELG                                  ; C175 00 2F
        bcc     LC1B7                           ; C177 90 3E

        ldy     #$01                            ; C179 A0 01
        lda     (SCEDEB),y                      ; C17B B1 5C
        cmp     RES                             ; C17D C5 00
        bne     LC188                           ; C17F D0 07
        iny                                     ; C181 C8
        lda     (SCEDEB),y                      ; C182 B1 5C
        cmp     RES+1                           ; C184 C5 01
        beq     LC1B7                           ; C186 F0 2F

LC188:
        lda     SCEDEB                          ; C188 A5 5C
        ldy     SCEDEB+1                        ; C18A A4 5D
        sta     RESB                            ; C18C 85 02
        sty     RESB+1                          ; C18E 84 03
LC190:
        ldy     #$00                            ; C190 A0 00
        lda     (RESB),y                        ; C192 B1 02
        tay                                     ; C194 A8
        tax                                     ; C195 AA
        iny                                     ; C196 C8
        lda     (RESB),y                        ; C197 B1 02
        cmp     RES                             ; C199 C5 00
        bne     LC1AB                           ; C19B D0 0E
        iny                                     ; C19D C8
        lda     (RESB),y                        ; C19E B1 02
        cmp     RES+1                           ; C1A0 C5 01
        bne     LC1AB                           ; C1A2 D0 07
        lda     #$0B                            ; C1A4 A9 0B
        XWR0                                    ; C1A6 00 10
        jmp     LC16A                           ; C1A8 4C 6A C1

; ----------------------------------------------------------------------------
LC1AB:
        txa                                     ; C1AB 8A
        clc                                     ; C1AC 18
        adc     RESB                            ; C1AD 65 02
        sta     RESB                            ; C1AF 85 02
        bcc     LC190                           ; C1B1 90 DD
        inc     RESB+1                          ; C1B3 E6 03
        bcs     LC190                           ; C1B5 B0 D9
LC1B7:
        lda     #$0B                            ; C1B7 A9 0B
        XWR0                                    ; C1B9 00 10
        jmp     LC068                           ; C1BB 4C 68 C0

; ----------------------------------------------------------------------------
LC1BE:
        lda     FACC1M                          ; C1BE A5 61
        ldy     FACC1M+1                        ; C1C0 A4 62
        ldx     $C9                             ; C1C2 A6 C9
        cpx     #$00                            ; C1C4 E0 00
        beq     LC1CC                           ; C1C6 F0 04
        lda     $9E                             ; C1C8 A5 9E
        ldy     $9F                             ; C1CA A4 9F
LC1CC:
        jsr     LD0ED                           ; C1CC 20 ED D0
        lda     ptr00C0                         ; C1CF A5 C0
        ldy     ptr00C0+1                       ; C1D1 A4 C1
        sta     RESB                            ; C1D3 85 02
        sty     RESB+1                          ; C1D5 84 03
        lda     #$FE                            ; C1D7 A9 FE
        ldy     #$FF                            ; C1D9 A0 FF
        ldx     $C9                             ; C1DB A6 C9
        cpx     #$00                            ; C1DD E0 00
        beq     LC1E5                           ; C1DF F0 04
        lda     FACC1M                          ; C1E1 A5 61
        ldy     FACC1M+1                        ; C1E3 A4 62
LC1E5:
        sec                                     ; C1E5 38
        adc     #$00                            ; C1E6 69 00
        bcc     LC1EB                           ; C1E8 90 01
        iny                                     ; C1EA C8
LC1EB:
        jsr     LD0ED                           ; C1EB 20 ED D0
        lda     #$02                            ; C1EE A9 02
        sta     $98                             ; C1F0 85 98
        rts                                     ; C1F2 60

; ----------------------------------------------------------------------------
LC1F3:
        jsr     LC1BE                           ; C1F3 20 BE C1
LC1F6:
        jsr     LC224                           ; C1F6 20 24 C2

        ; Teste si on a appuyé sur CTRL+C ou ESC (retour à la procédure appelante de la procédure appelante si oui)
        jsr     LF1C9                           ; C1F9 20 C9 F1

        ldy     #$00                            ; C1FC A0 00
        lda     (RESB),y                        ; C1FE B1 02
        beq     LC223                           ; C200 F0 21

        lda     #$0A                            ; C202 A9 0A
        jsr     L07EA                           ; C204 20 EA 07

        clc                                     ; C207 18
        ldy     #$00                            ; C208 A0 00
        lda     (RESB),y                        ; C20A B1 02
        adc     RESB                            ; C20C 65 02
        sta     RESB                            ; C20E 85 02
        tax                                     ; C210 AA
        lda     RESB+1                          ; C211 A5 03
        adc     #$00                            ; C213 69 00
        sta     RESB+1                          ; C215 85 03
        cmp     ptr00C0+1                       ; C217 C5 C1
        bcc     LC1F6                           ; C219 90 DB

        bne     LC223                           ; C21B D0 06

        cpx     ptr00C0                         ; C21D E4 C0
        bcc     LC1F6                           ; C21F 90 D5

        beq     LC1F6                           ; C221 F0 D3

LC223:
        rts                                     ; C223 60

; ----------------------------------------------------------------------------
LC224:
        lda     #$0D                            ; C224 A9 0D
        jsr     LC362                           ; C226 20 62 C3
        lda     #$7F                            ; C229 A9 7F
        jsr     LC362                           ; C22B 20 62 C3
        ldy     #$00                            ; C22E A0 00
        lda     (RESB),y                        ; C230 B1 02
        beq     LC223                           ; C232 F0 EF

        pha                                     ; C234 48
        iny                                     ; C235 C8
        lda     (RESB),y                        ; C236 B1 02
        pha                                     ; C238 48
        iny                                     ; C239 C8
        lda     (RESB),y                        ; C23A B1 02
        tay                                     ; C23C A8
        pla                                     ; C23D 68
        jsr     LD559                           ; C23E 20 59 D5
LC241:
        lda     L0100,x                         ; C241 BD 00 01
        beq     LC24C                           ; C244 F0 06

        jsr     L07EA                           ; C246 20 EA 07
        inx                                     ; C249 E8
        bne     LC241                           ; C24A D0 F5

LC24C:
        ldy     #$04                            ; C24C A0 04
        tax                                     ; C24E AA
        lda     (RESB),y                        ; C24F B1 02
        cmp     #$08                            ; C251 C9 08
        bcc     LC267                           ; C253 90 12

        cmp     #$12                            ; C255 C9 12
        bcs     LC265                           ; C257 B0 0C

        cmp     #$0D                            ; C259 C9 0D
        bcc     LC265                           ; C25B 90 08

        lda     $98                             ; C25D A5 98
        cmp     #$02                            ; C25F C9 02
        beq     LC265                           ; C261 F0 02

        dec     $98                             ; C263 C6 98
LC265:
        ldx     $98                             ; C265 A6 98
LC267:
        jsr     LC360                           ; C267 20 60 C3
        dex                                     ; C26A CA
        bpl     LC267                           ; C26B 10 FA

        pla                                     ; C26D 68
        sec                                     ; C26E 38
        sbc     #$04                            ; C26F E9 04
        tax                                     ; C271 AA
        stx     TR4                             ; C272 86 10
        ldy     #$04                            ; C274 A0 04
LC276:
        sty     TR5                             ; C276 84 11
        lda     (RESB),y                        ; C278 B1 02
        bmi     LC28E                           ; C27A 30 12

        cmp     #$20                            ; C27C C9 20
        bcc     LC28E                           ; C27E 90 0E

        ; Converti ACC-#$20 suivant la table LE468
        jsr     LC358                           ; C280 20 58 C3

LC283:
        jsr     LC362                           ; C283 20 62 C3
LC286:
        ldy     TR5                             ; C286 A4 11
        iny                                     ; C288 C8
        dec     TR4                             ; C289 C6 10
        bne     LC276                           ; C28B D0 E9

        rts                                     ; C28D 60

; ----------------------------------------------------------------------------
LC28E:
        sta     $96                             ; C28E 85 96
        cmp     #$08                            ; C290 C9 08
        bcc     LC29A                           ; C292 90 06

        cmp     #$0D                            ; C294 C9 0D
        bcs     LC29A                           ; C296 B0 02

        inc     $98                             ; C298 E6 98
LC29A:
        cmp     #$B0                            ; C29A C9 B0
        bcc     LC2AA                           ; C29C 90 0C

        cmp     #$C0                            ; C29E C9 C0
        bcc     LC31C                           ; C2A0 90 7A

        iny                                     ; C2A2 C8
        lda     (RESB),y                        ; C2A3 B1 02
        sty     TR5                             ; C2A5 84 11
        dec     TR4                             ; C2A7 C6 10
        .byte   $2C                             ; C2A9 2C
LC2AA:
        lda     #$00                            ; C2AA A9 00
        sta     $97                             ; C2AC 85 97
        lda     $96                             ; C2AE A5 96
        cmp     #$1D                            ; C2B0 C9 1D
        bcc     LC2BB                           ; C2B2 90 07

        cmp     #$20                            ; C2B4 C9 20
        bcs     LC2BB                           ; C2B6 B0 03

        jsr     LC360                           ; C2B8 20 60 C3
LC2BB:
        ; Cherche le type du token contenu en $96-97
        jsr     LCA8A                           ; C2BB 20 8A CA

        jmp     LC2C7                           ; C2BE 4C C7 C2

; ----------------------------------------------------------------------------
LC2C1:
        jmp     LC286                           ; C2C1 4C 86 C2

; ----------------------------------------------------------------------------
LC2C4:
        jmp     LC283                           ; C2C4 4C 83 C2

; ----------------------------------------------------------------------------
LC2C7:
        cmp     #$10                            ; C2C7 C9 10
        bne     LC2D0                           ; C2C9 D0 05

        lda     #$22                            ; C2CB A9 22
        jsr     LC362                           ; C2CD 20 62 C3
LC2D0:
        ldy     #$06                            ; C2D0 A0 06
        lda     ($92),y                         ; C2D2 B1 92
        sta     TR7                             ; C2D4 85 13
        cmp     #$07                            ; C2D6 C9 07
        beq     LC2E9                           ; C2D8 F0 0F

        iny                                     ; C2DA C8
LC2DB:
        lda     ($92),y                         ; C2DB B1 92
        sty     TR6                             ; C2DD 84 12
        jsr     LC362                           ; C2DF 20 62 C3
        ldy     TR6                             ; C2E2 A4 12
        iny                                     ; C2E4 C8
        cpy     TR7                             ; C2E5 C4 13
        bne     LC2DB                           ; C2E7 D0 F2

LC2E9:
        lda     $94                             ; C2E9 A5 94
        cmp     #$01                            ; C2EB C9 01
        beq     LC2FF                           ; C2ED F0 10

        cmp     #$03                            ; C2EF C9 03
        bne     LC314                           ; C2F1 D0 21

        lda     $96                             ; C2F3 A5 96
        cmp     #$1D                            ; C2F5 C9 1D
        bcc     LC314                           ; C2F7 90 1B

        cmp     #$20                            ; C2F9 C9 20
        bcs     LC314                           ; C2FB B0 17

        bcc     LC310                           ; C2FD 90 11

LC2FF:
        ldy     #$06                            ; C2FF A0 06
        lda     ($92),y                         ; C301 B1 92
        tay                                     ; C303 A8
        lda     ($92),y                         ; C304 B1 92
        cmp     #$80                            ; C306 C9 80
        beq     LC2C1                           ; C308 F0 B7

        ldy     #$04                            ; C30A A0 04
        lda     ($92),y                         ; C30C B1 92
        beq     LC2C4                           ; C30E F0 B4

LC310:
        lda     #$20                            ; C310 A9 20
        bne     LC2C4                           ; C312 D0 B0

LC314:
        cmp     #$10                            ; C314 C9 10
        bne     LC2C1                           ; C316 D0 A9

        lda     #$22                            ; C318 A9 22
        bne     LC2C4                           ; C31A D0 A8

LC31C:
        cmp     #$B2                            ; C31C C9 B2
        bcc     LC32B                           ; C31E 90 0B

        cmp     #$B6                            ; C320 C9 B6
        bcs     LC32B                           ; C322 B0 07

        pha                                     ; C324 48
        jsr     LC360                           ; C325 20 60 C3
        pla                                     ; C328 68
        clc                                     ; C329 18
        .byte   $24                             ; C32A 24
LC32B:
        sec                                     ; C32B 38
        php                                     ; C32C 08
        sec                                     ; C32D 38
        sbc     #$B0                            ; C32E E9 B0
        tax                                     ; C330 AA
        ldy     #$FF                            ; C331 A0 FF

        ; Saute les X premiers éléments de la table InstParam_table
LC333:
        dex                                     ; C333 CA
        bmi     LC33E                           ; C334 30 08

LC336:
        iny                                     ; C336 C8
        lda     InstParam_table,y               ; C337 B9 98 EB
        bpl     LC336                           ; C33A 10 FA

        bmi     LC333                           ; C33C 30 F5

LC33E:
        iny                                     ; C33E C8
        lda     InstParam_table,y               ; C33F B9 98 EB
        php                                     ; C342 08
        and     #$7F                            ; C343 29 7F
        sty     TR6                             ; C345 84 12
        jsr     LC362                           ; C347 20 62 C3
        ldy     TR6                             ; C34A A4 12
        plp                                     ; C34C 28
        bpl     LC33E                           ; C34D 10 EF

        plp                                     ; C34F 28
        bcs     LC355                           ; C350 B0 03

        jsr     LC360                           ; C352 20 60 C3

LC355:
        jmp     LC286                           ; C355 4C 86 C2

; ----------------------------------------------------------------------------
; Converti ACC suivant la table LE468
LC358:
        sec                                     ; C358 38
        sbc     #$20                            ; C359 E9 20
        tay                                     ; C35B A8
        lda     LE468,y                         ; C35C B9 68 E4
        rts                                     ; C35F 60

; ----------------------------------------------------------------------------
LC360:
        lda     #$20                            ; C360 A9 20
LC362:
        pha                                     ; C362 48
        lda     $9B                             ; C363 A5 9B
        lsr     a                               ; C365 4A
        bcc     LC36C                           ; C366 90 04

        pla                                     ; C368 68
        XEDTIN                                  ; C369 00 32
        rts                                     ; C36B 60

; ----------------------------------------------------------------------------
LC36C:
        pla                                     ; C36C 68
        cmp     #$7F                            ; C36D C9 7F
        beq     LC377                           ; C36F F0 06
        .byte   $2C                             ; C371 2C
LC372:
        lda     #$20                            ; C372 A9 20
        jmp     L07EA                           ; C374 4C EA 07

; ----------------------------------------------------------------------------
LC377:
        lda     $9B                             ; C377 A5 9B
        cmp     #$40                            ; C379 C9 40
        beq     LC383                           ; C37B F0 06

        lda     $9B                             ; C37D A5 9B
        bne     LC372                           ; C37F D0 F1
        XECRPR                                  ; C381 00 33

LC383:
        rts                                     ; C383 60

; ----------------------------------------------------------------------------
LC384:
        ; SCEDEB := $0800
        lda     #$00                            ; C384 A9 00
        ldy     #$08                            ; C386 A0 08
        sta     SCEDEB                          ; C388 85 5C
        sty     SCEDEB+1                        ; C38A 84 5D
        ; SCEFIN := $0807
        lda     #$07                            ; C38C A9 07
        sta     SCEFIN                          ; C38E 85 5E
        sty     SCEFIN+1                        ; C390 84 5F
        ; $07FD := $0801
        lda     #$01                            ; C392 A9 01
        sta     L07FD                           ; C394 8D FD 07
        sty     L07FD+1                         ; C397 8C FE 07

        ; Initialise $0800->$0807 avec des $00
        lda     #$00                            ; C39A A9 00
        ldy     #$07                            ; C39C A0 07
LC39E:
        sta     (SCEDEB),y                      ; C39E 91 5C
        dey                                     ; C3A0 88
        bpl     LC39E                           ; C3A1 10 FB

        ; Place un $D0 en $0805
        lda     #$D0                            ; C3A3 A9 D0
        sta     $0805                           ; C3A5 8D 05 08

        ; CLEAR
        jmp     LFDA5                           ; C3A8 4C A5 FD

; ----------------------------------------------------------------------------
LC3AB:
        lda     #$1F                            ; C3AB A9 1F
        XWR0                                    ; C3AD 00 10
        tya                                     ; C3AF 98
        clc                                     ; C3B0 18
        adc     #$40                            ; C3B1 69 40
        XWR0                                    ; C3B3 00 10
        bit     FLGTEL                          ; C3B5 2C 0D 02
        bvc     LC3BB                           ; C3B8 50 01
        inx                                     ; C3BA E8
LC3BB:
        txa                                     ; C3BB 8A
        clc                                     ; C3BC 18
        adc     #$40                            ; C3BD 69 40
        XWR0                                    ; C3BF 00 10
        rts                                     ; C3C1 60

; ----------------------------------------------------------------------------
; Mise à jour des liens (fin lorsque le poids fort d'un lien = 0)
;
; Entrée:
;       XA: Adresse du premier lien
;       TR3-TR4 contient le déplacement qui est ajouté à chaque lien
LC3C2:
        ; Sauvegarde XA dans TR0-TR1
        stx     TR0                             ; C3C2 86 0C
        sta     TR1                             ; C3C4 85 0D

        ldy     #$00                            ; C3C6 A0 00
        clc                                     ; C3C8 18
        lda     (TR0),y                         ; C3C9 B1 0C
        adc     TR3                             ; C3CB 65 0F
        sta     (TR0),y                         ; C3CD 91 0C
        tax                                     ; C3CF AA
        iny                                     ; C3D0 C8
        lda     (TR0),y                         ; C3D1 B1 0C
        beq     LC3DB                           ; C3D3 F0 06

        adc     TR4                             ; C3D5 65 10
        sta     (TR0),y                         ; C3D7 91 0C
        bne     LC3C2                           ; C3D9 D0 E7

LC3DB:
        rts                                     ; C3DB 60

; ----------------------------------------------------------------------------
LC3DC:
        jsr     LCAE8                           ; C3DC 20 E8 CA

        ; Copie le pointeur SCEDEB en TR0
        lda     SCEDEB                          ; C3DF A5 5C
        ldy     SCEDEB+1                        ; C3E1 A4 5D
        sta     TR0                             ; C3E3 85 0C
        sty     TR1                             ; C3E5 84 0D

LC3E7:
        ; Récupère la longueur de la ligne
        ; Si nulle -> LC42C
        ldy     #$00                            ; C3E7 A0 00
        lda     (TR0),y                         ; C3E9 B1 0C
        beq     LC42C                           ; C3EB F0 3F

        ; TR2 := longueur de la ligne -4
        sec                                     ; C3ED 38
        sbc     #$04                            ; C3EE E9 04
        sta     TR2                             ; C3F0 85 0E

        ; Y := index pour parcourir la ligne
        ldy     #$03                            ; C3F2 A0 03
LC3F4:
        ; Si fin de la ligne atteinte -> LC41D
        iny                                     ; C3F4 C8
        dec     TR2                             ; C3F5 C6 0E
        bmi     LC41D                           ; C3F7 30 24

        ; Token instruction <#$C0? -> boucle
        lda     (TR0),y                         ; C3F9 B1 0C
        cmp     #$C0                            ; C3FB C9 C0
        bcc     LC3F4                           ; C3FD 90 F5

        ; Sauvegarde le Token en $96
        sta     $96                             ; C3FF 85 96

        ; Incrémente Y (Token >=#$C0 sur 2 octets)
        ; Token < #$D0? -> Boucle
        iny                                     ; C401 C8
        dec     TR2                             ; C402 C6 0E
        cmp     #$D0                            ; C404 C9 D0
        bcc     LC3F4                           ; C406 90 EC

        ; Ici le token est >=#C0 >= #$D0
        ; Sauvegardele token suivant en $97
        lda     (TR0),y                         ; C408 B1 0C
        sta     $97                             ; C40A 85 97

        ; Cherche le type du token contenu en $96-97
        jsr     LCA8A                           ; C40C 20 8A CA

        tya                                     ; C40F 98
        pha                                     ; C410 48
        ldy     #$03                            ; C411 A0 03
        lda     ($92),y                         ; C413 B1 92
        ora     #$80                            ; C415 09 80
        sta     ($92),y                         ; C417 91 92
        pla                                     ; C419 68
        tay                                     ; C41A A8
        bpl     LC3F4                           ; C41B 10 D7

LC41D:
        ; Ajoute (TR0),0 à TR0-TR1
        ; ie: passe à la ligne suivante
        ldy     #$00                            ; C41D A0 00
        clc                                     ; C41F 18
        lda     (TR0),y                         ; C420 B1 0C
        adc     TR0                             ; C422 65 0C
        sta     TR0                             ; C424 85 0C
        bcc     LC3E7                           ; C426 90 BF
        inc     TR1                             ; C428 E6 0D
        bcs     LC3E7                           ; C42A B0 BB


LC42C:
        ldx     L07FD                           ; C42C AE FD 07
        lda     L07FD+1                         ; C42F AD FE 07
LC432:
        stx     $92                             ; C432 86 92
        sta     $93                             ; C434 85 93

LC436:
        ldy     #$01                            ; C436 A0 01
        lda     ($92),y                         ; C438 B1 92
        beq     LC48D                           ; C43A F0 51

        ldy     #$03                            ; C43C A0 03
        lda     ($92),y                         ; C43E B1 92
        bpl     LC450                           ; C440 10 0E

        and     #$7F                            ; C442 29 7F
        sta     ($92),y                         ; C444 91 92
        ldy     #$00                            ; C446 A0 00
        lda     ($92),y                         ; C448 B1 92
        tax                                     ; C44A AA
        iny                                     ; C44B C8
        lda     ($92),y                         ; C44C B1 92
        bne     LC432                           ; C44E D0 E2

LC450:
        ; Déplacement d'un bloc mémoire:
        ;    Cible := $92-93
        ;    Source := ($92-93),0
        ;    Fin du bloc:= SCEFIN
        ;
        ; Déplacement pour plus tard := $92-93 - ($92-93),0
        sec                                     ; C450 38
        ldy     #$00                            ; C451 A0 00
        lda     $92                             ; C453 A5 92
        sta     DECCIB                          ; C455 85 08
        sbc     ($92),y                         ; C457 F1 92
        sta     TR3                             ; C459 85 0F
        iny                                     ; C45B C8
        lda     $93                             ; C45C A5 93
        sta     DECCIB+1                        ; C45E 85 09
        sbc     ($92),y                         ; C460 F1 92
        sta     TR4                             ; C462 85 10
        lda     ($92),y                         ; C464 B1 92
        sta     DECDEB+1                        ; C466 85 05
        dey                                     ; C468 88
        lda     ($92),y                         ; C469 B1 92
        sta     DECDEB                          ; C46B 85 04
        lda     SCEFIN                          ; C46D A5 5E
        ldy     SCEFIN+1                        ; C46F A4 5F
        sta     DECFIN                          ; C471 85 06
        sty     DECFIN+1                        ; C473 84 07
        ; Décale le bloc de DECDEB à DECFIN vers DECCIB
        XDECAL                                  ; C475 00 18

        ; Mise à jour des liens (fin lorsque le poids fort d'un lien = 0)
        ; Adresse premier lien dans XA, déplacement dans TR3-TR4
        lda     $92                             ; C477 A5 92
        pha                                     ; C479 48
        tax                                     ; C47A AA
        lda     $93                             ; C47B A5 93
        pha                                     ; C47D 48
        jsr     LC3C2                           ; C47E 20 C2 C3

        jsr     LCAE8                           ; C481 20 E8 CA

        ; Restaure $92-93
        pla                                     ; C484 68
        sta     $93                             ; C485 85 93
        pla                                     ; C487 68
        sta     $92                             ; C488 85 92

        ; Boucle
        jmp     LC436                           ; C48A 4C 36 C4

; ----------------------------------------------------------------------------
; Met à jour SCEFIN : $92-93 + #$06
LC48D:
        clc                                     ; C48D 18
        lda     $92                             ; C48E A5 92
        adc     #$06                            ; C490 69 06
        sta     SCEFIN                          ; C492 85 5E
        lda     $93                             ; C494 A5 93
        adc     #$00                            ; C496 69 00
        sta     SCEFIN+1                        ; C498 85 5F
        rts                                     ; C49A 60

; ----------------------------------------------------------------------------
; Sauvegarde RES-RES+1 en $00AE-00AF
LC49B:
        pha                                     ; C49B 48
        lda     RES                             ; C49C A5 00
        sta     $AE                             ; C49E 85 AE
        lda     RES+1                           ; C4A0 A5 01
        sta     $AF                             ; C4A2 85 AF
        pla                                     ; C4A4 68
        rts                                     ; C4A5 60

; ----------------------------------------------------------------------------
; Restaure RES-RES+1 depuis $00AE-00AF
LC4A6:
        pha                                     ; C4A6 48
        lda     $AE                             ; C4A7 A5 AE
        sta     RES                             ; C4A9 85 00
        lda     $AF                             ; C4AB A5 AF
        sta     RES+1                           ; C4AD 85 01
        pla                                     ; C4AF 68
        rts                                     ; C4B0 60

; ----------------------------------------------------------------------------
LC4B1:
        jsr     LC1BE                           ; C4B1 20 BE C1
        sec                                     ; C4B4 38
        lda     RESB                            ; C4B5 A5 02
        sta     DECCIB                          ; C4B7 85 08
        sbc     ptr00C0                         ; C4B9 E5 C0
        sta     TR3                             ; C4BB 85 0F
        lda     RESB+1                          ; C4BD A5 03
        sta     DECCIB+1                        ; C4BF 85 09
        sbc     ptr00C0+1                       ; C4C1 E5 C1
        sta     TR4                             ; C4C3 85 10
        lda     ptr00C0                         ; C4C5 A5 C0
        ldy     ptr00C0+1                       ; C4C7 A4 C1
        sta     DECDEB                          ; C4C9 85 04
        sty     DECDEB+1                        ; C4CB 84 05
        lda     SCEFIN                          ; C4CD A5 5E
        ldy     SCEFIN+1                        ; C4CF A4 5F
        sta     DECFIN                          ; C4D1 85 06
        sty     DECFIN+1                        ; C4D3 84 07
        XDECAL                                  ; C4D5 00 18

        lda     TR3                             ; C4D7 A5 0F
        ldy     TR4                             ; C4D9 A4 10
        jmp     LC136                           ; C4DB 4C 36 C1

; ----------------------------------------------------------------------------
LC4DE:
        lda     #$00                            ; C4DE A9 00
        sta     FLERR                           ; C4E0 85 8B
        sta     $C2                             ; C4E2 85 C2
        sta     FACC1J                          ; C4E4 85 67
        rts                                     ; C4E6 60

; ----------------------------------------------------------------------------
LC4E7:
        ; Sauvegarde X en $C4
        stx     $C4                             ; C4E7 86 C4
        ; $B0 / 2
        lsr     $B0                             ; C4E9 46 B0
        ; $C2 := #$05
        ldy     #$05                            ; C4EB A0 05
        sty     $C2                             ; C4ED 84 C2
        ; $C5 := #$01
        ldy     #$01                            ; C4EF A0 01
        sty     $C5                             ; C4F1 84 C5

        ; Fin de ligne?
        lda     BUFEDT,x                        ; C4F3 BD 90 05
        bne     LC4FA                           ; C4F6 D0 02

        clc                                     ; C4F8 18
        rts                                     ; C4F9 60

; ----------------------------------------------------------------------------
LC4FA:
        ; Restaure X
        ldx     $C4                             ; C4FA A6 C4
        ; Caractère courant = "?"
        lda     BUFEDT,x                        ; C4FC BD 90 05
        cmp     #$3F                            ; C4FF C9 3F
        bne     LC50E                           ; C501 D0 0B

        ; Oui
        ; Recule de 4 caractères
        txa                                     ; C503 8A
        sbc     #$04                            ; C504 E9 04
        sta     $C4                             ; C506 85 C4
        ; AY := #$E8E9
        lda     #$E9                            ; C508 A9 E9
        ldy     #$E8                            ; C50A A0 E8
        bne     LC560                           ; C50C D0 52

LC50E:
        ; Cherche une instruction de type 1
        ldx     #$01                            ; C50E A2 01
        jsr     LCA05                           ; C510 20 05 CA
        bcc     LC55C                           ; C513 90 47

        ldx     $C4                             ; C515 A6 C4
LC517:
        lda     BUFEDT,x                        ; C517 BD 90 05
        beq     LC54B                           ; C51A F0 2F

        ; Caractère ":"?
        cmp     #$3A                            ; C51C C9 3A
        beq     LC54B                           ; C51E F0 2B

        ; Caractère "="?
        cmp     #$3D                            ; C520 C9 3D
        beq     LC527                           ; C522 F0 03

        ; Caractère suivant
        inx                                     ; C524 E8
        bne     LC517                           ; C525 D0 F0

; Traitement affectation
LC527:
        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        lda     #$AA                            ; C527 A9 AA
        jsr     LCA7A                           ; C529 20 7A CA

        jsr     LC909                           ; C52C 20 09 C9

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$07                            ; C52F A2 07
        jsr     LC676                           ; C531 20 76 C6
        bcs     LC5B1                           ; C534 B0 7B

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$08                            ; C536 A2 08
        jsr     LC676                           ; C538 20 76 C6
        bcs     LC5B1                           ; C53B B0 74

        ldx     #$02                            ; C53D A2 02
        lda     $94                             ; C53F A5 94
        cmp     #$08                            ; C541 C9 08
        beq     LC54A                           ; C543 F0 05

        cmp     #$0C                            ; C545 C9 0C
        beq     LC54A                           ; C547 F0 01

        dex                                     ; C549 CA
LC54A:
        .byte   $2C                             ; C54A 2C

; Traitement instruction
LC54B:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0C                            ; C54B A2 0C
        jsr     LC676                           ; C54D 20 76 C6
        bcs     LC5B1                           ; C550 B0 5F

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C552 20 88 C6

        ; Caractère suivant ":"?
        cmp     #$3A                            ; C555 C9 3A
        beq     LC576                           ; C557 F0 1D

        jmp     LC5DA                           ; C559 4C DA C5

; ----------------------------------------------------------------------------
LC55C:
        lda     $92                             ; C55C A5 92
        ldy     $93                             ; C55E A4 93

LC560:
        ; Calcule la taille du LM de l'instruction à compiler
        jsr     LCE02                           ; C560 20 02 CE

        ; TR0-TR1 := pointeur sur la définition de l'instruction à compiler
        lda     $92                             ; C563 A5 92
        ldy     $93                             ; C565 A4 93
        sta     TR0                             ; C567 85 0C
        sty     TR1                             ; C569 84 0D

        ; $C6 := Offset vers la caractère suivant le nom de l'instruction
        ldy     #$06                            ; C56B A0 06
        lda     (TR0),y                         ; C56D B1 0C
        sta     $C6                             ; C56F 85 C6

        ; =#$80?
        tay                                     ; C571 A8
        lda     (TR0),y                         ; C572 B1 0C
        cmp     #$80                            ; C574 C9 80
LC576:
        beq     LC5B5                           ; C576 F0 3D

        dec     $C6                             ; C578 C6 C6

LC57A:
        ; Prend le paramètre suivant dans la définition (après le nom de l'instruction)
        inc     $C6                             ; C57A E6 C6
        ldy     $C6                             ; C57C A4 C6
        lda     (TR0),y                         ; C57E B1 0C

        ; Sauvegarde dans X
        tax                                     ; C580 AA

        ; paramètre du type #$Cn?
        and     #$E0                            ; C581 29 E0
        cmp     #$C0                            ; C583 C9 C0
        beq     LC593                           ; C585 F0 0C

        ; Non -> x2 et -> LC59A si <#$80
        asl     a                               ; C587 0A
        bpl     LC59A                           ; C588 10 10

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        txa                                     ; C58A 8A
        and     #$3F                            ; C58B 29 3F
        jsr     LCA69                           ; C58D 20 69 CA

        jmp     LC5A2                           ; C590 4C A2 C5

; ----------------------------------------------------------------------------
; Traitement d'un paramètre du type #$Cn
LC593:
        jsr     LC65E                           ; C593 20 5E C6
        bcs     LC5B1                           ; C596 B0 19
        bcc     LC5B5                           ; C598 90 1B

LC59A:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        jsr     LC676                           ; C59A 20 76 C6
        bcc     LC5A2                           ; C59D 90 03

        jmp     PrintAttentionMsg               ; C59F 4C 33 C6

; ----------------------------------------------------------------------------
LC5A2:
        ldy     $C6                             ; C5A2 A4 C6
        lda     (TR0),y                         ; C5A4 B1 0C
        bmi     LC5B5                           ; C5A6 30 0D
        and     #$20                            ; C5A8 29 20
        bne     LC57A                           ; C5AA D0 CE

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$09                            ; C5AC A2 09
        jsr     LC676                           ; C5AE 20 76 C6

LC5B1:
        bcs     LC5F4                           ; C5B1 B0 41
        bcc     LC57A                           ; C5B3 90 C5


; Traitement pour les instructions dont le premier octet suivant le nom est #$80
LC5B5:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C5B5 20 88 C6

        ; Caractère ":"?
        cmp     #$3A                            ; C5B8 C9 3A
        bne     LC5C7                           ; C5BA D0 0B

        ; Oui, on passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; C5BC 20 86 C6

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$20                            ; C5BF A9 20
        jsr     LCA69                           ; C5C1 20 69 CA

        jmp     LC4FA                           ; C5C4 4C FA C4

; ----------------------------------------------------------------------------
LC5C7:
        ; Récupère le token de l'instruction à compiler
        ldy     #$04                            ; C5C7 A0 04
        lda     (TR0),y                         ; C5C9 B1 0C

        ; Token = #$AB?
        cmp     #$AB                            ; C5CB C9 AB
        bne     LC5DA                           ; C5CD D0 0B

        ; Oui
        jsr     LC90C                           ; C5CF 20 0C C9
        sec                                     ; C5D2 38
        ror     $B0                             ; C5D3 66 B0
        jsr     LCCCC                           ; C5D5 20 CC CC
        bcs     LC5FD                           ; C5D8 B0 23

LC5DA:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C5DA 20 88 C6

        tax                                     ; C5DD AA
        beq     LC603                           ; C5DE F0 23

        cmp     #$27                            ; C5E0 C9 27
        beq     LC600                           ; C5E2 F0 1C

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$00                            ; C5E4 A2 00
        jsr     LC676                           ; C5E6 20 76 C6
        bcc     LC5FD                           ; C5E9 90 12

        bit     $B0                             ; C5EB 24 B0
        bpl     PrintAttentionMsg               ; C5ED 10 44

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$13                            ; C5EF A2 13
        jsr     LC676                           ; C5F1 20 76 C6

LC5F4:
        bcs     PrintAttentionMsg               ; C5F4 B0 3D

        lsr     $B0                             ; C5F6 46 B0
        jsr     LCCCC                           ; C5F8 20 CC CC
        bcc     LC5DA                           ; C5FB 90 DD

LC5FD:
        jsr     LC909                           ; C5FD 20 09 C9

LC600:
        jmp     LC4FA                           ; C600 4C FA C4

; ----------------------------------------------------------------------------
LC603:
        jsr     LCAEE                           ; C603 20 EE CA

        lda     #$00                            ; C606 A9 00
        ldy     #$06                            ; C608 A0 06
        sta     TR0                             ; C60A 85 0C
        sty     TR1                             ; C60C 84 0D
        lda     $0601                           ; C60E AD 01 06
        ldx     $0602                           ; C611 AE 02 06
        cpx     #$CC                            ; C614 E0 CC
        bne     LC61C                           ; C616 D0 04

        cmp     #$C0                            ; C618 C9 C0
        beq     LC627                           ; C61A F0 0B

LC61C:
        ; Test de ACC -> Z=0 si ACC € [$00, $09, $0F, $10, $05, $A0, $A1, $A3]
        jsr     LDF9A                           ; C61C 20 9A DF
        bne     LC62A                           ; C61F D0 09

        sec                                     ; C621 38
        lda     $C2                             ; C622 A5 C2
        sbc     #$05                            ; C624 E9 05
        .byte   $2C                             ; C626 2C
LC627:
        lda     #$00                            ; C627 A9 00
        .byte   $2C                             ; C629 2C
LC62A:
        lda     $C2                             ; C62A A5 C2
        sta     $0600                           ; C62C 8D 00 06
        ldy     $C5                             ; C62F A4 C5
        clc                                     ; C631 18
        rts                                     ; C632 60

; ----------------------------------------------------------------------------
; Affiche 'Attention: '+msg erreur sur la ligne de status. Code erreur dans $CA
PrintAttentionMsg:
        bit     FLGTEL                          ; C633 2C 0D 02
        bmi     LC654                           ; C636 30 1C
        lda     SCRX                            ; C638 AD 20 02
        pha                                     ; C63B 48
        lda     SCRY                            ; C63C AD 24 02
        pha                                     ; C63F 48
        ldx     #$00                            ; C640 A2 00
        jsr     PrintErrMsg2                    ; C642 20 81 D5
        ldy     $CA                             ; C645 A4 CA
        ldx     AtnMsg_table,y                  ; C647 BE CA C6
        jsr     PrintErrMsg2                    ; C64A 20 81 D5

        ; Place le curseur en X,Y
        pla                                     ; C64D 68
        tay                                     ; C64E A8
        pla                                     ; C64F 68
        tax                                     ; C650 AA
        jsr     LC3AB                           ; C651 20 AB C3

LC654:
        clc                                     ; C654 18
        lda     $C4                             ; C655 A5 C4
        adc     $8E                             ; C657 65 8E
        tax                                     ; C659 AA
        sec                                     ; C65A 38
        ldy     #$80                            ; C65B A0 80
        rts                                     ; C65D 60

; ----------------------------------------------------------------------------
LC65E:
        inc     $C6                             ; C65E E6 C6
        iny                                     ; C660 C8
        clc                                     ; C661 18
        lda     (TR0),y                         ; C662 B1 0C
        adc     TR0                             ; C664 65 0C
        tax                                     ; C666 AA
        dey                                     ; C667 88
        lda     (TR0),y                         ; C668 B1 0C
        and     #$1F                            ; C66A 29 1F
        adc     TR1                             ; C66C 65 0D
        pha                                     ; C66E 48
        txa                                     ; C66F 8A
        pha                                     ; C670 48

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jmp     LC688                           ; C671 4C 88 C6

; ----------------------------------------------------------------------------
; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
LC674:
        ldx     #$01                            ; C674 A2 01

; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
LC676:
        txa                                     ; C676 8A
        and     #$1F                            ; C677 29 1F
        sta     $CA                             ; C679 85 CA
        asl     a                               ; C67B 0A
        tax                                     ; C67C AA
        lda     LC69C+1,x                       ; C67D BD 9D C6
        pha                                     ; C680 48
        lda     LC69C,x                         ; C681 BD 9C C6
        pha                                     ; C684 48
        .byte   $2C                             ; C685 2C

LC686:
        ; Passe au caractère suivant dans BUFEDT
        inc     $C4                             ; C686 E6 C4

LC688:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        ldx     $C4                             ; C688 A6 C4
        lda     BUFEDT,x                        ; C68A BD 90 05
        cmp     #$20                            ; C68D C9 20
        bne     LC695                           ; C68F D0 04
        inc     $C4                             ; C691 E6 C4
        bcs     LC688                           ; C693 B0 F3

LC695:
        ; Z=1 si fin de ligne ou ':'
        cmp     #$00                            ; C695 C9 00
        beq     LC69B                           ; C697 F0 02
        cmp     #$3A                            ; C699 C9 3A
LC69B:
        rts                                     ; C69B 60

; ----------------------------------------------------------------------------
LC69C:
        .word   LC6E6-1                         ; C69C E5 C6
        .word   LC6EB-1                         ; C69E EA C6
        .word   LC70E-1                         ; C6A0 0D C7
        .word   LC95F-1                         ; C6A2 5E C9
        .word   LC73C-1                         ; C6A4 3B C7
        .word   LC747-1                         ; C6A6 46 C7
        .word   LC76C-1                         ; C6A8 6B C7
        .word   LC7A9-1                         ; C6AA A8 C7
        .word   LC7C0-1                         ; C6AC BF C7
        .word   LC7C7-1                         ; C6AE C6 C7
        .word   LC7CE-1                         ; C6B0 CD C7
        .word   LC7D5-1                         ; C6B2 D4 C7
        .word   LC7E7-1                         ; C6B4 E6 C7
        .word   LC7ED-1                         ; C6B6 EC C7
        .word   LC915-1                         ; C6B8 14 C9
        .word   LC939-1                         ; C6BA 38 C9
        .word   LC98E-1                         ; C6BC 8D C9
        .word   LC9A4-1                         ; C6BE A3 C9
        .word   LC9AE-1                         ; C6C0 AD C9
        .word   LC9B8-1                         ; C6C2 B7 C9
        .word   LC9C7-1                         ; C6C4 C6 C9
        .word   LC7BB-1                         ; C6C6 BA C7
        .word   LC703-1                         ; C6C8 02 C7
; ----------------------------------------------------------------------------
AtnMsg_table:
        .byte   $01,$03,$04,$00,$07,$0C,$0D,$0E ; C6CA 01 03 04 00 07 0C 0D 0E
        .byte   $0F,$0A,$08,$09,$06,$05,$00,$00 ; C6D2 0F 0A 08 09 06 05 00 00
        .byte   $02,$10,$17,$12,$11,$15,$00,$00 ; C6DA 02 10 17 12 11 15 00 00
        .byte   $0B,$02,$16,$14                 ; C6E2 0B 02 16 14
; ----------------------------------------------------------------------------
LC6E6:
        cmp     #$3A                            ; C6E6 C9 3A
        jmp     LC7DD                           ; C6E8 4C DD C7

; ----------------------------------------------------------------------------
LC6EB:
        jsr     LCBC6                           ; C6EB 20 C6 CB
        bcs     LC76A                           ; C6EE B0 7A
LC6F0:
        ; Cherche une instruction de type 3
        ldx     #$03                            ; C6F0 A2 03
        jsr     LCA05                           ; C6F2 20 05 CA
        bcs     LC6FD                           ; C6F5 B0 06

        jsr     LCE06                           ; C6F7 20 06 CE
        jmp     LC6EB                           ; C6FA 4C EB C6

; ----------------------------------------------------------------------------
LC6FD:
        bit     $BA                             ; C6FD 24 BA
        bmi     LC76A                           ; C6FF 30 69
        clc                                     ; C701 18
        rts                                     ; C702 60

; ----------------------------------------------------------------------------
LC703:
        bne     LC70A                           ; C703 D0 05

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$46                            ; C705 A9 46
        jmp     LCA69                           ; C707 4C 69 CA

; ----------------------------------------------------------------------------
LC70A:
        lda     #$02                            ; C70A A9 02
        sta     $CA                             ; C70C 85 CA
LC70E:
        jsr     LCBC6                           ; C70E 20 C6 CB
        bcs     LC76A                           ; C711 B0 57
LC713:
        ; Cherche une instruction de type 3
        ldx     #$03                            ; C713 A2 03
        jsr     LCA05                           ; C715 20 05 CA
        bcs     LC730                           ; C718 B0 16

        ldy     #$04                            ; C71A A0 04
        lda     ($92),y                         ; C71C B1 92
        cmp     #$15                            ; C71E C9 15
        beq     LC72A                           ; C720 F0 08
        cmp     #$17                            ; C722 C9 17
        bcc     LC736                           ; C724 90 10
        cmp     #$20                            ; C726 C9 20
        bcs     LC736                           ; C728 B0 0C
LC72A:
        jsr     LCE06                           ; C72A 20 06 CE
        jmp     LC70E                           ; C72D 4C 0E C7

; ----------------------------------------------------------------------------
LC730:
        bit     $BA                             ; C730 24 BA
        bpl     LC76A                           ; C732 10 36
        clc                                     ; C734 18
        rts                                     ; C735 60

; ----------------------------------------------------------------------------
LC736:
        lda     #$1A                            ; C736 A9 1A
        sta     $CA                             ; C738 85 CA
        sec                                     ; C73A 38
        rts                                     ; C73B 60

; ----------------------------------------------------------------------------
LC73C:
        jsr     LCBC6                           ; C73C 20 C6 CB
        bcs     LC76A                           ; C73F B0 29
        bit     $BA                             ; C741 24 BA
        bpl     LC6F0                           ; C743 10 AB
        bmi     LC713                           ; C745 30 CC
LC747:
        jsr     LC7F9                           ; C747 20 F9 C7
        bcs     LC76A                           ; C74A B0 1E
        ldx     $0106                           ; C74C AE 06 01
        cpx     #$07                            ; C74F E0 07
        beq     LC76A                           ; C751 F0 17
        cmp     #$24                            ; C753 C9 24
        bne     LC76A                           ; C755 D0 13
LC757:
        jsr     LCD8A                           ; C757 20 8A CD
        inc     $0106                           ; C75A EE 06 01
        cmp     #$28                            ; C75D C9 28
        bne     LC767                           ; C75F D0 06
        jsr     LC865                           ; C761 20 65 C8
        jmp     LC78A                           ; C764 4C 8A C7

; ----------------------------------------------------------------------------
LC767:
        jmp     LC85F                           ; C767 4C 5F C8

; ----------------------------------------------------------------------------
LC76A:
        sec                                     ; C76A 38
        rts                                     ; C76B 60

; ----------------------------------------------------------------------------
LC76C:
        jsr     LC7F9                           ; C76C 20 F9 C7
        bcs     LC76A                           ; C76F B0 F9
        ldx     $0106                           ; C771 AE 06 01
        cpx     #$07                            ; C774 E0 07
        beq     LC76A                           ; C776 F0 F2
LC778:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C778 20 88 C6
        cmp     #$28                            ; C77B C9 28
        bne     LC785                           ; C77D D0 06
        jsr     LC868                           ; C77F 20 68 C8
        jmp     LC78A                           ; C782 4C 8A C7

; ----------------------------------------------------------------------------
LC785:
        jmp     LC862                           ; C785 4C 62 C8

; ----------------------------------------------------------------------------
        clc                                     ; C788 18
        rts                                     ; C789 60

; ----------------------------------------------------------------------------
LC78A:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0A                            ; C78A A2 0A
        jsr     LC676                           ; C78C 20 76 C6

        lda     $94                             ; C78F A5 94
        pha                                     ; C791 48

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; C792 20 74 C6
        pla                                     ; C795 68
        bcs     LC76A                           ; C796 B0 D2

        sta     $94                             ; C798 85 94

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0B                            ; C79A A2 0B
        jsr     LC676                           ; C79C 20 76 C6
        bcs     LC76A                           ; C79F B0 C9

        jsr     LC909                           ; C7A1 20 09 C9

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3D                            ; C7A4 A9 3D
        jmp     LCA69                           ; C7A6 4C 69 CA

; ----------------------------------------------------------------------------
LC7A9:
        jsr     LC7F9                           ; C7A9 20 F9 C7
        bcs     LC76A                           ; C7AC B0 BC
        ldx     $0106                           ; C7AE AE 06 01
        cpx     #$07                            ; C7B1 E0 07
        beq     LC76A                           ; C7B3 F0 B5
        cmp     #$24                            ; C7B5 C9 24
        beq     LC757                           ; C7B7 F0 9E
        bne     LC778                           ; C7B9 D0 BD
LC7BB:
        cmp     #$27                            ; C7BB C9 27
        jmp     LC7DD                           ; C7BD 4C DD C7

; ----------------------------------------------------------------------------
LC7C0:
        ldx     #$2C                            ; C7C0 A2 2C
        cmp     #$3D                            ; C7C2 C9 3D
        jmp     LC7D9                           ; C7C4 4C D9 C7

; ----------------------------------------------------------------------------
LC7C7:
        ldx     #$21                            ; C7C7 A2 21
        cmp     #$2C                            ; C7C9 C9 2C
        jmp     LC7D9                           ; C7CB 4C D9 C7

; ----------------------------------------------------------------------------
LC7CE:
        ldx     #$2D                            ; C7CE A2 2D
        cmp     #$28                            ; C7D0 C9 28
        jmp     LC7D9                           ; C7D2 4C D9 C7

; ----------------------------------------------------------------------------
LC7D5:
        ldx     #$2E                            ; C7D5 A2 2E
        cmp     #$29                            ; C7D7 C9 29
LC7D9:
        bne     LC76A                           ; C7D9 D0 8F
        txa                                     ; C7DB 8A
        .byte   $2C                             ; C7DC 2C
LC7DD:
        bne     LC76A                           ; C7DD D0 8B

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; C7DF 20 69 CA

        ; Passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; C7E2 20 86 C6

        clc                                     ; C7E5 18
        rts                                     ; C7E6 60

; ----------------------------------------------------------------------------
LC7E7:
        jsr     LC7F7                           ; C7E7 20 F7 C7
        bcc     LC859                           ; C7EA 90 6D
        rts                                     ; C7EC 60

; ----------------------------------------------------------------------------
LC7ED:
        jsr     LC7F7                           ; C7ED 20 F7 C7
        bcc     LC859                           ; C7F0 90 67
        jmp     LCCCC                           ; C7F2 4C CC CC

; ----------------------------------------------------------------------------
LC7F5:
        sec                                     ; C7F5 38
        rts                                     ; C7F6 60

; ----------------------------------------------------------------------------
LC7F7:
        sec                                     ; C7F7 38
        .byte   $24                             ; C7F8 24
LC7F9:
        clc                                     ; C7F9 18

        ror     RES                             ; C7FA 66 00
        sty     $94                             ; C7FC 84 94
        ldx     #$07                            ; C7FE A2 07
        stx     $C8                             ; C800 86 C8

        ; Vérifie que l'instruction courante dans BUFEDT est THEN/ELSE/TO/STEP
        ; C=0 si Ok
        jsr     LC9D3                           ; C802 20 D3 C9
        bcc     LC7F5                           ; C805 90 EE

        ; Cherche une instruction de type 3
        ldx     #$03                            ; C807 A2 03
        jsr     LCA05                           ; C809 20 05 CA
        bcc     LC7F5                           ; C80C 90 E7

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C80E 20 88 C6

        jsr     LCB45                           ; C811 20 45 CB
        cmp     #$41                            ; C814 C9 41
        bcc     LC7F5                           ; C816 90 DD

        cmp     #$5B                            ; C818 C9 5B
        bcs     LC7F5                           ; C81A B0 D9

LC81C:
        jsr     LCD8A                           ; C81C 20 8A CD
        jsr     LCB45                           ; C81F 20 45 CB
        pha                                     ; C822 48

        ; Vérifie que l'instruction courante dans BUFEDT est THEN/ELSE/TO/STEP
        ; C=0 si Ok
        jsr     LC9D3                           ; C823 20 D3 C9
        bcc     LC851                           ; C826 90 29

        ; Cherche une instruction de type 3
        ldx     #$03                            ; C828 A2 03
        jsr     LCA05                           ; C82A 20 05 CA
        bcs     LC837                           ; C82D B0 08

        cpx     #$16                            ; C82F E0 16
        bne     LC851                           ; C831 D0 1E

        bit     RES                             ; C833 24 00
        bpl     LC851                           ; C835 10 1A

LC837:
        pla                                     ; C837 68

        ; Caractère '-'?
        cmp     #$2D                            ; C838 C9 2D
        beq     LC81C                           ; C83A F0 E0

        ; Caractère '.'?
        cmp     #$2E                            ; C83C C9 2E
        beq     LC81C                           ; C83E F0 DC

        ; Caractère < '0'?
        cmp     #$30                            ; C840 C9 30
        bcc     LC852                           ; C842 90 0E

        ; Caractère < '9'+1?
        cmp     #$3A                            ; C844 C9 3A
        bcc     LC81C                           ; C846 90 D4

        ; Caractère < 'A'?
        cmp     #$41                            ; C848 C9 41
        bcc     LC852                           ; C84A 90 06

        ; Caractère < 'Z'+1?
        cmp     #$5B                            ; C84C C9 5B
        bcc     LC81C                           ; C84E 90 CC
        .byte   $24                             ; C850 24

LC851:
        pla                                     ; C851 68

LC852:
        ldx     $C8                             ; C852 A6 C8
        stx     $0106                           ; C854 8E 06 01
        clc                                     ; C857 18
        rts                                     ; C858 60

; ----------------------------------------------------------------------------
LC859:
        lda     #$06                            ; C859 A9 06
        .byte   $2C                             ; C85B 2C
LC85C:
        lda     #$07                            ; C85C A9 07
        .byte   $2C                             ; C85E 2C
LC85F:
        lda     #$08                            ; C85F A9 08
        .byte   $2C                             ; C861 2C
LC862:
        lda     #$09                            ; C862 A9 09
        .byte   $2C                             ; C864 2C
LC865:
        lda     #$0C                            ; C865 A9 0C
        .byte   $2C                             ; C867 2C
LC868:
        lda     #$0D                            ; C868 A9 0D

LC86A:
        sta     $94                             ; C86A 85 94

        ldx     #$07                            ; C86C A2 07
        ldy     #$01                            ; C86E A0 01
        lda     $0106                           ; C870 AD 06 01
        jsr     LC9EA                           ; C873 20 EA C9
        bcc     LC8B0                           ; C876 90 38

        ldy     #$02                            ; C878 A0 02
        lda     $94                             ; C87A A5 94
        cmp     #$0C                            ; C87C C9 0C
        bcc     LC884                           ; C87E 90 04

        cmp     #$0E                            ; C880 C9 0E
        bcc     LC898                           ; C882 90 14

LC884:
        cmp     #$07                            ; C884 C9 07
        beq     LC898                           ; C886 F0 10

        iny                                     ; C888 C8
        cmp     #$08                            ; C889 C9 08
        beq     LC898                           ; C88B F0 0B

        ldy     #$04                            ; C88D A0 04
        cmp     #$06                            ; C88F C9 06
        beq     LC898                           ; C891 F0 05

        iny                                     ; C893 C8
        cmp     #$09                            ; C894 C9 09
        bne     LC8A0                           ; C896 D0 08

LC898:
        lda     #$00                            ; C898 A9 00
        jsr     LCD8C                           ; C89A 20 8C CD
        dey                                     ; C89D 88
        bne     LC898                           ; C89E D0 F8

LC8A0:
        lda     $94                             ; C8A0 A5 94
        ldy     #$00                            ; C8A2 A0 00
        jsr     LCD96                           ; C8A4 20 96 CD
        ldx     $0104                           ; C8A7 AE 04 01
        lda     $0105                           ; C8AA AD 05 01
        jmp     LC8B8                           ; C8AD 4C B8 C8

; ----------------------------------------------------------------------------
LC8B0:
        ldy     #$04                            ; C8B0 A0 04
        lda     ($92),y                         ; C8B2 B1 92
        tax                                     ; C8B4 AA
        iny                                     ; C8B5 C8
        lda     ($92),y                         ; C8B6 B1 92
LC8B8:
        pha                                     ; C8B8 48
        txa                                     ; C8B9 8A
        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        jsr     LCA7A                           ; C8BA 20 7A CA

        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        pla                                     ; C8BD 68
        jsr     LCA7A                           ; C8BE 20 7A CA

        ldy     #$02                            ; C8C1 A0 02
        lda     ($92),y                         ; C8C3 B1 92
        cmp     #$0B                            ; C8C5 C9 0B
        beq     LC913                           ; C8C7 F0 4A

        cmp     #$0C                            ; C8C9 C9 0C
        beq     LC906                           ; C8CB F0 39

        cmp     #$0D                            ; C8CD C9 0D
        beq     LC906                           ; C8CF F0 35

        ldx     $C5                             ; C8D1 A6 C5
        ldy     $05FD,x                         ; C8D3 BC FD 05
        cmp     #$07                            ; C8D6 C9 07
        bne     LC8E4                           ; C8D8 D0 0A

        cpy     #$B5                            ; C8DA C0 B5
        beq     LC909                           ; C8DC F0 2B

        cpy     #$B4                            ; C8DE C0 B4
        beq     LC909                           ; C8E0 F0 27

        bne     LC90C                           ; C8E2 D0 28

LC8E4:
        cmp     #$06                            ; C8E4 C9 06
        bne     LC906                           ; C8E6 D0 1E
LC8E8:
        cpx     #$03                            ; C8E8 E0 03
        beq     LC903                           ; C8EA F0 17

        tya                                     ; C8EC 98
        beq     LC913                           ; C8ED F0 24

        cpy     #$B5                            ; C8EF C0 B5
        beq     LC909                           ; C8F1 F0 16

        cpy     #$B4                            ; C8F3 C0 B4
        beq     LC909                           ; C8F5 F0 12

        cpy     #$A1                            ; C8F7 C0 A1
        beq     LC90C                           ; C8F9 F0 11

        cpy     #$A2                            ; C8FB C0 A2
        beq     LC90C                           ; C8FD F0 0D

        cpy     #$AC                            ; C8FF C0 AC
        beq     LC90C                           ; C901 F0 09

LC903:
        ; Ajoute #$08 à $C2
        lda     #$08                            ; C903 A9 08
        .byte   $2C                             ; C905 2C
LC906:
        ; Ajoute #$05 à $C2
        lda     #$05                            ; C906 A9 05
        .byte   $2C                             ; C908 2C
LC909:
        ; Ajoute #$03 à $C2
        lda     #$03                            ; C909 A9 03
        .byte   $2C                             ; C90B 2C
LC90C:
        ; Ajoute #$02 à $C2
        lda     #$02                            ; C90C A9 02

        clc                                     ; C90E 18
        adc     $C2                             ; C90F 65 C2
        sta     $C2                             ; C911 85 C2
LC913:
        clc                                     ; C913 18
        rts                                     ; C914 60

; ----------------------------------------------------------------------------
LC915:
        ldx     #$07                            ; C915 A2 07
        stx     $C8                             ; C917 86 C8
LC919:
        ldx     $C4                             ; C919 A6 C4
        lda     BUFEDT,x                        ; C91B BD 90 05
        beq     LC92B                           ; C91E F0 0B

        ldx     $C8                             ; C920 A6 C8
        sta     L0100,x                         ; C922 9D 00 01
        inc     $C8                             ; C925 E6 C8
        inc     $C4                             ; C927 E6 C4
        bne     LC919                           ; C929 D0 EE

LC92B:
        lda     $C8                             ; C92B A5 C8
        sta     $0106                           ; C92D 8D 06 01
        cmp     #$07                            ; C930 C9 07
        beq     LC913                           ; C932 F0 DF

        lda     #$0B                            ; C934 A9 0B
        jmp     LC86A                           ; C936 4C 6A C8

; ----------------------------------------------------------------------------
LC939:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C939 20 88 C6
        cmp     #$40                            ; C93C C9 40
        bne     LC985                           ; C93E D0 45

        lda     #$44                            ; C940 A9 44
        jsr     LC97D                           ; C942 20 7D C9

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; C945 20 74 C6
        bcs     LC986                           ; C948 B0 3C

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C94A 20 88 C6
        cmp     #$2C                            ; C94D C9 2C
        bne     LC987                           ; C94F D0 36

        lda     #$42                            ; C951 A9 42
        jsr     LC97D                           ; C953 20 7D C9

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; C956 20 74 C6
        bcs     LC986                           ; C959 B0 2B

        lda     #$43                            ; C95B A9 43
        bne     LC96F                           ; C95D D0 10

LC95F:
        cmp     #$5D                            ; C95F C9 5D
        bne     LC989                           ; C961 D0 26

        lda     #$3F                            ; C963 A9 3F
        jsr     LC97D                           ; C965 20 7D C9

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; C968 20 74 C6
        bcs     LC986                           ; C96B B0 19

        lda     #$40                            ; C96D A9 40
LC96F:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; C96F 20 69 CA

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; C972 20 88 C6
        beq     LC985                           ; C975 F0 0E

        cmp     #$3B                            ; C977 C9 3B
        bne     LC987                           ; C979 D0 0C

        lda     #$23                            ; C97B A9 23
LC97D:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; C97D 20 69 CA

        ; Passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; C980 20 86 C6

        lda     #$00                            ; C983 A9 00
LC985:
        clc                                     ; C985 18
LC986:
        rts                                     ; C986 60

; ----------------------------------------------------------------------------
LC987:
        sec                                     ; C987 38
        rts                                     ; C988 60

; ----------------------------------------------------------------------------
LC989:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$26                            ; C989 A9 26
        jmp     LCA69                           ; C98B 4C 69 CA

; ----------------------------------------------------------------------------
LC98E:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C98E 20 50 CB
        bcc     LC9D1                           ; C991 90 3E

        inc     $C2                             ; C993 E6 C2
        ; "SET"?
        cmp     #$B0                            ; C995 C9 B0
        beq     LC99D                           ; C997 F0 04

        ; "OFF"?
        cmp     #$B1                            ; C999 C9 B1
LC99B:
        bne     LC9D1                           ; C99B D0 34

LC99D:
        stx     $C4                             ; C99D 86 C4

        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        jsr     LCA7A                           ; C99F 20 7A CA

        clc                                     ; C9A2 18
        rts                                     ; C9A3 60

; ----------------------------------------------------------------------------
LC9A4:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C9A4 20 50 CB
        bcc     LC9D1                           ; C9A7 90 28

        ; "TO"?
        cmp     #$B2                            ; C9A9 C9 B2
        jmp     LC99B                           ; C9AB 4C 9B C9

; ----------------------------------------------------------------------------
LC9AE:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C9AE 20 50 CB
        bcc     LC9D1                           ; C9B1 90 1E

        ; "STEP"?
        cmp     #$B3                            ; C9B3 C9 B3
        jmp     LC99B                           ; C9B5 4C 9B C9

; ----------------------------------------------------------------------------
LC9B8:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C9B8 20 50 CB
        bcc     LC9D1                           ; C9BB 90 14

        pha                                     ; C9BD 48
        jsr     LC909                           ; C9BE 20 09 C9
        pla                                     ; C9C1 68
        ; "ELSE"?
        cmp     #$B4                            ; C9C2 C9 B4
        jmp     LC99B                           ; C9C4 4C 9B C9

; ----------------------------------------------------------------------------
LC9C7:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C9C7 20 50 CB
        bcc     LC9D1                           ; C9CA 90 05

        ; "THEN"?
        cmp     #$B5                            ; C9CC C9 B5
        jmp     LC99B                           ; C9CE 4C 9B C9

; ----------------------------------------------------------------------------
LC9D1:
        sec                                     ; C9D1 38
        rts                                     ; C9D2 60

; ----------------------------------------------------------------------------
; Vérifie que l'instruction courante dans BUFEDT est THEN/ELSE/TO/STEP
; Sortie:
;       C=0 -> Oui, ACC contient le token correspondant
;       C=1 -> Non
LC9D3:
        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; C9D3 20 50 CB
        bcc     LC9D1                           ; C9D6 90 F9

        ; "THEN"?
        cmp     #$B5                            ; C9D8 C9 B5
        beq     LC9E8                           ; C9DA F0 0C

        ; "ELSE"?
        cmp     #$B4                            ; C9DC C9 B4
        beq     LC9E8                           ; C9DE F0 08

        ; "TO"?
        cmp     #$B2                            ; C9E0 C9 B2
        beq     LC9E8                           ; C9E2 F0 04

        ; "STEP"?
        cmp     #$B3                            ; C9E4 C9 B3
        bne     LC9D1                           ; C9E6 D0 E9
LC9E8:
        clc                                     ; C9E8 18
        rts                                     ; C9E9 60

; ----------------------------------------------------------------------------
LC9EA:
        ; Cherche une instruction de type $94 dans la table des instructions
        ; Adresse de l'instruction recherchée: XY
        pha                                     ; C9EA 48
        stx     $BC                             ; C9EB 86 BC
        sty     $BD                             ; C9ED 84 BD
        jsr     LCA15                           ; C9EF 20 15 CA
        pla                                     ; C9F2 68
        bcs     LCA02                           ; C9F3 B0 0D

LC9F5:
        ldy     #$06                            ; C9F5 A0 06
        cmp     ($92),y                         ; C9F7 D1 92
        beq     LCA03                           ; C9F9 F0 08

        pha                                     ; C9FB 48
        jsr     LCA35                           ; C9FC 20 35 CA
        pla                                     ; C9FF 68
        bcc     LC9F5                           ; CA00 90 F3

LCA02:
        rts                                     ; CA02 60

; ----------------------------------------------------------------------------
LCA03:
        clc                                     ; CA03 18
        rts                                     ; CA04 60

; ----------------------------------------------------------------------------
; Entrée:
;       X: Type d'instruction recherchée
;       $C4: index caractère courant dans BUFEDT
;
; Sortie:
;      C=1 si instruction inconnue
;      C=0, XA = Token de l'instruction, $92-93 pointeur sur la définition de l'instruction
LCA05:
        ; $BC-BD := #$0590+($C4)
        clc                                     ; CA05 18
        lda     #$90                            ; CA06 A9 90
        adc     $C4                             ; CA08 65 C4
        sta     $BC                             ; CA0A 85 BC
        lda     #$05                            ; CA0C A9 05
        adc     #$00                            ; CA0E 69 00
        sta     $BD                             ; CA10 85 BD
	; Sauvegarde X en $94 (type d'instruction)
        txa                                     ; CA12 8A
        sta     $94                             ; CA13 85 94

LCA15:
       ; $BC-BD -= #$07
        sec                                     ; CA15 38
        lda     $BC                             ; CA16 A5 BC
        sbc     #$07                            ; CA18 E9 07
        sta     $BC                             ; CA1A 85 BC
        bcs     LCA20                           ; CA1C B0 02

        dec     $BD                             ; CA1E C6 BD

LCA20:
        ; $DFB9: Adresse début de la table des mot clés
        ldx     #$B9                            ; CA20 A2 B9
        lda     #$DF                            ; CA22 A9 DF

LCA24:
        ; $92-93: Pointeur dans la table
        stx     $92                             ; CA24 86 92
        sta     $93                             ; CA26 85 93

        ldy     #$01                            ; CA28 A0 01
        ; Si poids fort du lien := 0 -> fin de la table atteinte
        lda     ($92),y                         ; CA2A B1 92
        beq     LCA67                           ; CA2C F0 39

        ; Si le type du mot clé correspond à celui recherché -> LCA40
        iny                                     ; CA2E C8
        lda     ($92),y                         ; CA2F B1 92
        cmp     $94                             ; CA31 C5 94
        beq     LCA40                           ; CA33 F0 0B

LCA35:
        ; On passe à l'entrée suivante dans la table
        ldy     #$00                            ; CA35 A0 00
        lda     ($92),y                         ; CA37 B1 92
        tax                                     ; CA39 AA
        iny                                     ; CA3A C8
        lda     ($92),y                         ; CA3B B1 92
        jmp     LCA24                           ; CA3D 4C 24 CA

; ----------------------------------------------------------------------------
; On a trouvé une instruction du bon type
; Entrée:
;       $92-93: Ponteur sur la table des instructions (instruction en cours de comparaison)
;       $94   : Type d'instruction recherchée
;       $BC-BD: Pointeur sur la ligne d'entrée (début de l'instruction recherchée)
;
; Sortie:
;       XA: Token de l'instruction si trouvée
LCA40:
        ; Calcule la longueur du nom de l'instruction à comparer
        ldy     #$06                            ; CA40 A0 06
        lda     ($92),y                         ; CA42 B1 92
        sec                                     ; CA44 38
        sbc     #$07                            ; CA45 E9 07
        sta     $95                             ; CA47 85 95

LCA49:
        ; Comparaison de l'instruction de la table
        ; avec celle recherchée
        iny                                     ; CA49 C8
        lda     ($BC),y                         ; CA4A B1 BC
        ldx     $94                             ; CA4C A6 94
        cpx     #$10                            ; CA4E E0 10
        bcs     LCA55                           ; CA50 B0 03

        ; Conversion minuscules/MAJUSCULES
        jsr     LCB45                           ; CA52 20 45 CB

LCA55:
        cmp     ($92),y                         ; CA55 D1 92
        bne     LCA35                           ; CA57 D0 DC
        dec     $95                             ; CA59 C6 95
        bne     LCA49                           ; CA5B D0 EC

        ; L'instruction correspond, on renvoie son token
        ldy     #$04                            ; CA5D A0 04
        lda     ($92),y                         ; CA5F B1 92
        tax                                     ; CA61 AA
        iny                                     ; CA62 C8
        lda     ($92),y                         ; CA63 B1 92
        clc                                     ; CA65 18
        rts                                     ; CA66 60

; ----------------------------------------------------------------------------
LCA67:
        sec                                     ; CA67 38
        rts                                     ; CA68 60

; ----------------------------------------------------------------------------
; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
;
; Sortie:
;       A est conservé
;       X = $C5 avant ajustement
;       Y = A-#$20
;       $C2 et $C5 ajustés
;
LCA69:
        pha                                     ; CA69 48

        ; Calcule le nombre d'octets à copier de la procédure A-#$20 de la table LE490
        ;et l'ajoute à $C2
        sec                                     ; CA6A 38
        sbc     #$20                            ; CA6B E9 20
        tay                                     ; CA6D A8
        lda     LE490+1,y                       ; CA6E B9 91 E4
        sbc     LE490,y                         ; CA71 F9 90 E4
        clc                                     ; CA74 18
        adc     $C2                             ; CA75 65 C2
        sta     $C2                             ; CA77 85 C2

        pla                                     ; CA79 68

LCA7A:
        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        ldx     $C5                             ; CA7A A6 C5
        sta     $0600,x                         ; CA7C 9D 00 06
        pha                                     ; CA7F 48
        lda     #$FF                            ; CA80 A9 FF
        sta     $0601,x                         ; CA82 9D 01 06
        pla                                     ; CA85 68
        inc     $C5                             ; CA86 E6 C5
        clc                                     ; CA88 18
        rts                                     ; CA89 60

; ----------------------------------------------------------------------------
; Cherche le type d'une instruction ou d'une variable
; Entrée:
;         Y: Index dans la ligne de token en cours d'examen
;       $96: Token à examiner
;       $97: Paramètre du token
; Sortie:
;       Cf Token2Type
LCA8A:
        ; Sauvegarde Y sur la pile 6502
        tya                                     ; CA8A 98
        pha                                     ; CA8B 48

        ; Token < #$D0? -> Token2Type
        ldy     $96                             ; CA8C A4 96
        cpy     #$D0                            ; CA8E C0 D0
        bcc     Token2Type                      ; CA90 90 1B

        ; Traitement d'une variable (Token >= #$D0)

        ; $96 := 1 0 1 1 m3 m2 m1 m0
        ; $97 := l7 l6 l5 x x x x x
        ; RES := Token - #$D0
        tya                                     ; CA92 98
        sbc     #$D0                            ; CA93 E9 D0
        sta     RES                             ; CA95 85 00

        ; Décalage de 5 bits à droite de RES-ACC
        lda     $97                             ; CA97 A5 97
        ldx     #$05                            ; CA99 A2 05
LCA9B:
        lsr     RES                             ; CA9B 46 00
        ror     a                               ; CA9D 6A
        dex                                     ; CA9E CA
        bne     LCA9B                           ; CA9F D0 FA

        ; Ici ACC b7-b3 contient b4-b0 de RES et ACC b2-b0 contient b7-b5 de $97

        ; Masqque b0
        ; ACC := 0 m3 m2 m1 m0 l7 l6 0 -> Offset dans la table ($CB-CC)
        ; $CB-CC) := Table de pointeurs versdes listes de variables
        ; Cherche le type de la variable
        and     #$FE                            ; CAA1 29 FE
        tay                                     ; CAA3 A8
        lda     ($CB),y                         ; CAA4 B1 CB
        tax                                     ; CAA6 AA
        iny                                     ; CAA7 C8
        lda     ($CB),y                         ; CAA8 B1 CB
        jmp     LCAB9                           ; CAAA 4C B9 CA

; ----------------------------------------------------------------------------
; Cherche l'instruction correspondant au token en $96-97 et renvoie son type en $94-95 et AX. Cherche à partir de $DFB9 si Y <$A0, sinon à partir de $E89F
; Entrée:
;       Y: Token à chercher
;     $92-93: Adresse de l'instruction dans la table
;     $94: Type du token
;     $95: Sous-type du token
;     $96: Token à chercher
;     $97: Paramètre du token
; Sommet de la pile 6502: Offset dans la ligne de token
;
; Sortie:
;      ACC: Type du token
;       Y: Offset dans la ligne de token
;      $94: Type du token

Token2Type:
        ; XA := #$DFB9
        ldx     #$B9                            ; CAAD A2 B9
        lda     #$DF                            ; CAAF A9 DF

        ; Token < #$A0? -> LCAB9
        cpy     #$A0                            ; CAB1 C0 A0
        bcc     LCAB9                           ; CAB3 90 04

        ; XA := E89F
        ldx     #$9F                            ; CAB5 A2 9F
        lda     #$E8                            ; CAB7 A9 E8

LCAB9:
        stx     $92                             ; CAB9 86 92
        sta     $93                             ; CABB 85 93

        ; Token trouvé?
        ldy     #$04                            ; CABD A0 04
        lda     ($92),y                         ; CABF B1 92
        cmp     $96                             ; CAC1 C5 96
        bne     LCADD                           ; CAC3 D0 18

        ; Paramètre OK?
        iny                                     ; CAC5 C8
        lda     ($92),y                         ; CAC6 B1 92
        cmp     $97                             ; CAC8 C5 97
        bne     LCADD                           ; CACA D0 11

        ldy     #$03                            ; CACC A0 03
        lda     ($92),y                         ; CACE B1 92
        sta     $95                             ; CAD0 85 95
        tax                                     ; CAD2 AA
        dey                                     ; CAD3 88
        lda     ($92),y                         ; CAD4 B1 92
        sta     $94                             ; CAD6 85 94

        ; Restaure Y
        pla                                     ; CAD8 68
        tay                                     ; CAD9 A8

; Renvoie le type du token dans ACC
        lda     $94                             ; CADA A5 94
        rts                                     ; CADC 60

; ----------------------------------------------------------------------------
; Passe à l'instruction suivante dans la table.
;
; Sortie:
;       XA: Adresse de l'instruction suivante dans la table ($92-93)
LCADD:
        ldy     #$00                            ; CADD A0 00
        lda     ($92),y                         ; CADF B1 92
        tax                                     ; CAE1 AA
        iny                                     ; CAE2 C8
        lda     ($92),y                         ; CAE3 B1 92
        jmp     LCAB9                           ; CAE5 4C B9 CA

; ----------------------------------------------------------------------------
LCAE8:
        ; Flag GRAB ON
        lda     fFlags                          ; CAE8 A5 8C
        and     #$BF                            ; CAEA 29 BF
        sta     fFlags                          ; CAEC 85 8C

LCAEE:
        ; $CB-CC := HIMEM - #$0100
        lda     HIMEM_val                       ; CAEE AD FB 07
        ldy     HIMEM_val+1                     ; CAF1 AC FC 07
        dey                                     ; CAF4 88
        sta     $CB                             ; CAF5 85 CB
        sty     $CC                             ; CAF7 84 CC

        ; $$96-97 := $0000
        ; $96-97 sera incrémenté de #$3F à chaque passage en LCB2B
        lda     #$D0                            ; CAF9 A9 D0
        ldy     #$00                            ; CAFB A0 00
        sta     $96                             ; CAFD 85 96
        sty     $97                             ; CAFF 84 97

        ; RES := 0
        sty     RES                             ; CB01 84 00

        ; XA := (L07FD) (pointeur de départ)
        ldx     L07FD                           ; CB03 AE FD 07
        lda     L07FD+1                         ; CB06 AD FE 07

LCB09:
        ; Sauvegarde XA en $92-93
        stx     $92                             ; CB09 86 92
        sta     $93                             ; CB0B 85 93
        ldy     #$01                            ; CB0D A0 01
        lda     ($92),y                         ; CB0F B1 92
        beq     LCB4F                           ; CB11 F0 3C

LCB13:
       ; Calcule ($92),5 - ($96-97)
        ldy     #$05                            ; CB13 A0 05
        lda     ($92),y                         ; CB15 B1 92
        cmp     $97                             ; CB17 C5 97

        dey                                     ; CB19 88
        lda     ($92),y                         ; CB1A B1 92
        sbc     $96                             ; CB1C E5 96
        bcs     LCB2B                           ; CB1E B0 0B

        ; Récupère en XA la valeur du pointeur en ($92),0
        ldy     #$00                            ; CB20 A0 00
        lda     ($92),y                         ; CB22 B1 92
        tax                                     ; CB24 AA
        iny                                     ; CB25 C8
        lda     ($92),y                         ; CB26 B1 92

        ; Boucle
        jmp     LCB09                           ; CB28 4C 09 CB

; ----------------------------------------------------------------------------
LCB2B:
        ; Place la valeur du pointeur $92-93 en ($CB),Y
        ldy     RES                             ; CB2B A4 00
        lda     $92                             ; CB2D A5 92
        sta     ($CB),y                         ; CB2F 91 CB
        iny                                     ; CB31 C8
        lda     $93                             ; CB32 A5 93
        sta     ($CB),y                         ; CB34 91 CB
        iny                                     ; CB36 C8
        sty     RES                             ; CB37 84 00

        ; Ajoute #$3F au pointeur $96-97
        lda     #$3F                            ; CB39 A9 3F
        adc     $97                             ; CB3B 65 97
        sta     $97                             ; CB3D 85 97
        bcc     LCB13                           ; CB3F 90 D2

        inc     $96                             ; CB41 E6 96
        bcs     LCB13                           ; CB43 B0 CE

; Conversion minuscules/MAJUSCULES
LCB45:
        cmp     #$61                            ; CB45 C9 61
        bcc     LCB4F                           ; CB47 90 06

        cmp     #$7B                            ; CB49 C9 7B
        bcs     LCB4F                           ; CB4B B0 02

        sbc     #$1F                            ; CB4D E9 1F
LCB4F:
        rts                                     ; CB4F 60

; ----------------------------------------------------------------------------
; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table
;
; Y: Index dans la table InstParam_table
; $C7: N° de l'élément dans la table
; $C4: Index de BUFEDT
;
; Sortie:
;        C=1 -> Trouvé, A=N° du paramètre +#$B0
;        C=0 -> Pas trouvé
;        X: Index dans BUFEDT mis à jour
;
LCB50:
        ldy     #$00                            ; CB50 A0 00
        sty     $C7                             ; CB52 84 C7
        .byte   $24                             ; CB54 24
LCB55:
        iny                                     ; CB55 C8
        ldx     $C4                             ; CB56 A6 C4
        .byte   $2C                             ; CB58 2C

LCB59:
        inx                                     ; CB59 E8
        iny                                     ; CB5A C8
        lda     BUFEDT,x                        ; CB5B BD 90 05
        ; Conversion minuscules/MAJUSCULES
        jsr     LCB45                           ; CB5E 20 45 CB
        sec                                     ; CB61 38
        sbc     InstParam_table,y               ; CB62 F9 98 EB
        beq     LCB59                           ; CB65 F0 F2

        ; Resultat de la soustraction =#$80 pour le dernier caractère du paramètre
        cmp     #$80                            ; CB67 C9 80
        beq     LCB78                           ; CB69 F0 0D

        inc     $C7                             ; CB6B E6 C7
        .byte   $24                             ; CB6D 24

LCB6E:
        ; Cherche l'élément suivant de la table InstParam_table
        iny                                     ; CB6E C8
        lda     InstParam_table,y               ; CB6F B9 98 EB
        beq     LCB7E                           ; CB72 F0 0A

        bpl     LCB6E                           ; CB74 10 F8

        ; Fin de l'élément trouvée, on boucle
        bmi     LCB55                           ; CB76 30 DD

LCB78:
        ; Arrivé ici après le cmp en $CB67, C=1
        inx                                     ; CB78 E8
        lda     $C7                             ; CB79 A5 C7
        adc     #$AF                            ; CB7B 69 AF
        sec                                     ; CB7D 38
LCB7E:
        rts                                     ; CB7E 60

; ----------------------------------------------------------------------------
LCB7F:
        ldx     $C4                             ; CB7F A6 C4
        inx                                     ; CB81 E8
        ldy     $C8                             ; CB82 A4 C8

        ; Boucle de copie de la chaine dans BUFTRV
LCB84:
        ; Fin de la ligne?
        lda     BUFEDT,x                        ; CB84 BD 90 05
        beq     LCB95                           ; CB87 F0 0C

        ; Caractère '"'?
        cmp     #$22                            ; CB89 C9 22
        beq     LCB94                           ; CB8B F0 07

        sta     L0100,y                         ; CB8D 99 00 01
        iny                                     ; CB90 C8
        inx                                     ; CB91 E8
        bne     LCB84                           ; CB92 D0 F0

LCB94:
        inx                                     ; CB94 E8

LCB95:
        stx     $C4                             ; CB95 86 C4
        sty     $C8                             ; CB97 84 C8
        sty     $0106                           ; CB99 8C 06 01

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; CB9C 20 88 C6

        lda     #$10                            ; CB9F A9 10
        jsr     LC86A                           ; CBA1 20 6A C8

        lda     #$10                            ; CBA4 A9 10
        jmp     LCD7D                           ; CBA6 4C 7D CD

; ----------------------------------------------------------------------------
LCBA9:
        jsr     LCD8A                           ; CBA9 20 8A CD
        beq     LCBBD                           ; CBAC F0 0F

        sta     TR2                             ; CBAE 85 0E
        jsr     LCD8A                           ; CBB0 20 8A CD
        cmp     #$27                            ; CBB3 C9 27
        bne     LCBC0                           ; CBB5 D0 09

        jsr     LCD8A                           ; CBB7 20 8A CD
        jmp     LCD67                           ; CBBA 4C 67 CD

; ----------------------------------------------------------------------------
LCBBD:
        lda     #$1B                            ; CBBD A9 1B
        .byte   $2C                             ; CBBF 2C
LCBC0:
        lda     #$15                            ; CBC0 A9 15
        sta     $CA                             ; CBC2 85 CA
LCBC4:
        sec                                     ; CBC4 38
        rts                                     ; CBC5 60

; ----------------------------------------------------------------------------
LCBC6:
        ldx     #$07                            ; CBC6 A2 07
        stx     $C8                             ; CBC8 86 C8
        ldx     #$00                            ; CBCA A2 00
        stx     TR2                             ; CBCC 86 0E
        stx     TR3                             ; CBCE 86 0F

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; CBD0 20 88 C6
        cmp     #$28                            ; CBD3 C9 28
        bne     LCBFD                           ; CBD5 D0 26

        lda     $CA                             ; CBD7 A5 CA
        pha                                     ; CBD9 48

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0A                            ; CBDA A2 0A
        jsr     LC676                           ; CBDC 20 76 C6

        pla                                     ; CBDF 68
        pha                                     ; CBE0 48

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        tax                                     ; CBE1 AA
        jsr     LC676                           ; CBE2 20 76 C6

        pla                                     ; CBE5 68
        bcs     LCBC4                           ; CBE6 B0 DC

        pha                                     ; CBE8 48

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0B                            ; CBE9 A2 0B
        jsr     LC676                           ; CBEB 20 76 C6

        pla                                     ; CBEE 68
        bcs     LCBC4                           ; CBEF B0 D3

        sta     $CA                             ; CBF1 85 CA
        rts                                     ; CBF3 60

; ----------------------------------------------------------------------------
LCBF4:
        jmp     LCCDC                           ; CBF4 4C DC CC

; ----------------------------------------------------------------------------
LCBF7:
        jmp     LCCAA                           ; CBF7 4C AA CC

; ----------------------------------------------------------------------------
LCBFA:
        jmp     LCB7F                           ; CBFA 4C 7F CB

; ----------------------------------------------------------------------------
LCBFD:
        ; Caractère '"'?
        cmp     #$22                            ; CBFD C9 22
        beq     LCBFA                           ; CBFF F0 F9

        ; Caractère "'"?
        cmp     #$27                            ; CC01 C9 27
        beq     LCBA9                           ; CC03 F0 A4

        ; Caractère '%'?
        cmp     #$25                            ; CC05 C9 25
        beq     LCBF4                           ; CC07 F0 EB

        ; Caractère '#'?
        cmp     #$23                            ; CC09 C9 23
        beq     LCBF4                           ; CC0B F0 E7

        ; Caractère '.'?
        cmp     #$2E                            ; CC0D C9 2E
        beq     LCBF4                           ; CC0F F0 E3

        ; Caractère '-'?
        cmp     #$2D                            ; CC11 C9 2D
        beq     LCBF4                           ; CC13 F0 DF

        ; Caractère '+'?
        cmp     #$2B                            ; CC15 C9 2B
        beq     LCBF4                           ; CC17 F0 DB

        ; Caractère <'0'?
        cmp     #$30                            ; CC19 C9 30
        bcc     LCC21                           ; CC1B 90 04

        ; Caractère '9'+1?
        cmp     #$3A                            ; CC1D C9 3A
        bcc     LCBF4                           ; CC1F 90 D3

LCC21:
        ; Cherche une instruction de type 2
        ldx     #$02                            ; CC21 A2 02
        jsr     LCA05                           ; CC23 20 05 CA
        bcs     LCBF7                           ; CC26 B0 CF

        jsr     LCE06                           ; CC28 20 06 CE
        ldy     #$03                            ; CC2B A0 03
        lda     ($92),y                         ; CC2D B1 92
        sta     $95                             ; CC2F 85 95
        cmp     #$02                            ; CC31 C9 02
        bcc     LCC97                           ; CC33 90 62

        lda     $CA                             ; CC35 A5 CA
        pha                                     ; CC37 48

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0A                            ; CC38 A2 0A
        jsr     LC676                           ; CC3A 20 76 C6
        bcs     LCC65                           ; CC3D B0 26

        lda     $95                             ; CC3F A5 95
        ldx     #$01                            ; CC41 A2 01
        cmp     #$04                            ; CC43 C9 04
        bcc     LCC48                           ; CC45 90 01

        inx                                     ; CC47 E8

LCC48:
        pha                                     ; CC48 48
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        jsr     LC676                           ; CC49 20 76 C6
        bcs     LCCC8                           ; CC4C B0 7A

        pla                                     ; CC4E 68
        pha                                     ; CC4F 48
        cmp     #$06                            ; CC50 C9 06
        bcc     LCC8A                           ; CC52 90 36

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3B                            ; CC54 A9 3B
        jsr     LCA69                           ; CC56 20 69 CA

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; CC59 20 88 C6
        cmp     #$2C                            ; CC5C C9 2C
        beq     LCC68                           ; CC5E F0 08

LCC60:
        lda     #$09                            ; CC60 A9 09
        sta     $CA                             ; CC62 85 CA
        pla                                     ; CC64 68
LCC65:
        pla                                     ; CC65 68
        sec                                     ; CC66 38
        rts                                     ; CC67 60

; ----------------------------------------------------------------------------
LCC68:
        ; Passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; CC68 20 86 C6

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; CC6B 20 74 C6
        bcs     LCCC8                           ; CC6E B0 58

        pla                                     ; CC70 68
        pha                                     ; CC71 48
        cmp     #$07                            ; CC72 C9 07
        bcc     LCC8A                           ; CC74 90 14

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3C                            ; CC76 A9 3C
        jsr     LCA69                           ; CC78 20 69 CA

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; CC7B 20 88 C6
        cmp     #$2C                            ; CC7E C9 2C
        bne     LCC60                           ; CC80 D0 DE

        ; Passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; CC82 20 86 C6

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; CC85 20 74 C6
        bcs     LCCC8                           ; CC88 B0 3E

LCC8A:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0B                            ; CC8A A2 0B
        jsr     LC676                           ; CC8C 20 76 C6
        bcs     LCCC8                           ; CC8F B0 37

        pla                                     ; CC91 68
        tax                                     ; CC92 AA
        pla                                     ; CC93 68
        sta     $CA                             ; CC94 85 CA
        txa                                     ; CC96 8A
LCC97:
        ldx     #$11                            ; CC97 A2 11
        tay                                     ; CC99 A8
        beq     LCCA6                           ; CC9A F0 0A
        cmp     #$02                            ; CC9C C9 02
        beq     LCCA6                           ; CC9E F0 06

        cmp     #$05                            ; CCA0 C9 05
        beq     LCCA6                           ; CCA2 F0 02

        ldx     #$10                            ; CCA4 A2 10

LCCA6:
        txa                                     ; CCA6 8A
        jmp     LCD7D                           ; CCA7 4C 7D CD

; ----------------------------------------------------------------------------
LCCAA:
        lda     $CA                             ; CCAA A5 CA
        pha                                     ; CCAC 48

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$07                            ; CCAD A2 07
        jsr     LC676                           ; CCAF 20 76 C6

        pla                                     ; CCB2 68
        sta     $CA                             ; CCB3 85 CA
        bcs     LCCCA                           ; CCB5 B0 13

        lda     #$10                            ; CCB7 A9 10
        ldx     $94                             ; CCB9 A6 94
        cpx     #$08                            ; CCBB E0 08
        beq     LCCC5                           ; CCBD F0 06

        cpx     #$0C                            ; CCBF E0 0C
        beq     LCCC5                           ; CCC1 F0 02

        lda     #$11                            ; CCC3 A9 11
LCCC5:
        jmp     LCD7D                           ; CCC5 4C 7D CD

; ----------------------------------------------------------------------------
LCCC8:
        pla                                     ; CCC8 68
        pla                                     ; CCC9 68
LCCCA:
        sec                                     ; CCCA 38
        rts                                     ; CCCB 60

; ----------------------------------------------------------------------------
LCCCC:
        lda     #$07                            ; CCCC A9 07
        sta     $C8                             ; CCCE 85 C8

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; CCD0 20 88 C6
        cmp     #$30                            ; CCD3 C9 30
        bcc     LCCCA                           ; CCD5 90 F3

        cmp     #$3A                            ; CCD7 C9 3A
        bcs     LCCCA                           ; CCD9 B0 EF
        .byte   $24                             ; CCDB 24

LCCDC:
        sec                                     ; CCDC 38
        php                                     ; CCDD 08
        clc                                     ; CCDE 18
        lda     $C4                             ; CCDF A5 C4
        adc     #$90                            ; CCE1 69 90
        pha                                     ; CCE3 48
        lda     #$00                            ; CCE4 A9 00
        adc     #$05                            ; CCE6 69 05
        tay                                     ; CCE8 A8
        pla                                     ; CCE9 68
        plp                                     ; CCEA 28
        php                                     ; CCEB 08
        bcs     LCCF7                           ; CCEC B0 09

        XDECAY                                  ; CCEE 00 26

        stx     RESB                            ; CCF0 86 02
        sta     FACC1M                          ; CCF2 85 61
        sty     FACC1M+1                        ; CCF4 84 62
        .byte   $2C                             ; CCF6 2C
LCCF7:
        XDECA1                                  ; CCF7 00 69

        clc                                     ; CCF9 18
        lda     RESB                            ; CCFA A5 02
        adc     $C4                             ; CCFC 65 C4
        sta     $C4                             ; CCFE 85 C4
        txa                                     ; CD00 8A
        bmi     LCD60                           ; CD01 30 5D

        ldy     #$00                            ; CD03 A0 00

LCD05:
        lda     (RES),y                         ; CD05 B1 00
        cmp     #$20                            ; CD07 C9 20
        beq     LCD0E                           ; CD09 F0 03

        jsr     LCD8C                           ; CD0B 20 8C CD
LCD0E:
        iny                                     ; CD0E C8
        cpy     RESB                            ; CD0F C4 02
        bne     LCD05                           ; CD11 D0 F2

        lda     $C8                             ; CD13 A5 C8
        sta     $0106                           ; CD15 8D 06 01
        plp                                     ; CD18 28
        bcs     LCD2A                           ; CD19 B0 0F

        lda     FACC1M                          ; CD1B A5 61
        jsr     LCD8C                           ; CD1D 20 8C CD
        lda     FACC1M+1                        ; CD20 A5 62
        jsr     LCD8C                           ; CD22 20 8C CD
        jsr     LC85C                           ; CD25 20 5C C8
        clc                                     ; CD28 18
        rts                                     ; CD29 60

; ----------------------------------------------------------------------------
LCD2A:
        XINTEG                                  ; CD2A 00 86
        beq     LCD38                           ; CD2C F0 0A

        lda     FACC1S                          ; CD2E A5 65
        bmi     LCD38                           ; CD30 30 06

        lda     FACC2M                          ; CD32 A5 69
        ora     FACC2M+1                        ; CD34 05 6A
        beq     LCD55                           ; CD36 F0 1D

LCD38:
        lda     FACC1S                          ; CD38 A5 65
        ora     #$7F                            ; CD3A 09 7F
        and     FACC1M                          ; CD3C 25 61
        sta     FACC1M                          ; CD3E 85 61
        ldy     #$FB                            ; CD40 A0 FB
LCD42:
        lda     CHAR,y                          ; CD42 B9 65 FF
        jsr     LCD8C                           ; CD45 20 8C CD
        iny                                     ; CD48 C8
        bne     LCD42                           ; CD49 D0 F7

        lda     #$12                            ; CD4B A9 12
        jsr     LC86A                           ; CD4D 20 6A C8
        lda     #$12                            ; CD50 A9 12
        jmp     LCD7D                           ; CD52 4C 7D CD

; ----------------------------------------------------------------------------
LCD55:
        lda     FACC2M+2                        ; CD55 A5 6B
        sta     TR3                             ; CD57 85 0F
        lda     FACC2M+3                        ; CD59 A5 6C
        sta     TR2                             ; CD5B 85 0E
        jmp     LCD67                           ; CD5D 4C 67 CD

; ----------------------------------------------------------------------------
LCD60:
        pla                                     ; CD60 68
        lda     #$18                            ; CD61 A9 18
        sta     $CA                             ; CD63 85 CA
        sec                                     ; CD65 38
        rts                                     ; CD66 60

; ----------------------------------------------------------------------------
LCD67:
        ldx     $C8                             ; CD67 A6 C8
        stx     $0106                           ; CD69 8E 06 01
        lda     TR2                             ; CD6C A5 0E
        jsr     LCD8C                           ; CD6E 20 8C CD
        lda     TR3                             ; CD71 A5 0F
        jsr     LCD8C                           ; CD73 20 8C CD
        lda     #$11                            ; CD76 A9 11
        jsr     LC86A                           ; CD78 20 6A C8
        lda     #$11                            ; CD7B A9 11
LCD7D:
        cmp     #$10                            ; CD7D C9 10
        beq     LCD85                           ; CD7F F0 04

        lsr     $BA                             ; CD81 46 BA
        clc                                     ; CD83 18
        rts                                     ; CD84 60

; ----------------------------------------------------------------------------
LCD85:
        sec                                     ; CD85 38
        ror     $BA                             ; CD86 66 BA
        clc                                     ; CD88 18
        rts                                     ; CD89 60

; ----------------------------------------------------------------------------
LCD8A:
        inc     $C4                             ; CD8A E6 C4
LCD8C:
        ldx     $C8                             ; CD8C A6 C8
        sta     L0100,x                         ; CD8E 9D 00 01
        inc     $C8                             ; CD91 E6 C8

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jmp     LC688                           ; CD93 4C 88 C6

; ----------------------------------------------------------------------------
LCD96:
        sta     $0102                           ; CD96 8D 02 01
        sty     $0103                           ; CD99 8C 03 01

        sec                                     ; CD9C 38
        lda     SCEFIN                          ; CD9D A5 5E
        sta     DECFIN                          ; CD9F 85 06
        sbc     #$06                            ; CDA1 E9 06
        sta     TR4                             ; CDA3 85 10
        sta     DECDEB                          ; CDA5 85 04
        lda     SCEFIN+1                        ; CDA7 A5 5F
        sta     DECFIN+1                        ; CDA9 85 07
        sbc     #$00                            ; CDAB E9 00
        sta     TR5                             ; CDAD 85 11
        sta     DECDEB+1                        ; CDAF 85 05
        ldy     #$04                            ; CDB1 A0 04
        lda     (TR4),y                         ; CDB3 B1 10
        sta     $0104                           ; CDB5 8D 04 01
        iny                                     ; CDB8 C8
        lda     (TR4),y                         ; CDB9 B1 10
        sta     $0105                           ; CDBB 8D 05 01

        clc                                     ; CDBE 18
        lda     TR4                             ; CDBF A5 10
        adc     $C8                             ; CDC1 65 C8
        sta     L0100                           ; CDC3 8D 00 01
        sta     DECCIB                          ; CDC6 85 08
        lda     TR5                             ; CDC8 A5 11
        adc     #$00                            ; CDCA 69 00
        sta     $0101                           ; CDCC 8D 01 01
        sta     DECCIB+1                        ; CDCF 85 09
        XDECAL                                  ; CDD1 00 18

        clc                                     ; CDD3 18
        ldy     $C8                             ; CDD4 A4 C8
        iny                                     ; CDD6 C8
        lda     #$00                            ; CDD7 A9 00
        sta     (TR4),y                         ; CDD9 91 10
        iny                                     ; CDDB C8
        iny                                     ; CDDC C8
        iny                                     ; CDDD C8
        iny                                     ; CDDE C8
        lda     (TR4),y                         ; CDDF B1 10
        adc     #$01                            ; CDE1 69 01
        sta     (TR4),y                         ; CDE3 91 10
        dey                                     ; CDE5 88
        lda     (TR4),y                         ; CDE6 B1 10
        adc     #$00                            ; CDE8 69 00
        sta     (TR4),y                         ; CDEA 91 10

        clc                                     ; CDEC 18
        lda     $C8                             ; CDED A5 C8
        adc     SCEFIN                          ; CDEF 65 5E
        sta     SCEFIN                          ; CDF1 85 5E
        bcc     LCDF7                           ; CDF3 90 02
        inc     SCEFIN+1                        ; CDF5 E6 5F

LCDF7:
        ldy     $C8                             ; CDF7 A4 C8
LCDF9:
        lda     L0100,y                         ; CDF9 B9 00 01
        sta     (TR4),y                         ; CDFC 91 10
        dey                                     ; CDFE 88
        bpl     LCDF9                           ; CDFF 10 F8

LCE01:
        rts                                     ; CE01 60

; ----------------------------------------------------------------------------
; Entrée:
;        AY: Ponteur vers l'instruction à compiler
;
; Sortie:
;        $C4: ajusté (pointe après l'instruction à compilée)
;        $C2: ajusté (+longueur du code LM de l'instruction)
;        C=0: Token < #$0E
;        C=1: Token >= #$11
;
;        Si token $0E, $0F, $10 -> C=0 et $C2 ajusté (+longueur du code LM de l'instruction +2)
LCE02:
        sta     $92                             ; CE02 85 92
        sty     $93                             ; CE04 84 93

; Entrée:
;        $92-93: Ponteur vers l'instruction à compiler
LCE06:
        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        ; Empile le token pour plus tard
        ldy     #$04                            ; CE06 A0 04
        lda     ($92),y                         ; CE08 B1 92
        pha                                     ; CE0A 48
        jsr     LCA7A                           ; CE0B 20 7A CA

        ; Token < #$C0?
        cmp     #$C0                            ; CE0E C9 C0
        bcc     LCE18                           ; CE10 90 06

        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        iny                                     ; CE12 C8
        lda     ($92),y                         ; CE13 B1 92
        jsr     LCA7A                           ; CE15 20 7A CA

LCE18:
        ; Calcule la longueur du nom de l'instruction
        ldy     #$06                            ; CE18 A0 06
        lda     ($92),y                         ; CE1A B1 92
        tay                                     ; CE1C A8
        sec                                     ; CE1D 38
        sbc     #$07                            ; CE1E E9 07

        ; Ajoute la longueur du nom de l'instruction à l'index $C4
        ; ($C4 index dans BUFEDT)
        clc                                     ; CE20 18
        adc     $C4                             ; CE21 65 C4
        sta     $C4                             ; CE23 85 C4

        ; Récupère la taille du code LM de l'instruction
        jsr     LCE3B                           ; CE25 20 3B CE
        ; Masque le b7
        and     #$7F                            ; CE28 29 7F
        ; et l'ajoute à $C2
        clc                                     ; CE2A 18
        adc     $C2                             ; CE2B 65 C2
        sta     $C2                             ; CE2D 85 C2

        ; Récupère le Token
        pla                                     ; CE2F 68

        ; Token < #$0E? -> Fin C=0
        cmp     #$0E                            ; CE30 C9 0E
        bcc     LCE01                           ; CE32 90 CD

        ; Token >= #$11? -> Fin C=1
        cmp     #$11                            ; CE34 C9 11
        bcs     LCE01                           ; CE36 B0 C9

        jmp     LC90C                           ; CE38 4C 0C C9

; ----------------------------------------------------------------------------
; Renvoie la taille du code LM de l'instruction
;
; (Il s'agit du premier octet suivant le premier octet >=#$80 après le nom de l'instruction
; ou le second si le premier octet >=#$80 est >=#$C0)
LCE3B:
        ; Y: Offset vers le premier octet après le nom de l'instruction
        ldy     #$06                            ; CE3B A0 06
        lda     ($92),y                         ; CE3D B1 92
        tay                                     ; CE3F A8
        dey                                     ; CE40 88

LCE41:
        ; Cherche la première valeur >#$80 après le nom de l'instruction
        iny                                     ; CE41 C8
        lda     ($92),y                         ; CE42 B1 92
        bpl     LCE41                           ; CE44 10 FB

        iny                                     ; CE46 C8
        ; Conserve uniquement b7-b5
        and     #$E0                            ; CE47 29 E0
        ; $Cx?
        cmp     #$C0                            ; CE49 C9 C0
        bne     LCE4E                           ; CE4B D0 01

        iny                                     ; CE4D C8
LCE4E:
        lda     ($92),y                         ; CE4E B1 92
        rts                                     ; CE50 60

; ----------------------------------------------------------------------------
LCE51:
        lda     $07B5                           ; CE51 AD B5 07
        ldy     $07B6                           ; CE54 AC B6 07
        sta     $07F7                           ; CE57 8D F7 07
        sty     $07F8                           ; CE5A 8C F8 07
        rts                                     ; CE5D 60

; ----------------------------------------------------------------------------
LCE5E:
        jsr     LCE51                           ; CE5E 20 51 CE
LCE61:
        lda     #$00                            ; CE61 A9 00
        sta     TR2                             ; CE63 85 0E
        sta     ptr00BE+1                       ; CE65 85 BF
        lda     $07F5                           ; CE67 AD F5 07
        ldy     $07F6                           ; CE6A AC F6 07
        sta     RES                             ; CE6D 85 00
        sty     RES+1                           ; CE6F 84 01
LCE71:
        ldx     L07FD                           ; CE71 AE FD 07
        lda     L07FD+1                         ; CE74 AD FE 07
LCE77:
        stx     TR0                             ; CE77 86 0C
        sta     TR1                             ; CE79 85 0D
        ldy     #$02                            ; CE7B A0 02
        lda     (TR0),y                         ; CE7D B1 0C
        tax                                     ; CE7F AA
        ldy     #$06                            ; CE80 A0 06
        lda     (TR0),y                         ; CE82 B1 0C
        cpx     #$08                            ; CE84 E0 08
        beq     LCE8E                           ; CE86 F0 06

        cpx     #$0C                            ; CE88 E0 0C
        bne     LCEBD                           ; CE8A D0 31

        adc     #$01                            ; CE8C 69 01
LCE8E:
        clc                                     ; CE8E 18
        adc     TR0                             ; CE8F 65 0C
        sta     TR6                             ; CE91 85 12
        lda     TR1                             ; CE93 A5 0D
        adc     #$00                            ; CE95 69 00
        sta     TR7                             ; CE97 85 13
        cpx     #$08                            ; CE99 E0 08
        beq     LCEBA                           ; CE9B F0 1D

LCE9D:
        jsr     LCED9                           ; CE9D 20 D9 CE
        ldy     #$00                            ; CEA0 A0 00

        clc                                     ; CEA2 18
        lda     #$03                            ; CEA3 A9 03
        adc     TR6                             ; CEA5 65 12
        sta     TR6                             ; CEA7 85 12
        bcc     LCEAD                           ; CEA9 90 02
        inc     TR7                             ; CEAB E6 13

LCEAD:
        cmp     (TR0),y                         ; CEAD D1 0C
        bne     LCE9D                           ; CEAF D0 EC

        lda     TR7                             ; CEB1 A5 13
        iny                                     ; CEB3 C8
        cmp     (TR0),y                         ; CEB4 D1 0C
        bne     LCE9D                           ; CEB6 D0 E5

        beq     LCEBD                           ; CEB8 F0 03

LCEBA:
        jsr     LCED9                           ; CEBA 20 D9 CE
LCEBD:
        ldy     #$00                            ; CEBD A0 00
        lda     (TR0),y                         ; CEBF B1 0C
        tax                                     ; CEC1 AA
        iny                                     ; CEC2 C8
        lda     (TR0),y                         ; CEC3 B1 0C
        bne     LCE77                           ; CEC5 D0 B0

        lda     ptr00BE+1                       ; CEC7 A5 BF
        bne     LCE61                           ; CEC9 D0 96

        ldx     TR2                             ; CECB A6 0E
        beq     LCF23                           ; CECD F0 54

        ldy     RES+1                           ; CECF A4 01
        lda     RES                             ; CED1 A5 00
        jsr     LCF62                           ; CED3 20 62 CF
        jmp     LCE71                           ; CED6 4C 71 CE

; ----------------------------------------------------------------------------
LCED9:
        ldy     #$00                            ; CED9 A0 00
        lda     (TR6),y                         ; CEDB B1 12
        beq     LCF23                           ; CEDD F0 44

        sta     TR3                             ; CEDF 85 0F
        iny                                     ; CEE1 C8
        lda     ptr00BE+1                       ; CEE2 A5 BF
        beq     LCEFD                           ; CEE4 F0 17

        lda     (TR6),y                         ; CEE6 B1 12
        cmp     RES                             ; CEE8 C5 00
        bne     LCF23                           ; CEEA D0 37

        iny                                     ; CEEC C8
        lda     (TR6),y                         ; CEED B1 12
        cmp     RES+1                           ; CEEF C5 01
        bne     LCF23                           ; CEF1 D0 30

        lda     ptr00BE+1                       ; CEF3 A5 BF
        sta     (TR6),y                         ; CEF5 91 12
        dey                                     ; CEF7 88
        lda     ptr00BE                         ; CEF8 A5 BE
        sta     (TR6),y                         ; CEFA 91 12
        rts                                     ; CEFC 60

; ----------------------------------------------------------------------------
LCEFD:
        lda     (TR6),y                         ; CEFD B1 12
        tax                                     ; CEFF AA
        cmp     RES                             ; CF00 C5 00
        iny                                     ; CF02 C8
        lda     (TR6),y                         ; CF03 B1 12
        tay                                     ; CF05 A8
        sbc     RES+1                           ; CF06 E5 01
        bcc     LCF23                           ; CF08 90 19

        cpx     $07F7                           ; CF0A EC F7 07
        tya                                     ; CF0D 98
        sbc     $07F8                           ; CF0E ED F8 07
        bcs     LCF23                           ; CF11 B0 10

        lda     TR3                             ; CF13 A5 0F
        sta     TR2                             ; CF15 85 0E
        stx     RES                             ; CF17 86 00
        sty     RES+1                           ; CF19 84 01
        lda     TR6                             ; CF1B A5 12
        ldy     TR7                             ; CF1D A4 13
        sta     TR4                             ; CF1F 85 10
        sty     TR5                             ; CF21 84 11
LCF23:
        rts                                     ; CF23 60

; ----------------------------------------------------------------------------
LCF24:
        pha                                     ; CF24 48
        eor     #$FF                            ; CF25 49 FF

        sec                                     ; CF27 38
        adc     $07F7                           ; CF28 6D F7 07
        tax                                     ; CF2B AA
        lda     $07F8                           ; CF2C AD F8 07
        bcs     LCF33                           ; CF2F B0 02
        adc     #$FF                            ; CF31 69 FF

LCF33:
        cpx     $07F5                           ; CF33 EC F5 07
        pha                                     ; CF36 48
        sbc     $07F6                           ; CF37 ED F6 07
        pla                                     ; CF3A 68
        bcs     LCF43                           ; CF3B B0 06

        jsr     LCE5E                           ; CF3D 20 5E CE
        pla                                     ; CF40 68
        bne     LCF24                           ; CF41 D0 E1

LCF43:
        stx     ptr00BE                         ; CF43 86 BE
        sta     ptr00BE+1                       ; CF45 85 BF
        stx     $07F7                           ; CF47 8E F7 07
        sta     $07F8                           ; CF4A 8D F8 07
        tay                                     ; CF4D A8
        ror     $BA                             ; CF4E 66 BA
        pla                                     ; CF50 68
        rts                                     ; CF51 60

; ----------------------------------------------------------------------------
LCF52:
        jsr     LCF24                           ; CF52 20 24 CF
        sta     FACC1E                          ; CF55 85 60
        stx     FACC1M                          ; CF57 86 61
        sty     FACC1M+1                        ; CF59 84 62
        rts                                     ; CF5B 60

; ----------------------------------------------------------------------------
LCF5C:
        lda     FACC1M                          ; CF5C A5 61
        ldy     FACC1M+1                        ; CF5E A4 62
        ldx     FACC1E                          ; CF60 A6 60
LCF62:
        pha                                     ; CF62 48
        tya                                     ; CF63 98
        pha                                     ; CF64 48
        txa                                     ; CF65 8A
        jsr     LCF52                           ; CF66 20 52 CF
        sta     RES                             ; CF69 85 00
        pla                                     ; CF6B 68
        tay                                     ; CF6C A8
        pla                                     ; CF6D 68
        tax                                     ; CF6E AA
        lda     RES                             ; CF6F A5 00
        stx     RES                             ; CF71 86 00
        sty     RES+1                           ; CF73 84 01
        tay                                     ; CF75 A8
        beq     LCF80                           ; CF76 F0 08

LCF78:
        dey                                     ; CF78 88
        lda     (RES),y                         ; CF79 B1 00
        sta     (ptr00BE),y                     ; CF7B 91 BE
        tya                                     ; CF7D 98
        bne     LCF78                           ; CF7E D0 F8

LCF80:
        rts                                     ; CF80 60

; ----------------------------------------------------------------------------
LCF81:
        ldy     #$03                            ; CF81 A0 03
        lda     (TR0),y                         ; CF83 B1 0C
        tax                                     ; CF85 AA
        ldy     #$06                            ; CF86 A0 06
        lda     (TR0),y                         ; CF88 B1 0C
        tay                                     ; CF8A A8
        txa                                     ; CF8B 8A
        beq     LCF98                           ; CF8C F0 0A

        lda     #$0B                            ; CF8E A9 0B
        sta     (TR0),y                         ; CF90 91 0C
        iny                                     ; CF92 C8
        lda     #$00                            ; CF93 A9 00
        sta     (TR0),y                         ; CF95 91 0C
        dey                                     ; CF97 88
LCF98:
        tya                                     ; CF98 98
        pha                                     ; CF99 48
        lda     (TR0),y                         ; CF9A B1 0C
        tax                                     ; CF9C AA
        iny                                     ; CF9D C8
        lda     (TR0),y                         ; CF9E B1 0C
        pha                                     ; CFA0 48
        ldy     #$02                            ; CFA1 A0 02
        lda     (TR0),y                         ; CFA3 B1 0C
        tay                                     ; CFA5 A8
        pla                                     ; CFA6 68
        jsr     LD002                           ; CFA7 20 02 D0

        clc                                     ; CFAA 18
        pla                                     ; CFAB 68
        adc     RES                             ; CFAC 65 00
        bcc     LCFB1                           ; CFAE 90 01
        inx                                     ; CFB0 E8

LCFB1:
        clc                                     ; CFB1 18
        adc     TR0                             ; CFB2 65 0C
        sta     DECCIB                          ; CFB4 85 08
        txa                                     ; CFB6 8A
        adc     TR1                             ; CFB7 65 0D
        sta     DECCIB+1                        ; CFB9 85 09

        sec                                     ; CFBB 38
        ldy     #$00                            ; CFBC A0 00
        lda     DECCIB                          ; CFBE A5 08
        sbc     (TR0),y                         ; CFC0 F1 0C
        sta     TR3                             ; CFC2 85 0F
        iny                                     ; CFC4 C8
        lda     DECCIB+1                        ; CFC5 A5 09
        sbc     (TR0),y                         ; CFC7 F1 0C
        sta     TR4                             ; CFC9 85 10
        ora     TR3                             ; CFCB 05 0F
        beq     LD001                           ; CFCD F0 32

        lda     SCEFIN                          ; CFCF A5 5E
        ldy     SCEFIN+1                        ; CFD1 A4 5F
        sta     DECFIN                          ; CFD3 85 06
        sty     DECFIN+1                        ; CFD5 84 07

        clc                                     ; CFD7 18
        adc     TR3                             ; CFD8 65 0F
        sta     SCEFIN                          ; CFDA 85 5E
        tya                                     ; CFDC 98
        adc     TR4                             ; CFDD 65 10
        sta     SCEFIN+1                        ; CFDF 85 5F
        ldy     #$00                            ; CFE1 A0 00
        lda     (TR0),y                         ; CFE3 B1 0C
        sta     DECDEB                          ; CFE5 85 04
        iny                                     ; CFE7 C8
        lda     (TR0),y                         ; CFE8 B1 0C
        sta     DECDEB+1                        ; CFEA 85 05
        XDECAL                                  ; CFEC 00 18

        ; Mise à jour des liens (fin lorsque le poids fort d'un lien = 0)
        ; Adresse premier lien dans XA, déplacement dans TR3-TR4
        lda     TR0                             ; CFEE A5 0C
        pha                                     ; CFF0 48
        tax                                     ; CFF1 AA
        lda     TR1                             ; CFF2 A5 0D
        pha                                     ; CFF4 48
        jsr     LC3C2                           ; CFF5 20 C2 C3

        pla                                     ; CFF8 68
        sta     TR1                             ; CFF9 85 0D
        pla                                     ; CFFB 68
        sta     TR0                             ; CFFC 85 0C
        jmp     LFDEA                           ; CFFE 4C EA FD

; ----------------------------------------------------------------------------
LD001:
        rts                                     ; D001 60

; ----------------------------------------------------------------------------
LD002:
        stx     RESB                            ; D002 86 02
        sta     RES+1                           ; D004 85 01
        sta     RESB+1                          ; D006 85 03
        txa                                     ; D008 8A
        asl     a                               ; D009 0A
        rol     RES+1                           ; D00A 26 01
        cpy     #$0C                            ; D00C C0 0C
        beq     LD013                           ; D00E F0 03

        asl     a                               ; D010 0A
        rol     RES+1                           ; D011 26 01
LD013:
        clc                                     ; D013 18
        adc     RESB                            ; D014 65 02
        pha                                     ; D016 48
        lda     RES+1                           ; D017 A5 01
        adc     RESB+1                          ; D019 65 03
        tax                                     ; D01B AA
        pla                                     ; D01C 68
        adc     #$02                            ; D01D 69 02
        sta     RES                             ; D01F 85 00
        pha                                     ; D021 48
        bcc     LD025                           ; D022 90 01
        inx                                     ; D024 E8

LD025:
        stx     RES+1                           ; D025 86 01
        pla                                     ; D027 68
        rts                                     ; D028 60

; ----------------------------------------------------------------------------
; Erreur: index de tableau trop grand
Error_IDXARY:
        ldx     #$18                            ; D029 A2 18
        jmp     Error_X                         ; D02B 4C 7E D1

; ----------------------------------------------------------------------------
LD02E:
        jsr     LD1F7                           ; D02E 20 F7 D1
        ldy     #$06                            ; D031 A0 06
        lda     ($92),y                         ; D033 B1 92
        tay                                     ; D035 A8
        lda     FACC1M                          ; D036 A5 61
        cmp     ($92),y                         ; D038 D1 92

        lda     FACC1M+1                        ; D03A A5 62
        iny                                     ; D03C C8
        sbc     ($92),y                         ; D03D F1 92
        bcs     Error_IDXARY                    ; D03F B0 E8

        ldy     #$02                            ; D041 A0 02
        lda     ($92),y                         ; D043 B1 92
        tay                                     ; D045 A8
        ldx     FACC1M                          ; D046 A6 61
        lda     FACC1M+1                        ; D048 A5 62
        jsr     LD002                           ; D04A 20 02 D0

        clc                                     ; D04D 18
        ldy     #$06                            ; D04E A0 06
        adc     ($92),y                         ; D050 71 92
        bcc     LD056                           ; D052 90 02
        inx                                     ; D054 E8

        clc                                     ; D055 18
LD056:
        adc     $92                             ; D056 65 92
        pha                                     ; D058 48
        txa                                     ; D059 8A
        adc     $93                             ; D05A 65 93
        tax                                     ; D05C AA
        pla                                     ; D05D 68
        rts                                     ; D05E 60

; ----------------------------------------------------------------------------
        pla                                     ; D05F 68
        sta     RES                             ; D060 85 00

        clc                                     ; D062 18
        adc     #$03                            ; D063 69 03
        sta     RESB                            ; D065 85 02
        pla                                     ; D067 68
        sta     RES+1                           ; D068 85 01
        adc     #$00                            ; D06A 69 00
        sta     RESB+1                          ; D06C 85 03
        ldx     $07A0                           ; D06E AE A0 07
        ldy     #$01                            ; D071 A0 01
        lda     (RES),y                         ; D073 B1 00
        sta     $07A2,x                         ; D075 9D A2 07
        iny                                     ; D078 C8
        lda     (RES),y                         ; D079 B1 00
        sta     $07A3,x                         ; D07B 9D A3 07
        inx                                     ; D07E E8
        inx                                     ; D07F E8
        stx     $07A0                           ; D080 8E A0 07
        jmp     (RESB)                          ; D083 6C 02 00

; ----------------------------------------------------------------------------
        clc                                     ; D086 18
        bit     $38                             ; D087 24 38
        ldx     $07A0                           ; D089 AE A0 07
        lda     $07A1,x                         ; D08C BD A1 07
        sta     $93                             ; D08F 85 93
        lda     $07A0,x                         ; D091 BD A0 07
        sta     $92                             ; D094 85 92
        dex                                     ; D096 CA
        dex                                     ; D097 CA
        stx     $07A0                           ; D098 8E A0 07
        bcc     LD0B1                           ; D09B 90 14

        jsr     LD02E                           ; D09D 20 2E D0
        sta     $C4                             ; D0A0 85 C4
        stx     $C5                             ; D0A2 86 C5
        lda     $92                             ; D0A4 A5 92
        ldy     $93                             ; D0A6 A4 93
        sta     $BC                             ; D0A8 85 BC
        sty     $BD                             ; D0AA 84 BD
        lda     #$FF                            ; D0AC A9 FF
        sta     $C3                             ; D0AE 85 C3
        rts                                     ; D0B0 60

; ----------------------------------------------------------------------------
LD0B1:
        jsr     LD02E                           ; D0B1 20 2E D0
        sta     RES                             ; D0B4 85 00
        stx     RES+1                           ; D0B6 86 01
        ldy     #$02                            ; D0B8 A0 02
        lda     ($92),y                         ; D0BA B1 92
        cmp     #$0C                            ; D0BC C9 0C
        beq     LD0D4                           ; D0BE F0 14

        jsr     LD0DC                           ; D0C0 20 DC D0
        lda     FACC1M                          ; D0C3 A5 61
        sta     FACC1S                          ; D0C5 85 65
        ora     #$80                            ; D0C7 09 80
        sta     FACC1M                          ; D0C9 85 61
        lda     #$00                            ; D0CB A9 00
        sta     FACC1EX                         ; D0CD 85 66
        lda     #$40                            ; D0CF A9 40
        sta     $BA                             ; D0D1 85 BA
        rts                                     ; D0D3 60

; ----------------------------------------------------------------------------
LD0D4:
        jsr     LD0DF                           ; D0D4 20 DF D0
        lda     #$80                            ; D0D7 A9 80
        sta     $BA                             ; D0D9 85 BA
        rts                                     ; D0DB 60

; ----------------------------------------------------------------------------
LD0DC:
        ldx     #$05                            ; D0DC A2 05
        .byte   $2C                             ; D0DE 2C
LD0DF:
        ldx     #$03                            ; D0DF A2 03

        ldy     #$00                            ; D0E1 A0 00

LD0E3:
        lda     (RES),y                         ; D0E3 B1 00
        sta     FACC1E,y                        ; D0E5 99 60 00
        iny                                     ; D0E8 C8
        dex                                     ; D0E9 CA
        bne     LD0E3                           ; D0EA D0 F7

        rts                                     ; D0EC 60

; ----------------------------------------------------------------------------
LD0ED:
        sta     RES                             ; D0ED 85 00
        sty     RES+1                           ; D0EF 84 01
        lda     ptr_07F9                        ; D0F1 AD F9 07
        ldy     ptr_07F9+1                      ; D0F4 AC FA 07
        sta     ptr00BE                         ; D0F7 85 BE
        sty     ptr00BE+1                       ; D0F9 84 BF
        lda     SCEDEB                          ; D0FB A5 5C
        ldy     SCEDEB+1                        ; D0FD A4 5D
        sty     ptr00C0+1                       ; D0FF 84 C1
LD101:
        sta     ptr00C0                         ; D101 85 C0
        ldy     #$00                            ; D103 A0 00
        lda     (ptr00C0),y                     ; D105 B1 C0
        beq     LD136                           ; D107 F0 2D

        ldy     #$02                            ; D109 A0 02
        lda     RES+1                           ; D10B A5 01
        cmp     (ptr00C0),y                     ; D10D D1 C0
        bcc     LD137                           ; D10F 90 26

        bne     LD11C                           ; D111 D0 09

        dey                                     ; D113 88
        lda     RES                             ; D114 A5 00
        cmp     (ptr00C0),y                     ; D116 D1 C0
        bcc     LD137                           ; D118 90 1D

        beq     LD137                           ; D11A F0 1B

LD11C:
        clc                                     ; D11C 18
        ldy     #$03                            ; D11D A0 03
        lda     (ptr00C0),y                     ; D11F B1 C0
        adc     ptr00BE                         ; D121 65 BE
        sta     ptr00BE                         ; D123 85 BE
        bcc     LD12A                           ; D125 90 03
        inc     ptr00BE+1                       ; D127 E6 BF

        clc                                     ; D129 18

LD12A:
        ldy     #$00                            ; D12A A0 00
        lda     ptr00C0                         ; D12C A5 C0
        adc     (ptr00C0),y                     ; D12E 71 C0
        bcc     LD101                           ; D130 90 CF
        inc     ptr00C0+1                       ; D132 E6 C1
        bcs     LD101                           ; D134 B0 CB

LD136:
        clc                                     ; D136 18
LD137:
        rts                                     ; D137 60

; ----------------------------------------------------------------------------
LD138:
        lda     FISALO                          ; D138 AD 2F 05
        cmp     DESALO                          ; D13B CD 2D 05
        lda     FISALO+1                        ; D13E AD 30 05
        sbc     DESALO+1                        ; D141 ED 2E 05
        bcs     LD14E                           ; D144 B0 08
        jmp     Error_BADVAL                    ; D146 4C FF F0

; ----------------------------------------------------------------------------
LD149:
        bit     FLGTEL                          ; D149 2C 0D 02
        bvs     Error_MINITEL                   ; D14C 70 28
LD14E:
        rts                                     ; D14E 60

; ----------------------------------------------------------------------------
LD14F:
        bit     FLGTEL                          ; D14F 2C 0D 02
        bpl     Error_TEXT                      ; D152 10 1C

        rts                                     ; D154 60

; ----------------------------------------------------------------------------
LD155:
        bit     FLGTEL                          ; D155 2C 0D 02
        bmi     Error_HIRES                     ; D158 30 19

        rts                                     ; D15A 60

; ----------------------------------------------------------------------------
; Vérification de la présence ou non du STRATSED (sortie en erreur le cas échéant)
LD15B:
        lda     FLGTEL                          ; D15B AD 0D 02
        lsr     a                               ; D15E 4A
        bcs     Error_STRATSED                  ; D15F B0 18

        rts                                     ; D161 60

; ----------------------------------------------------------------------------
; Erreur: 'LOG ou LN ou SQR ou ^ : parametre <= 0' ou 'division par 0'
Error_TRIGO:
        ldy     FLERR                           ; D162 A4 8B
        beq     LD14E                           ; D164 F0 E8

        dey                                     ; D166 88
        beq     Error_OVERFLOW                  ; D167 F0 13

        ldx     #$16                            ; D169 A2 16
        dey                                     ; D16B 88
        beq     Error_X                         ; D16C F0 10

        dex                                     ; D16E CA
        .byte   $2C                             ; D16F 2C
; Erreur: ? mode TEXT
Error_TEXT:
        ldx     #$00                            ; D170 A2 00
        .byte   $2C                             ; D172 2C
; Erreur: ? mode HIRES
Error_HIRES:
        ldx     #$01                            ; D173 A2 01
        .byte   $2C                             ; D175 2C
; Erreur: ? mode minitel
Error_MINITEL:
        ldx     #$02                            ; D176 A2 02
        .byte   $2C                             ; D178 2C
; Erreur: pas de STRATSED
Error_STRATSED:
        ldx     #$0B                            ; D179 A2 0B
        .byte   $2C                             ; D17B 2C
; Erreur: nombre trop grand
Error_OVERFLOW:
        ldx     #$14                            ; D17C A2 14

; Affiche une erreur dont le code est dans X. Gère ERRGOTO si actif
Error_X:
        stx     errnb                           ; D17E 8E B7 07
        ldy     #$00                            ; D181 A0 00
        sty     FLERR                           ; D183 84 8B
        ; Récupère len° de la ligne
        iny                                     ; D185 C8
        lda     ($99),y                         ; D186 B1 99
        sta     errnl                           ; D188 8D B8 07
        iny                                     ; D18B C8
        lda     ($99),y                         ; D18C B1 99
        sta     errnl+1                         ; D18E 8D B9 07

        ; Mode direct?
        cmp     #$FF                            ; D191 C9 FF
        beq     LD19B                           ; D193 F0 06

        ; ON ERROR GOTO actif?
        lda     fFlags                          ; D195 A5 8C
        and     #$04                            ; D197 29 04
        bne     LD1CC                           ; D199 D0 31

LD19B:
        ; Affiche le message d'erreur
        XCRLF                                   ; D19B 00 25
        jsr     PrintErrMsg1                    ; D19D 20 7B D5

        ; Mode direct? (dans ce cas Y=$FF et Y+1=$00)
        ldy     errnl+1                         ; D1A0 AC B9 07
        iny                                     ; D1A3 C8
        beq     LD1BD                           ; D1A4 F0 17

        ; Affiche '(ligne nn)'
        ldx     #$04                            ; D1A6 A2 04
        jsr     PrintErrMsg4                    ; D1A8 20 87 D5
        lda     #$00                            ; D1AB A9 00
        sta     DEFAFF                          ; D1AD 85 14
        lda     errnl                           ; D1AF AD B8 07
        ldy     errnl+1                         ; D1B2 AC B9 07
        ldx     #$03                            ; D1B5 A2 03
        XDECIM                                  ; D1B7 00 29
        lda     #$29                            ; D1B9 A9 29
        XWR0                                    ; D1BB 00 10

LD1BD:
        XCRLF                                   ; D1BD 00 25

        ; Code erreur $13 := 'exécution arrêtée' (instruction STOP)
        ldy     errnb                           ; D1BF AC B7 07
        cpy     #$13                            ; D1C2 C0 13
        beq     LD1CC                           ; D1C4 F0 06

        ; Réinitialise la pile 6502 et WARM START
        ldx     #$FF                            ; D1C6 A2 FF
        txs                                     ; D1C8 9A
        jmp     LC068                           ; D1C9 4C 68 C0

; ----------------------------------------------------------------------------
; Saut vers la ligne de traitement d'erreur (ERR GOTO actif)
; Entrée: Y contient le code erreur
LD1CC:
        ldx     saveb_S                         ; D1CC AE BE 07
        inx                                     ; D1CF E8
        inx                                     ; D1D0 E8
        txs                                     ; D1D1 9A

        ; Place l'adresse de début de la ligneayant provoquée l'erreur en $07C0-07C1
        sec                                     ; D1D2 38
        lda     $07BC                           ; D1D3 AD BC 07
        sbc     #$02                            ; D1D6 E9 02
        sta     L07C0                           ; D1D8 8D C0 07
        lda     $07BD                           ; D1DB AD BD 07
        sbc     #$00                            ; D1DE E9 00
        sta     L07C0+1                         ; D1E0 8D C1 07

        ; Code erreur $13 := 'exécution arrêtée' (instruction STOP)
        cpy     #$13                            ; D1E3 C0 13
        beq     LD1EA                           ; D1E5 F0 03

        jmp     (errgotonl)                     ; D1E7 6C BA 07

; ----------------------------------------------------------------------------
LD1EA:
        lda     $C2                             ; D1EA A5 C2
        pha                                     ; D1EC 48
        lda     SP                              ; D1ED AD 00 07
        pha                                     ; D1F0 48
        jmp     LC068                           ; D1F1 4C 68 C0

; ----------------------------------------------------------------------------
LD1F4:
        ldx     #$08                            ; D1F4 A2 08
        .byte   $2C                             ; D1F6 2C
LD1F7:
        ldx     #$00                            ; D1F7 A2 00
        lda     $BA                             ; D1F9 A5 BA
        beq     LD223                           ; D1FB F0 26

        lda     FACC1E,x                        ; D1FD B5 60
        beq     LD227                           ; D1FF F0 26

        bpl     LD224                           ; D201 10 21

        cmp     #$91                            ; D203 C9 91
        bcs     LD224                           ; D205 B0 1D

        lda     FACC1S,x                        ; D207 B5 65
        bmi     LD224                           ; D209 30 19

        lda     #$91                            ; D20B A9 91
        sbc     FACC1E,x                        ; D20D F5 60
        tay                                     ; D20F A8
        beq     LD219                           ; D210 F0 07

LD212:
        lsr     FACC1M,x                        ; D212 56 61
        ror     FACC1M+1,x                      ; D214 76 62
        dey                                     ; D216 88
        bne     LD212                           ; D217 D0 F9

LD219:
        sty     $BA                             ; D219 84 BA
        lda     FACC1M,x                        ; D21B B5 61
        ldy     FACC1M+1,x                      ; D21D B4 62
        sta     FACC1M+1,x                      ; D21F 95 62
        sty     FACC1M,x                        ; D221 94 61
LD223:
        rts                                     ; D223 60

; ----------------------------------------------------------------------------
LD224:
        jmp     Error_BADVAL                    ; D224 4C FF F0

; ----------------------------------------------------------------------------
LD227:
        sta     FACC1M,x                        ; D227 95 61
        sta     FACC1M+1,x                      ; D229 95 62
        sta     $BA                             ; D22B 85 BA
        rts                                     ; D22D 60

; ----------------------------------------------------------------------------
LD22E:
        jsr     LD1F7                           ; D22E 20 F7 D1
        ldx     FACC1M+1                        ; D231 A6 62
        bne     LD224                           ; D233 D0 EF

        lda     FACC1M                          ; D235 A5 61
        rts                                     ; D237 60

; ----------------------------------------------------------------------------
LD238:
        ldx     #$08                            ; D238 A2 08
        .byte   $2C                             ; D23A 2C
LD23B:
        ldx     #$00                            ; D23B A2 00
        ldy     $BA                             ; D23D A4 BA
        bne     LD267                           ; D23F D0 26

        sty     FACC1EX                         ; D241 84 66
        sty     FACC1M+2,x                      ; D243 94 63
        sty     FACC1M+3,x                      ; D245 94 64
        sty     FACC1S,x                        ; D247 94 65
        ldy     #$40                            ; D249 A0 40
        lda     FACC1M,x                        ; D24B B5 61
        ora     FACC1M+1,x                      ; D24D 15 62
        beq     LD263                           ; D24F F0 12

        lda     #$90                            ; D251 A9 90
        sta     FACC1E,x                        ; D253 95 60
        lda     FACC1M+1,x                      ; D255 B5 62
        bmi     LD219                           ; D257 30 C0

LD259:
        dec     FACC1E,x                        ; D259 D6 60
        asl     FACC1M,x                        ; D25B 16 61
        rol     FACC1M+1,x                      ; D25D 36 62
        bpl     LD259                           ; D25F 10 F8

        bmi     LD219                           ; D261 30 B6

LD263:
        sta     FACC1E,x                        ; D263 95 60
        sty     $BA                             ; D265 84 BA
LD267:
        rts                                     ; D267 60

; ----------------------------------------------------------------------------
; Place varptr en $BC-BD et l'adresse de la valeur de la variable en $C4-C5
;
; Appel:
;	JSR $D268
;	.word varptr

        clc                                     ; D268 18
        pla                                     ; D269 68
        sta     RES                             ; D26A 85 00
        adc     #$02                            ; D26C 69 02
        tay                                     ; D26E A8
        pla                                     ; D26F 68
        sta     RES+1                           ; D270 85 01
        adc     #$00                            ; D272 69 00
        pha                                     ; D274 48
        tya                                     ; D275 98
        pha                                     ; D276 48
        ldy     #$02                            ; D277 A0 02
        lda     (RES),y                         ; D279 B1 00
        sta     $BD                             ; D27B 85 BD
        sta     $C5                             ; D27D 85 C5
        dey                                     ; D27F 88
        lda     (RES),y                         ; D280 B1 00
        sta     $BC                             ; D282 85 BC
        ldy     #$06                            ; D284 A0 06
        adc     ($BC),y                         ; D286 71 BC
        sta     $C4                             ; D288 85 C4
        bcc     LD267                           ; D28A 90 DB
        inc     $C5                             ; D28C E6 C5

LD28E:
        rts                                     ; D28E 60

; ----------------------------------------------------------------------------
LD28F:
        ldy     #$03                            ; D28F A0 03
        sty     RES                             ; D291 84 00
        lda     $BA                             ; D293 A5 BA
        sta     ($BC),y                         ; D295 91 BC
        dey                                     ; D297 88
        lda     ($BC),y                         ; D298 B1 BC
        cmp     #$08                            ; D29A C9 08
        beq     LD2D7                           ; D29C F0 39

        cmp     #$0C                            ; D29E C9 0C
        beq     LD2D7                           ; D2A0 F0 35

        cmp     #$0D                            ; D2A2 C9 0D
        bne     LD2A9                           ; D2A4 D0 03

        jsr     LD23B                           ; D2A6 20 3B D2

LD2A9:
        lda     $BA                             ; D2A9 A5 BA
        bmi     Error_EXPRTYP                   ; D2AB 30 25

        beq     LD2C1                           ; D2AD F0 12

        jsr     LD2EB                           ; D2AF 20 EB D2
        lda     #$05                            ; D2B2 A9 05
        sta     RES                             ; D2B4 85 00
        lda     FACC1S                          ; D2B6 A5 65
        ora     #$7F                            ; D2B8 09 7F
        and     FACC1M                          ; D2BA 25 61
        sta     FACC1M                          ; D2BC 85 61
LD2BE:
        ldx     #$00                            ; D2BE A2 00
        .byte   $2C                             ; D2C0 2C
LD2C1:
        ldx     #$01                            ; D2C1 A2 01
        ldy     #$00                            ; D2C3 A0 00
LD2C5:
        lda     FACC1E,x                        ; D2C5 B5 60
        sta     ($C4),y                         ; D2C7 91 C4
        iny                                     ; D2C9 C8
        inx                                     ; D2CA E8
        cpx     RES                             ; D2CB E4 00
        bne     LD2C5                           ; D2CD D0 F6

        jmp     LD51E                           ; D2CF 4C 1E D5

; ----------------------------------------------------------------------------
; Erreur: mauvais type d'expression
Error_EXPRTYP:
        ldx     #$11                            ; D2D2 A2 11
        jmp     Error_X                         ; D2D4 4C 7E D1

; ----------------------------------------------------------------------------
LD2D7:
        lda     $BA                             ; D2D7 A5 BA
        bpl     Error_EXPRTYP                   ; D2D9 10 F7

        jsr     LD2BE                           ; D2DB 20 BE D2
        lda     $07F8                           ; D2DE AD F8 07
        sbc     $07F6                           ; D2E1 ED F6 07
        cmp     #$02                            ; D2E4 C9 02
        bcs     LD28E                           ; D2E6 B0 A6

        jmp     LCE5E                           ; D2E8 4C 5E CE

; ----------------------------------------------------------------------------
LD2EB:
        lda     FACC1E                          ; D2EB A5 60
        beq     LD30D                           ; D2ED F0 1E

        asl     FACC1EX                         ; D2EF 06 66
        bcc     LD30D                           ; D2F1 90 1A

        inc     FACC1M+3                        ; D2F3 E6 64
        bne     LD30D                           ; D2F5 D0 16

        inc     FACC1M+2                        ; D2F7 E6 63
        bne     LD30D                           ; D2F9 D0 12

        inc     FACC1M+1                        ; D2FB E6 62
        bne     LD30D                           ; D2FD D0 0E

        inc     FACC1M                          ; D2FF E6 61
        bne     LD30D                           ; D301 D0 0A

        inc     FACC1E                          ; D303 E6 60
        ror     FACC1M                          ; D305 66 61
        ror     FACC1M+1                        ; D307 66 62
        ror     FACC1M+2                        ; D309 66 63
        ror     FACC1M+3                        ; D30B 66 64

LD30D:
        rts                                     ; D30D 60

; ----------------------------------------------------------------------------
LD30E:
        lda     #$80                            ; D30E A9 80
        .byte   $2C                             ; D310 2C
LD311:
        lda     #$40                            ; D311 A9 40
        .byte   $2C                             ; D313 2C
LD314:
        lda     #$00                            ; D314 A9 00
        sta     RES+1                           ; D316 85 01
        pla                                     ; D318 68
        tax                                     ; D319 AA
        pla                                     ; D31A 68
        tay                                     ; D31B A8
        pla                                     ; D31C 68
        sta     $8E                             ; D31D 85 8E
        pla                                     ; D31F 68
        sta     $8F                             ; D320 85 8F
        pla                                     ; D322 68
        sta     RES                             ; D323 85 00
        pla                                     ; D325 68
        sta     FACC2S                          ; D326 85 6D
        pla                                     ; D328 68
        sta     FACC2E                          ; D329 85 68
        pla                                     ; D32B 68
        sta     FACC2M                          ; D32C 85 69
        pla                                     ; D32E 68
        sta     FACC2M+1                        ; D32F 85 6A
        pla                                     ; D331 68
        sta     FACC2M+2                        ; D332 85 6B
        pla                                     ; D334 68
        sta     FACC2M+3                        ; D335 85 6C
        lda     $8F                             ; D337 A5 8F
        pha                                     ; D339 48
        lda     $8E                             ; D33A A5 8E
        pha                                     ; D33C 48
        tya                                     ; D33D 98
        pha                                     ; D33E 48
        txa                                     ; D33F 8A
        pha                                     ; D340 48
        lda     RES+1                           ; D341 A5 01
        beq     LD35E                           ; D343 F0 19

        bmi     LD35D                           ; D345 30 16

        jsr     LD23B                           ; D347 20 3B D2
        lda     RES                             ; D34A A5 00
        sta     $BA                             ; D34C 85 BA
        jsr     LD238                           ; D34E 20 38 D2
        lda     #$00                            ; D351 A9 00
        sta     FACC1EX                         ; D353 85 66
        lda     FACC1S                          ; D355 A5 65
        eor     FACC2S                          ; D357 45 6D
        sta     FACC2PS                         ; D359 85 6E
        lda     FACC1E                          ; D35B A5 60
LD35D:
        rts                                     ; D35D 60

; ----------------------------------------------------------------------------
LD35E:
        jsr     LD1F7                           ; D35E 20 F7 D1
        lda     RES                             ; D361 A5 00
        sta     $BA                             ; D363 85 BA
        jmp     LD1F4                           ; D365 4C F4 D1

; ----------------------------------------------------------------------------
        jsr     LD40A                           ; D368 20 0A D4
        pla                                     ; D36B 68
        pla                                     ; D36C 68
        clc                                     ; D36D 18
        txa                                     ; D36E 8A
        adc     #$02                            ; D36F 69 02
        tax                                     ; D371 AA
        tya                                     ; D372 98
        adc     #$00                            ; D373 69 00
        pha                                     ; D375 48
        txa                                     ; D376 8A
        pha                                     ; D377 48
        ldy     #$00                            ; D378 A0 00
        sty     FACC1EX                         ; D37A 84 66
        iny                                     ; D37C C8
        lda     (RESB),y                        ; D37D B1 02
        sta     $92                             ; D37F 85 92
        iny                                     ; D381 C8
        lda     (RESB),y                        ; D382 B1 02
        sta     $93                             ; D384 85 93
        lda     ($92),y                         ; D386 B1 92
        tax                                     ; D388 AA
        iny                                     ; D389 C8
        lda     ($92),y                         ; D38A B1 92
        pha                                     ; D38C 48
        ldy     #$06                            ; D38D A0 06
        lda     ($92),y                         ; D38F B1 92
        tay                                     ; D391 A8
        pla                                     ; D392 68
        cpx     #$10                            ; D393 E0 10
        beq     LD39B                           ; D395 F0 04

        cpx     #$06                            ; D397 E0 06
        bne     LD3AC                           ; D399 D0 11

LD39B:
        tya                                     ; D39B 98
        sbc     #$07                            ; D39C E9 07
        sta     FACC1E                          ; D39E 85 60
        lda     $92                             ; D3A0 A5 92
        adc     #$06                            ; D3A2 69 06
        sta     FACC1M                          ; D3A4 85 61
        lda     $93                             ; D3A6 A5 93
        adc     #$00                            ; D3A8 69 00
        bcc     LD3DE                           ; D3AA 90 32

LD3AC:
        cpx     #$11                            ; D3AC E0 11
        beq     LD3BC                           ; D3AE F0 0C

        cpx     #$07                            ; D3B0 E0 07
        beq     LD3BC                           ; D3B2 F0 08

        cpx     #$09                            ; D3B4 E0 09
        bne     LD3CE                           ; D3B6 D0 16

        cmp     #$00                            ; D3B8 C9 00
        bne     LD3E9                           ; D3BA D0 2D

LD3BC:
        lda     ($92),y                         ; D3BC B1 92
        sta     FACC1M                          ; D3BE 85 61
        iny                                     ; D3C0 C8
        ora     ($92),y                         ; D3C1 11 92
        sta     FACC1E                          ; D3C3 85 60
        lda     ($92),y                         ; D3C5 B1 92
        sta     FACC1M+1                        ; D3C7 85 62
        lda     #$00                            ; D3C9 A9 00
        sta     $BA                             ; D3CB 85 BA
        rts                                     ; D3CD 60

; ----------------------------------------------------------------------------
LD3CE:
        cpx     #$08                            ; D3CE E0 08
        bne     LD3E5                           ; D3D0 D0 13

        lda     ($92),y                         ; D3D2 B1 92
        sta     FACC1E                          ; D3D4 85 60
        iny                                     ; D3D6 C8
        lda     ($92),y                         ; D3D7 B1 92
        sta     FACC1M                          ; D3D9 85 61
        iny                                     ; D3DB C8
        lda     ($92),y                         ; D3DC B1 92
LD3DE:
        sta     FACC1M+1                        ; D3DE 85 62
        lda     #$80                            ; D3E0 A9 80
        sta     $BA                             ; D3E2 85 BA
        rts                                     ; D3E4 60

; ----------------------------------------------------------------------------
LD3E5:
        cpx     #$12                            ; D3E5 E0 12
        bne     LD409                           ; D3E7 D0 20

LD3E9:
        lda     ($92),y                         ; D3E9 B1 92
        sta     FACC1E                          ; D3EB 85 60
        iny                                     ; D3ED C8
        lda     ($92),y                         ; D3EE B1 92
        sta     FACC1S                          ; D3F0 85 65
        ora     #$80                            ; D3F2 09 80
        sta     FACC1M                          ; D3F4 85 61
        iny                                     ; D3F6 C8
        lda     ($92),y                         ; D3F7 B1 92
        sta     FACC1M+1                        ; D3F9 85 62
        iny                                     ; D3FB C8
        lda     ($92),y                         ; D3FC B1 92
        sta     FACC1M+2                        ; D3FE 85 63
        iny                                     ; D400 C8
        lda     ($92),y                         ; D401 B1 92
        sta     FACC1M+3                        ; D403 85 64
        lda     #$40                            ; D405 A9 40
        sta     $BA                             ; D407 85 BA
LD409:
        rts                                     ; D409 60

; ----------------------------------------------------------------------------
LD40A:
        pla                                     ; D40A 68
        clc                                     ; D40B 18
        adc     #$01                            ; D40C 69 01
        sta     RES                             ; D40E 85 00
        pla                                     ; D410 68
        adc     #$00                            ; D411 69 00
        sta     RES+1                           ; D413 85 01
        pla                                     ; D415 68
        tax                                     ; D416 AA
        pla                                     ; D417 68
        tay                                     ; D418 A8
        inc     $C3                             ; D419 E6 C3
        beq     LD43B                           ; D41B F0 1E

        bit     $BA                             ; D41D 24 BA
        bmi     LD426                           ; D41F 30 05

        bvc     LD426                           ; D421 50 03

        jsr     LD2EB                           ; D423 20 EB D2

LD426:
        lda     FACC1M+3                        ; D426 A5 64
        pha                                     ; D428 48
        lda     FACC1M+2                        ; D429 A5 63
        pha                                     ; D42B 48
        lda     FACC1M+1                        ; D42C A5 62
        pha                                     ; D42E 48
        lda     FACC1M                          ; D42F A5 61
        pha                                     ; D431 48
        lda     FACC1E                          ; D432 A5 60
        pha                                     ; D434 48
        lda     FACC1S                          ; D435 A5 65
        pha                                     ; D437 48
        lda     $BA                             ; D438 A5 BA
        pha                                     ; D43A 48

LD43B:
        tya                                     ; D43B 98
        pha                                     ; D43C 48
        txa                                     ; D43D 8A
        pha                                     ; D43E 48
        stx     RESB                            ; D43F 86 02
        sty     RESB+1                          ; D441 84 03
        jmp     (RES)                           ; D443 6C 00 00

; ----------------------------------------------------------------------------
LD446:
        ldx     #$0C                            ; D446 A2 0C
        .byte   $2C                             ; D448 2C
LD449:
        ldx     #$06                            ; D449 A2 06
        .byte   $2C                             ; D44B 2C
LD44C:
        ldx     #$00                            ; D44C A2 00
        .byte   $2C                             ; D44E 2C
; Lit une valeur <255, résultat dans ACC
GetByte:
        ldx     #$C3                            ; D44F A2 C3

LD451:
        jsr     LD486                           ; D451 20 86 D4
        beq     LD4CB                           ; D454 F0 75

        jmp     Error_OVERFLOW                  ; D456 4C 7C D1

; ----------------------------------------------------------------------------
LD459:
        cpx     #$C3                            ; D459 E0 C3
        beq     GetWord                         ; D45B F0 27

        lda     $9C,x                           ; D45D B5 9C
        beq     LD4C7                           ; D45F F0 66

        lda     $9D,x                           ; D461 B5 9D
        beq     LD4A5                           ; D463 F0 40

        lda     $9E,x                           ; D465 B5 9E
        bpl     LD49D                           ; D467 10 34

        and     #$7F                            ; D469 29 7F
        sta     $9E,x                           ; D46B 95 9E
        jsr     LD486                           ; D46D 20 86 D4
        clc                                     ; D470 18
        eor     #$FF                            ; D471 49 FF
        adc     #$01                            ; D473 69 01
        pha                                     ; D475 48
        tya                                     ; D476 98
        eor     #$FF                            ; D477 49 FF
        adc     #$00                            ; D479 69 00
        tay                                     ; D47B A8
        pla                                     ; D47C 68
        rts                                     ; D47D 60

; ----------------------------------------------------------------------------
LD47E:
        ldx     #$06                            ; D47E A2 06
        .byte   $2C                             ; D480 2C
LD481:
        ldx     #$00                            ; D481 A2 00
        .byte   $2C                             ; D483 2C
; Lit une valeur <65536, résultat dans AY (ACC=LSB)
GetWord:
        ldx     #$C3                            ; D484 A2 C3
LD486:
        cpx     #$C3                            ; D486 E0 C3
        bne     LD48F                           ; D488 D0 05

        lda     $BA                             ; D48A A5 BA
        jmp     LD491                           ; D48C 4C 91 D4

; ----------------------------------------------------------------------------
LD48F:
        lda     $9C,x                           ; D48F B5 9C
LD491:
        beq     LD4C7                           ; D491 F0 34

        cpx     #$C3                            ; D493 E0 C3
        bne     LD49D                           ; D495 D0 06

        lda     FACC1S                          ; D497 A5 65
        bmi     LD4CC                           ; D499 30 31

        bpl     LD4A5                           ; D49B 10 08

LD49D:
        lda     $9E,x                           ; D49D B5 9E
        bmi     LD4CC                           ; D49F 30 2B

        ora     #$80                            ; D4A1 09 80
        sta     $9E,x                           ; D4A3 95 9E
LD4A5:
        lda     $9D,x                           ; D4A5 B5 9D
        beq     LD4CF                           ; D4A7 F0 26

        bpl     LD4CC                           ; D4A9 10 21

        cmp     #$91                            ; D4AB C9 91
        bcs     LD4CC                           ; D4AD B0 1D

        lda     #$91                            ; D4AF A9 91
        sbc     $9D,x                           ; D4B1 F5 9D
        tay                                     ; D4B3 A8
LD4B4:
        dey                                     ; D4B4 88
        bmi     LD4BE                           ; D4B5 30 07

        lsr     $9E,x                           ; D4B7 56 9E
        ror     $9F,x                           ; D4B9 76 9F
        jmp     LD4B4                           ; D4BB 4C B4 D4

; ----------------------------------------------------------------------------
LD4BE:
        lda     $9F,x                           ; D4BE B5 9F
        ldy     $9E,x                           ; D4C0 B4 9E
        sta     $9E,x                           ; D4C2 95 9E
        sty     $9F,x                           ; D4C4 94 9F
        rts                                     ; D4C6 60

; ----------------------------------------------------------------------------
LD4C7:
        lda     $9E,x                           ; D4C7 B5 9E
        ldy     $9F,x                           ; D4C9 B4 9F
LD4CB:
        rts                                     ; D4CB 60

; ----------------------------------------------------------------------------
LD4CC:
        jmp     Error_BADVAL                    ; D4CC 4C FF F0

; ----------------------------------------------------------------------------
LD4CF:
        lda     #$00                            ; D4CF A9 00
        tay                                     ; D4D1 A8
        sta     $9E,x                           ; D4D2 95 9E
        sty     $9F,x                           ; D4D4 94 9F
        rts                                     ; D4D6 60

; ----------------------------------------------------------------------------
LD4D7:
        ldx     $C9                             ; D4D7 A6 C9
        lda     $BA                             ; D4D9 A5 BA
        sta     $9C,x                           ; D4DB 95 9C
        cmp     #$40                            ; D4DD C9 40
        bne     LD4E8                           ; D4DF D0 07

        lda     FACC1S                          ; D4E1 A5 65
        ora     #$7F                            ; D4E3 09 7F
        and     FACC1M                          ; D4E5 25 61
        .byte   $2C                             ; D4E7 2C
LD4E8:
        lda     FACC1M                          ; D4E8 A5 61
        sta     $9E,x                           ; D4EA 95 9E
        lda     FACC1E                          ; D4EC A5 60
        sta     $9D,x                           ; D4EE 95 9D
        lda     FACC1M+1                        ; D4F0 A5 62
        sta     $9F,x                           ; D4F2 95 9F
        lda     FACC1M+2                        ; D4F4 A5 63
        sta     $A0,x                           ; D4F6 95 A0
        lda     FACC1M+3                        ; D4F8 A5 64
        sta     $A1,x                           ; D4FA 95 A1
        ldy     #$FF                            ; D4FC A0 FF
        sty     $C3                             ; D4FE 84 C3
        txa                                     ; D500 8A
        clc                                     ; D501 18
        adc     #$06                            ; D502 69 06
        sta     $C9                             ; D504 85 C9
        rts                                     ; D506 60

; ----------------------------------------------------------------------------
; Appel assemblé en début de ligne pour gérer le mode TRACE et CTRL+C
;
; Appel:
;	JSR TraceLine
;	.word numero_ligne_basic
;	code assembleur de la ligne basic
;
TraceLine:
        ; Ajuste l'adresse de retour dans la pile 6502
        ; Copie l'adresse de retour d'origine en $99-9A
        ; $07BC-07BD: Adresse ajustée (pointe après le numéro de la ligne)
        ; saveb_S: Copie du pointeur de pile 6502
        tsx                                     ; D507 BA
        clc                                     ; D508 18
        pla                                     ; D509 68
        sta     $99                             ; D50A 85 99
        sta     $07BC                           ; D50C 8D BC 07
        adc     #$02                            ; D50F 69 02
        pha                                     ; D511 48
        ldy     $0102,x                         ; D512 BC 02 01
        sty     $9A                             ; D515 84 9A
        bcc     LD528                           ; D517 90 0F

        inc     $0102,x                         ; D519 FE 02 01
        bcs     LD528                           ; D51C B0 0A

LD51E:
        tsx                                     ; D51E BA
        lda     $0101,x                         ; D51F BD 01 01
        ldy     $0102,x                         ; D522 BC 02 01
        sta     $07BC                           ; D525 8D BC 07

LD528:
        sty     $07BD                           ; D528 8C BD 07
        stx     saveb_S                         ; D52B 8E BE 07

        ; CTRL+C?
        ldx     KBDCTC                          ; D52E AE 7E 02
        bne     Break                           ; D531 D0 40

        stx     $C9                             ; D533 86 C9
        stx     $07A0                           ; D535 8E A0 07
        lda     #$05                            ; D538 A9 05
        sta     $02A8                           ; D53A 8D A8 02
        dex                                     ; D53D CA
        stx     $C3                             ; D53E 86 C3
        bit     fFlags                          ; D540 24 8C
        bmi     LD545                           ; D542 30 01

        rts                                     ; D544 60

; ----------------------------------------------------------------------------
; Affiche le n° de la ligne courante (mode TRACE)
LD545:
        ldy     #$01                            ; D545 A0 01
        lda     ($99),y                         ; D547 B1 99
        pha                                     ; D549 48
        iny                                     ; D54A C8
        lda     ($99),y                         ; D54B B1 99
        tay                                     ; D54D A8
        pla                                     ; D54E 68
        jsr     LD559                           ; D54F 20 59 D5
        XWSTR3                                  ; D552 00 17
        lda     #$20                            ; D554 A9 20
        XWR3                                    ; D556 00 13
        rts                                     ; D558 60

; ----------------------------------------------------------------------------
LD559:
        ldx     #$00                            ; D559 A2 00
        stx     TR5                             ; D55B 86 11
        ldx     #$01                            ; D55D A2 01
        stx     TR6                             ; D55F 86 12
        ldx     #$20                            ; D561 A2 20
        stx     DEFAFF                          ; D563 86 14
        ldx     #$03                            ; D565 A2 03
        XBINDX                                  ; D567 00 28
        ldx     #$00                            ; D569 A2 00
        stx     $0105                           ; D56B 8E 05 01
        lda     #$00                            ; D56E A9 00
        ldy     #$01                            ; D570 A0 01
        rts                                     ; D572 60

; ----------------------------------------------------------------------------
; Traitement CTRL+C ou STOP
Break:
        asl     KBDCTC                          ; D573 0E 7E 02
        ldx     #$13                            ; D576 A2 13
        jmp     Error_X                         ; D578 4C 7E D1

; ----------------------------------------------------------------------------
PrintErrMsg1:
        lda     #$96                            ; D57B A9 96
        ldy     #$D6                            ; D57D A0 D6
        bne     LD591                           ; D57F D0 10

PrintErrMsg2:
        lda     #$70                            ; D581 A9 70
        ldy     #$D7                            ; D583 A0 D7
        bne     LD591                           ; D585 D0 0A

PrintErrMsg4:
        lda     #$30                            ; D587 A9 30
        ldy     #$D8                            ; D589 A0 D8
        bne     LD591                           ; D58B D0 04

PrintErrMsg3:
        lda     #$D6                            ; D58D A9 D6
        ldy     #$D7                            ; D58F A0 D7

LD591:
        sta     RESB                            ; D591 85 02
        sty     RESB+1                          ; D593 84 03
        ldy     #$00                            ; D595 A0 00

LD597:
        dex                                     ; D597 CA
        bmi     LD5A6                           ; D598 30 0C

LD59A:
        inc     RESB                            ; D59A E6 02
        bne     LD5A0                           ; D59C D0 02
        inc     RESB+1                          ; D59E E6 03

LD5A0:
        lda     (RESB),y                        ; D5A0 B1 02
        bpl     LD59A                           ; D5A2 10 F6

        bmi     LD597                           ; D5A4 30 F1

LD5A6:
        iny                                     ; D5A6 C8
        lda     (RESB),y                        ; D5A7 B1 02
        php                                     ; D5A9 08
        and     #$7F                            ; D5AA 29 7F
        cmp     #$20                            ; D5AC C9 20
        bcs     LD5D1                           ; D5AE B0 21

        tax                                     ; D5B0 AA
        cmp     #$1C                            ; D5B1 C9 1C
        bcs     LD5CE                           ; D5B3 B0 19

        lda     RESB+1                          ; D5B5 A5 03
        pha                                     ; D5B7 48
        lda     RESB                            ; D5B8 A5 02
        pha                                     ; D5BA 48

LD5BB:
        tya                                     ; D5BB 98
        pha                                     ; D5BC 48
        lda     #$DF                            ; D5BD A9 DF
        ldy     #$D5                            ; D5BF A0 D5
        jsr     LD591                           ; D5C1 20 91 D5
        pla                                     ; D5C4 68
        tay                                     ; D5C5 A8
        pla                                     ; D5C6 68
        sta     RESB                            ; D5C7 85 02
        pla                                     ; D5C9 68
        sta     RESB+1                          ; D5CA 85 03
        bne     LD5D3                           ; D5CC D0 05

LD5CE:
        lda     LD5BB,x                         ; D5CE BD BB D5
LD5D1:
        XWR0                                    ; D5D1 00 10
LD5D3:
        plp                                     ; D5D3 28
        bpl     LD5A6                           ; D5D4 10 D0

        rts                                     ; D5D6 60

; ----------------------------------------------------------------------------
; Correspondance pour les caractères [$1C..$1F]
ERRMSG_table0:
        .byte   $0A,$0D,$1F,$18                 ; D5D7 0A 0D 1F 18
; ----------------------------------------------------------------------------
; Affiche un ' ' sur le canal 0
Print0_SPACE:
        lda     #$20                            ; D5DB A9 20
        XWR0                                    ; D5DD 00 10
        rts                                     ; D5DF 60

; ----------------------------------------------------------------------------
; Mots utilisés par les tables suivantes. Dernier caractère: b7=1.
ERRMSG_table0:
        .byte   "? mode"                        ; D5E0 3F 20 6D 6F 64 65
        .byte   $A0                             ; D5E6 A0
        .byte   "fichier"                       ; D5E7 66 69 63 68 69 65 72
        .byte   $A0                             ; D5EE A0
        .byte   "disquette"                     ; D5EF 64 69 73 71 75 65 74 74
                                                ; D5F7 65
        .byte   $A0                             ; D5F8 A0
        .byte   "mauvais"                       ; D5F9 6D 61 75 76 61 69 73
        .byte   $A0                             ; D600 A0
        .byte   "typ"                           ; D601 74 79 70
        .byte   $E5                             ; D604 E5
        .byte   "STRATSE"                       ; D605 53 54 52 41 54 53 45
        .byte   $C4                             ; D60C C4
        .byte   " de"                           ; D60D 20 64 65
        .byte   $A0                             ; D610 A0
        .byte   " non"                          ; D611 20 6E 6F 6E
        .byte   $A0                             ; D615 A0
        .byte   " incorrec"                     ; D616 20 69 6E 63 6F 72 72 65
                                                ; D61E 63
        .byte   $F4                             ; D61F F4
        .byte   " trop"                         ; D620 20 74 72 6F 70
        .byte   $A0                             ; D625 A0
        .byte   "parametr"                      ; D626 70 61 72 61 6D 65 74 72
        .byte   $E5                             ; D62E E5
        .byte   "NEX"                           ; D62F 4E 45 58
        .byte   $D4                             ; D632 D4
        .byte   "gran"                          ; D633 67 72 61 6E
        .byte   $E4                             ; D637 E4
        .byte   "GOSU"                          ; D638 47 4F 53 55
        .byte   $C2                             ; D63C C2
        .byte   " sans"                         ; D63D 20 73 61 6E 73
        .byte   $A0                             ; D642 A0
        .byte   "expression"                    ; D643 65 78 70 72 65 73 73 69
                                                ; D64B 6F 6E
        .byte   $A0                             ; D64D A0
        .byte   "variable"                      ; D64E 76 61 72 69 61 62 6C 65
        .byte   $A0                             ; D656 A0
        .byte   " ou"                           ; D657 20 6F 75
        .byte   $A0                             ; D65A A0
        .byte   "lign"                          ; D65B 6C 69 67 6E
        .byte   $E5                             ; D65F E5
        .byte   "labe"                          ; D660 6C 61 62 65
        .byte   $EC                             ; D664 EC
        .byte   "nombr"                         ; D665 6E 6F 6D 62 72
        .byte   $E5                             ; D66A E5
        .byte   "alph"                          ; D66B 61 6C 70 68
        .byte   $E1                             ; D66F E1
        .byte   "numeriqu"                      ; D670 6E 75 6D 65 72 69 71 75
        .byte   $E5                             ; D678 E5
        .byte   "chain"                         ; D679 63 68 61 69 6E
        .byte   $E5                             ; D67E E5
        .byte   "COUN"                          ; D67F 43 4F 55 4E
        .byte   $D4,$22                         ; D683 D4 22
        .byte   " "                             ; D685 20
        .byte   $BF                             ; D686 BF
        .byte   "absen"                         ; D687 61 62 73 65 6E
        .byte   $F4                             ; D68C F4
        .byte   "Liste des"                     ; D68D 4C 69 73 74 65 20 64 65
                                                ; D695 73
        .byte   $A0                             ; D696 A0

; Erreurs d'exécution. Dernier caractère: b1=1, un octet <$1C:  index dans la table1.
ERRMSG_table1:
        .byte   $00                             ; D697 00
        .byte   "TEX"                           ; D698 54 45 58
        .byte   $D4,$00                         ; D69B D4 00
        .byte   "HIRE"                          ; D69D 48 49 52 45
        .byte   $D3,$00                         ; D6A1 D3 00
        .byte   "minite"                        ; D6A3 6D 69 6E 69 74 65
        .byte   $EC,$B3,$01,$9A                 ; D6A9 EC B3 01 9A
        .byte   "erreur d'E/"                   ; D6AD 65 72 72 65 75 72 20 64
                                                ; D6B5 27 45 2F
        .byte   $D3,$01                         ; D6B8 D3 01
        .byte   "existan"                       ; D6BA 65 78 69 73 74 61 6E
        .byte   $F4,$02                         ; D6C1 F4 02
        .byte   "sature"                        ; D6C3 73 61 74 75 72 65
        .byte   $E5,$02                         ; D6C9 E5 02
        .byte   "protege"                       ; D6CB 70 72 6F 74 65 67 65
        .byte   $E5,$03,$04,$06,$81,$02,$07,$85 ; D6D2 E5 03 04 06 81 02 07 85
        .byte   "pas"                           ; D6DA 70 61 73
        .byte   $06,$85                         ; D6DD 06 85
        .byte   "nom"                           ; D6DF 6E 6F 6D
        .byte   $06,$01                         ; D6E2 06 01
        .byte   "incorrec"                      ; D6E4 69 6E 63 6F 72 72 65 63
        .byte   $F4                             ; D6EC F4
        .byte   "lecteur "                      ; D6ED 6C 65 63 74 65 75 72 20
        .byte   $9A,$01                         ; D6F5 9A 01
        .byte   "ouver"                         ; D6F7 6F 75 76 65 72
        .byte   $F4,$01                         ; D6FC F4 01
        .byte   "ferm"                          ; D6FE 66 65 72 6D
        .byte   $E5                             ; D702 E5
        .byte   "fin"                           ; D703 66 69 6E
        .byte   $06,$81,$03,$04                 ; D706 06 81 03 04
        .byte   " d'"                           ; D70A 20 64 27
        .byte   $8F                             ; D70D 8F
        .byte   "valeur"                        ; D70E 76 61 6C 65 75 72
        .byte   $08,$E5                         ; D714 08 E5
        .byte   "execution arrete"              ; D716 65 78 65 63 75 74 69 6F
                                                ; D71E 6E 20 61 72 72 65 74 65
        .byte   $E5,$14,$09,$8C                 ; D726 E5 14 09 8C
        .byte   "division par "                 ; D72A 64 69 76 69 73 69 6F 6E
                                                ; D732 20 70 61 72 20
        .byte   $B0                             ; D737 B0
        .byte   "LOG"                           ; D738 4C 4F 47
        .byte   $11                             ; D73B 11
        .byte   "LN"                            ; D73C 4C 4E
        .byte   $11                             ; D73E 11
        .byte   "SQR"                           ; D73F 53 51 52
        .byte   $11                             ; D742 11
        .byte   "^ : "                          ; D743 5E 20 3A 20
        .byte   $0A                             ; D747 0A
        .byte   " <= "                          ; D748 20 3C 3D 20
        .byte   $B0,$03,$8B                     ; D74C B0 03 8B
        .byte   "index"                         ; D74F 69 6E 64 65 78
        .byte   $06                             ; D754 06
        .byte   "tableau"                       ; D755 74 61 62 6C 65 61 75
        .byte   $09,$8C                         ; D75C 09 8C
        .byte   "RETURN"                        ; D75E 52 45 54 55 52 4E
        .byte   $0E,$8D,$17,$09                 ; D764 0E 8D 17 09
        .byte   "longu"                         ; D768 6C 6F 6E 67 75
        .byte   $E5,$09,$06,$8D                 ; D76D E5 09 06 8D

ERRMSG_table2:
        .byte   $1E                             ; D771 1E
        .byte   "@AAttention:"                  ; D772 40 41 41 74 74 65 6E 74
                                                ; D77A 69 6F 6E 3A
        .byte   $A0                             ; D77E A0
        .byte   "plus"                          ; D77F 70 6C 75 73
        .byte   $06,$8A                         ; D783 06 8A
        .byte   "SET"                           ; D785 53 45 54
        .byte   $11                             ; D788 11
        .byte   "OF"                            ; D789 4F 46
        .byte   $C6,$0F,$96,$0F,$15,$96         ; D78B C6 0F 96 0F 15 96
        .byte   "No"                            ; D791 4E 6F
        .byte   $06,$12,$11,$93,$93,$8F,$22     ; D793 06 12 11 93 93 8F 22
        .byte   "("                             ; D79A 28
        .byte   $99,$22                         ; D79B 99 22
        .byte   ")"                             ; D79D 29
        .byte   $99,$22                         ; D79E 99 22
        .byte   ","                             ; D7A0 2C
        .byte   $99,$14,$09,$8C,$10,$15,$96,$10 ; D7A1 99 14 09 8C 10 15 96 10
        .byte   $96,$90,$22                     ; D7A9 96 90 22
        .byte   "="                             ; D7AC 3D
        .byte   $99,$22                         ; D7AD 99 22
        .byte   "TO"                            ; D7AF 54 4F
        .byte   $99,$22                         ; D7B1 99 22
        .byte   "THEN"                          ; D7B3 54 48 45 4E
        .byte   $99,$22                         ; D7B7 99 22
        .byte   "ELSE"                          ; D7B9 45 4C 53 45
        .byte   $99,$BF                         ; D7BD 99 BF
        .byte   "caracter"                      ; D7BF 63 61 72 61 63 74 65 72
        .byte   $E5                             ; D7C7 E5
        .byte   "2eme "                         ; D7C8 32 65 6D 65 20
        .byte   $22                             ; D7CD 22
        .byte   "'"                             ; D7CE 27
        .byte   $99,$BF,$22                     ; D7CF 99 BF 22
        .byte   "STEP"                          ; D7D2 53 54 45 50
        .byte   $99                             ; D7D6 99

ERRMSG_table3:
        .byte   $BF                             ; D7D7 BF
        .byte   " "                             ; D7D8 20
        .byte   $12                             ; D7D9 12
        .byte   "/"                             ; D7DA 2F
        .byte   $13,$A0                         ; D7DB 13 A0
        .byte   "UN"                            ; D7DD 55 4E
        .byte   $18,$0E,$98,$0B,$0E             ; D7DF 18 0E 98 0B 0E
        .byte   "FO"                            ; D7E4 46 4F
        .byte   $D2,$80                         ; D7E6 D2 80
        .byte   "UNTIL"                         ; D7E8 55 4E 54 49 4C
        .byte   $0E                             ; D7ED 0E
        .byte   "REPEA"                         ; D7EE 52 45 50 45 41
        .byte   $DE                             ; D7F3 DE
        .byte   " "                             ; D7F4 20
        .byte   $1A,$1D,$9C                     ; D7F5 1A 1D 9C
        .byte   " "                             ; D7F8 20
        .byte   $13,$A0                         ; D7F9 13 A0
        .byte   " defini plusieurs fois"        ; D7FB 20 64 65 66 69 6E 69 20
                                                ; D803 70 6C 75 73 69 65 75 72
                                                ; D80B 73 20 66 6F 69 73
        .byte   $1D,$9C,$BF                     ; D811 1D 9C BF
        .byte   "PASSE I"                       ; D814 50 41 53 53 45 20 49
        .byte   $E1                             ; D81B E1
        .byte   "-I"                            ; D81C 2D 49
        .byte   $E2                             ; D81E E2
        .byte   "-I"                            ; D81F 2D 49
        .byte   $E3                             ; D821 E3
        .byte   "-II"                           ; D822 2D 49 49
        .byte   $1D,$9C                         ; D825 1D 9C
        .byte   "WEND"                          ; D827 57 45 4E 44
        .byte   $0E                             ; D82B 0E
        .byte   "WHIL"                          ; D82C 57 48 49 4C
        .byte   $C5                             ; D830 C5

ERRMSG_table4:
        .byte   $1D,$1C                         ; D831 1D 1C
        .byte   "essayez WORD,FUNCTION,ERRLIST !"; D833 65 73 73 61 79 65 7A 20
                                                ; D83B 57 4F 52 44 2C 46 55 4E
                                                ; D843 43 54 49 4F 4E 2C 45 52
                                                ; D84B 52 4C 49 53 54 20 21
        .byte   $1D,$9C,$1D                     ; D852 1D 9C 1D
        .byte   "44 Ko libres"                  ; D855 34 34 20 4B 6F 20 6C 69
                                                ; D85D 62 72 65 73
        .byte   $1D,$1C,$9C,$1E                 ; D861 1D 1C 9C 1E
        .byte   "@A"                            ; D865 40 41
        .byte   $9F                             ; D867 9F
        .byte   " "                             ; D868 20
        .byte   $1D,$9C                         ; D869 1D 9C
        .byte   " ("                            ; D86B 20 28
        .byte   $12,$A0                         ; D86D 12 A0

hyperbas_signature:
        .byte   "HYPER BASIC V2.0b"             ; D86F 48 59 50 45 52 20 42 41
                                                ; D877 53 49 43 20 56 32 2E 30
                                                ; D87F 62
        .byte   $0D,$0A                         ; D880 0D 0A
        .byte   "(c) 1986 ORIC International"   ; D882 28 63 29 20 31 39 38 36
                                                ; D88A 20 4F 52 49 43 20 49 6E
                                                ; D892 74 65 72 6E 61 74 69 6F
                                                ; D89A 6E 61 6C
        .byte   $0D,$0A,$00                     ; D89D 0D 0A 00

; ----------------------------------------------------------------------------
; Début Passe Ia
Passe_Ia:
        ldx     #$0A                            ; D8A0 A2 0A
        jsr     PrintPasse_A                    ; D8A2 20 6B DF

        lda     L07FD                           ; D8A5 AD FD 07
        ldx     L07FD+1                         ; D8A8 AE FE 07
LD8AB:
        sta     $92                             ; D8AB 85 92
        stx     $93                             ; D8AD 86 93
        ldy     #$01                            ; D8AF A0 01
        lda     ($92),y                         ; D8B1 B1 92
        beq     Passe_Ib                        ; D8B3 F0 22

        iny                                     ; D8B5 C8
        lda     ($92),y                         ; D8B6 B1 92
        cmp     #$06                            ; D8B8 C9 06
        beq     LD8C4                           ; D8BA F0 08

        cmp     #$0C                            ; D8BC C9 0C
        bcc     LD8C9                           ; D8BE 90 09

        cmp     #$0E                            ; D8C0 C9 0E
        bcs     LD8C9                           ; D8C2 B0 05

LD8C4:
        iny                                     ; D8C4 C8
        lda     #$03                            ; D8C5 A9 03
        sta     ($92),y                         ; D8C7 91 92
LD8C9:
        ldy     #$01                            ; D8C9 A0 01
        lda     ($92),y                         ; D8CB B1 92
        tax                                     ; D8CD AA
        dey                                     ; D8CE 88
        lda     ($92),y                         ; D8CF B1 92
        jmp     LD8AB                           ; D8D1 4C AB D8

; ----------------------------------------------------------------------------
LD8D4:
        jmp     Passe_Ic                        ; D8D4 4C 98 D9

; ----------------------------------------------------------------------------
; Début Passe Ib
Passe_Ib:
        ldx     #$0B                            ; D8D7 A2 0B
        jsr     PrintPasse_A                    ; D8D9 20 6B DF
        lda     SCEDEB                          ; D8DC A5 5C
        ldx     SCEDEB+1                        ; D8DE A6 5D
        stx     TR1                             ; D8E0 86 0D

LD8E2:
        ; Fin du source atteinte? -> Passe_Ic
        sta     TR0                             ; D8E2 85 0C
        ldy     #$00                            ; D8E4 A0 00
        lda     (TR0),y                         ; D8E6 B1 0C
        beq     LD8D4                           ; D8E8 F0 EA

        ldy     #$04                            ; D8EA A0 04
        lda     (TR0),y                         ; D8EC B1 0C
        beq     LD91C                           ; D8EE F0 2C

        cmp     #$C0                            ; D8F0 C9 C0
        bne     LD95D                           ; D8F2 D0 69

        iny                                     ; D8F4 C8
        lda     (TR0),y                         ; D8F5 B1 0C
        cmp     #$CC                            ; D8F7 C9 CC
        bne     LD95D                           ; D8F9 D0 62

        ; Cherche le type du token pointé par (TR0),Y
        ldy     #$09                            ; D8FB A0 09
        jsr     LD96C                           ; D8FD 20 6C D9

        ldy     #$06                            ; D900 A0 06
        lda     ($92),y                         ; D902 B1 92
        tay                                     ; D904 A8
        lda     ($92),y                         ; D905 B1 92
        tax                                     ; D907 AA
        iny                                     ; D908 C8
        lda     ($92),y                         ; D909 B1 92
        inx                                     ; D90B E8
        bne     LD911                           ; D90C D0 03

        clc                                     ; D90E 18
        adc     #$01                            ; D90F 69 01
LD911:
        pha                                     ; D911 48
        txa                                     ; D912 8A
        pha                                     ; D913 48

        ; Cherche le type du token pointé par (TR0),Y
        ldy     #$06                            ; D914 A0 06
        jsr     LD96C                           ; D916 20 6C D9

        jmp     LD94B                           ; D919 4C 4B D9

; ----------------------------------------------------------------------------
LD91C:
        ; Cherche le type du token pointé par (TR0),Y
        iny                                     ; D91C C8
        jsr     LD96C                           ; D91D 20 6C D9

        lda     $95                             ; D920 A5 95
        cmp     #$03                            ; D922 C9 03
        beq     LD942                           ; D924 F0 1C

        ; Erreur: 'label'
        ldx     #$07                            ; D926 A2 07
        jsr     PrintErrMsg3                    ; D928 20 8D D5

        ldy     #$06                            ; D92B A0 06
        lda     ($92),y                         ; D92D B1 92
        sta     RESB                            ; D92F 85 02
LD931:
        iny                                     ; D931 C8
        cpy     RESB                            ; D932 C4 02
        beq     LD93D                           ; D934 F0 07

        lda     ($92),y                         ; D936 B1 92
        XWR0                                    ; D938 00 10
        jmp     LD931                           ; D93A 4C 31 D9

; ----------------------------------------------------------------------------
LD93D:
        ; Erreur: 'defini plusieurs fois'
        ldx     #$08                            ; D93D A2 08
        jsr     PrintErrMsg3                    ; D93F 20 8D D5

LD942:
        ldy     #$02                            ; D942 A0 02
        lda     (TR0),y                         ; D944 B1 0C
        pha                                     ; D946 48
        dey                                     ; D947 88
        lda     (TR0),y                         ; D948 B1 0C
        pha                                     ; D94A 48
LD94B:
        ldy     #$03                            ; D94B A0 03
        lda     #$00                            ; D94D A9 00
        sta     ($92),y                         ; D94F 91 92
        ldy     #$06                            ; D951 A0 06
        lda     ($92),y                         ; D953 B1 92
        tay                                     ; D955 A8
        pla                                     ; D956 68
        sta     ($92),y                         ; D957 91 92
        iny                                     ; D959 C8
        pla                                     ; D95A 68
        sta     ($92),y                         ; D95B 91 92
LD95D:
        clc                                     ; D95D 18
        ldy     #$00                            ; D95E A0 00
        lda     (TR0),y                         ; D960 B1 0C
        adc     TR0                             ; D962 65 0C
        bcc     LD968                           ; D964 90 02
        inc     TR1                             ; D966 E6 0D

LD968:
        jmp     LD8E2                           ; D968 4C E2 D8

; ----------------------------------------------------------------------------
LD96B:
        rts                                     ; D96B 60

; ----------------------------------------------------------------------------
; Cherche le type du token pointé par (TR0),Y
LD96C:
        lda     (TR0),y                         ; D96C B1 0C
        sta     $96                             ; D96E 85 96
        iny                                     ; D970 C8
        lda     (TR0),y                         ; D971 B1 0C
        sta     $97                             ; D973 85 97
        ; Cherche le type du token contenu en $96-97
        jmp     LCA8A                           ; D975 4C 8A CA

; ----------------------------------------------------------------------------
; Erreur: 'ligne/label xxx absent'
; Entrée:
;       TR0-TR1: Adresse du descripteur
LD978:
        ; Erreur: 'ligne/label'
        ldx     #$01                            ; D978 A2 01
        jsr     PrintErrMsg3                    ; D97A 20 8D D5

        ; Récupère la longueur du label
        sec                                     ; D97D 38
        ldy     #$06                            ; D97E A0 06
        lda     (TR0),y                         ; D980 B1 0C
        sbc     #$07                            ; D982 E9 07
        tax                                     ; D984 AA

LD985:
        ; Boucle d'affichage du label
        iny                                     ; D985 C8
        lda     (TR0),y                         ; D986 B1 0C
        XWR0                                    ; D988 00 10
        dex                                     ; D98A CA
        bne     LD985                           ; D98B D0 F8


        ; Erreur: ' absent'
        ldx     #$06                            ; D98D A2 06
        bit     $04A2                           ; D98F 2C A2 04

        ; Force b7 de $B5 à 1
        sec                                     ; D992 38
        ror     $B5                             ; D993 66 B5
        jmp     PrintErrMsg3                    ; D995 4C 8D D5

; ----------------------------------------------------------------------------
; Début Passe Ic
Passe_Ic:
        ldx     #$0C                            ; D998 A2 0C
        jsr     PrintPasse_A                    ; D99A 20 6B DF
        ldx     L07FD                           ; D99D AE FD 07
        lda     L07FD+1                         ; D9A0 AD FE 07
LD9A3:
        stx     TR0                             ; D9A3 86 0C
        sta     TR1                             ; D9A5 85 0D
        ldy     #$01                            ; D9A7 A0 01
        lda     (TR0),y                         ; D9A9 B1 0C
        beq     LD96B                           ; D9AB F0 BE

        iny                                     ; D9AD C8
        lda     (TR0),y                         ; D9AE B1 0C
        cmp     #$07                            ; D9B0 C9 07
        beq     LD9D0                           ; D9B2 F0 1C

        cmp     #$06                            ; D9B4 C9 06
        beq     LD9C9                           ; D9B6 F0 11

        cmp     #$0C                            ; D9B8 C9 0C
        bcc     LD9F8                           ; D9BA 90 3C

        cmp     #$0E                            ; D9BC C9 0E
        bcs     LD9F8                           ; D9BE B0 38

        jsr     LCF81                           ; D9C0 20 81 CF
        jsr     LCAEE                           ; D9C3 20 EE CA
        jmp     LD9F8                           ; D9C6 4C F8 D9

; ----------------------------------------------------------------------------
LD9C9:
        iny                                     ; D9C9 C8
        lda     (TR0),y                         ; D9CA B1 0C
        cmp     #$03                            ; D9CC C9 03
        beq     LD9F8                           ; D9CE F0 28

LD9D0:
        ldy     #$06                            ; D9D0 A0 06
        lda     (TR0),y                         ; D9D2 B1 0C
        tay                                     ; D9D4 A8
        lda     (TR0),y                         ; D9D5 B1 0C
        pha                                     ; D9D7 48
        iny                                     ; D9D8 C8
        lda     (TR0),y                         ; D9D9 B1 0C
        tay                                     ; D9DB A8
        pla                                     ; D9DC 68
        jsr     LD0ED                           ; D9DD 20 ED D0
        bcs     LD9E8                           ; D9E0 B0 06

        ; Erreur: 'ligne/label xxx absent'
        jsr     LD978                           ; D9E2 20 78 D9

        jmp     LD9F8                           ; D9E5 4C F8 D9

; ----------------------------------------------------------------------------
LD9E8:
        ldy     #$06                            ; D9E8 A0 06
        lda     (TR0),y                         ; D9EA B1 0C
        tay                                     ; D9EC A8
        iny                                     ; D9ED C8
        iny                                     ; D9EE C8
        lda     ptr00BE                         ; D9EF A5 BE
        sta     (TR0),y                         ; D9F1 91 0C
        iny                                     ; D9F3 C8
        lda     ptr00BE+1                       ; D9F4 A5 BF
        sta     (TR0),y                         ; D9F6 91 0C
LD9F8:
        ldy     #$00                            ; D9F8 A0 00
        lda     (TR0),y                         ; D9FA B1 0C
        tax                                     ; D9FC AA
        iny                                     ; D9FD C8
        lda     (TR0),y                         ; D9FE B1 0C
        jmp     LD9A3                           ; DA00 4C A3 D9

; ----------------------------------------------------------------------------
LDA03:
        inx                                     ; DA03 E8
        inx                                     ; DA04 E8
        inx                                     ; DA05 E8
        stx     $C3                             ; DA06 86 C3

        ; Force le b7 à 0
        lsr     $B5                             ; DA08 46 B5

        ldy     #$00                            ; DA0A A0 00
        sty     ptr_07F9                        ; DA0C 8C F9 07
        sty     ptr_07F9+1                      ; DA0F 8C FA 07
        dey                                     ; DA12 88
        tya                                     ; DA13 98
        jsr     LD0ED                           ; DA14 20 ED D0
        clc                                     ; DA17 18
        lda     HIMEM_val                       ; DA18 AD FB 07
        sbc     ptr00BE                         ; DA1B E5 BE
        sta     ptr_07F9                        ; DA1D 8D F9 07
        sta     $07B5                           ; DA20 8D B5 07
        tax                                     ; DA23 AA
        lda     HIMEM_val+1                     ; DA24 AD FC 07
        sbc     ptr00BE+1                       ; DA27 E5 BF
        sbc     #$01                            ; DA29 E9 01
        sta     ptr_07F9+1                      ; DA2B 8D FA 07
        sta     $07B6                           ; DA2E 8D B6 07
        jsr     Passe_Ia                        ; DA31 20 A0 D8

        lda     #$00                            ; DA34 A9 00
        sta     SP                              ; DA36 8D 00 07
        lda     #$FD                            ; DA39 A9 FD
        ldy     #$05                            ; DA3B A0 05
        sta     ptr00C0                         ; DA3D 85 C0
        sty     ptr00C0+1                       ; DA3F 84 C1
        lda     SCEFIN                          ; DA41 A5 5E
        ldy     SCEFIN+1                        ; DA43 A4 5F
        sta     ptr00BE                         ; DA45 85 BE
        sty     ptr00BE+1                       ; DA47 84 BF
        lda     #$FF                            ; DA49 A9 FF
        sta     $99                             ; DA4B 85 99
        sta     $9A                             ; DA4D 85 9A
        jsr     LDC07                           ; DA4F 20 07 DC
        jsr     LM_RTS                          ; DA52 20 B8 DA
        lda     ptr00BE                         ; DA55 A5 BE
        ldy     ptr00BE+1                       ; DA57 A4 BF
        sta     $07F5                           ; DA59 8D F5 07
        sty     $07F6                           ; DA5C 8C F6 07
        bit     fFlags                          ; DA5F 24 8C
        bvs     LDAAE                           ; DA61 70 4B

; Début Passe II (assemblage) - Label non nécessaire, juste pour avoir un commentaire
Passe_II:
        ldx     #$0D                            ; DA63 A2 0D
        jsr     PrintPasse_A                    ; DA65 20 6B DF

        ; CLEAR
        jsr     LFDA5                           ; DA68 20 A5 FD

        lda     ptr_07F9                        ; DA6B AD F9 07
        ldy     ptr_07F9+1                      ; DA6E AC FA 07
        sta     ptr00BE                         ; DA71 85 BE
        sty     ptr00BE+1                       ; DA73 84 BF
        lda     #$00                            ; DA75 A9 00
        ldy     #$08                            ; DA77 A0 08
        sty     ptr00C0+1                       ; DA79 84 C1
LDA7B:
        sta     ptr00C0                         ; DA7B 85 C0
        ldy     #$00                            ; DA7D A0 00
        lda     (ptr00C0),y                     ; DA7F B1 C0
        beq     LDAAE                           ; DA81 F0 2B

        sta     $C3                             ; DA83 85 C3
        iny                                     ; DA85 C8
        lda     (ptr00C0),y                     ; DA86 B1 C0
        sta     $99                             ; DA88 85 99
        iny                                     ; DA8A C8
        lda     (ptr00C0),y                     ; DA8B B1 C0
        sta     $9A                             ; DA8D 85 9A
        bit     fTalk                           ; DA8F 24 8D
        bmi     LDAA0                           ; DA91 30 0D

        lda     #$0D                            ; DA93 A9 0D
        XWR0                                    ; DA95 00 10
        lda     $99                             ; DA97 A5 99
        ldy     $9A                             ; DA99 A4 9A
        jsr     LD559                           ; DA9B 20 59 D5
        XWSTR0                                  ; DA9E 00 14
LDAA0:
        jsr     LDC07                           ; DAA0 20 07 DC
        clc                                     ; DAA3 18
        lda     $C3                             ; DAA4 A5 C3
        adc     ptr00C0                         ; DAA6 65 C0
        bcc     LDA7B                           ; DAA8 90 D1
        inc     ptr00C0+1                       ; DAAA E6 C1
        bcs     LDA7B                           ; DAAC B0 CD

LDAAE:
        ; b7=1? ->
        bit     $B5                             ; DAAE 24 B5
        bmi     LDABD                           ; DAB0 30 0B

        ; Force TRACE SET
        lda     fFlags                          ; DAB2 A5 8C
        ora     #$40                            ; DAB4 09 40
        sta     fFlags                          ; DAB6 85 8C

; Ajoute RTS au programme LM
LM_RTS:
        lda     #$60                            ; DAB8 A9 60
        jmp     LM_Put_A                        ; DABA 4C 5C DF

; ----------------------------------------------------------------------------
; Place un RTS au début du programme compilé
LDABD:
        lda     ptr_07F9                        ; DABD AD F9 07
        ldy     ptr_07F9+1                      ; DAC0 AC FA 07
        sta     RES                             ; DAC3 85 00
        sty     RES+1                           ; DAC5 84 01
        ldy     #$00                            ; DAC7 A0 00
        lda     #$60                            ; DAC9 A9 60
        sta     (RES),y                         ; DACB 91 00
LDACD:
        rts                                     ; DACD 60

; ----------------------------------------------------------------------------
LDACE:
        ldx     $C4                             ; DACE A6 C4
        cpx     $C3                             ; DAD0 E4 C3
        bcs     LDACD                           ; DAD2 B0 F9

        pha                                     ; DAD4 48
        lda     #$20                            ; DAD5 A9 20
        jmp     LDCD4                           ; DAD7 4C D4 DC

; ----------------------------------------------------------------------------
LDADA:
        pla                                     ; DADA 68
        beq     LDACE                           ; DADB F0 F1

        pla                                     ; DADD 68
        sta     $92                             ; DADE 85 92
        pla                                     ; DAE0 68
        sta     $93                             ; DAE1 85 93
        jsr     LDF23                           ; DAE3 20 23 DF
        ldy     #$04                            ; DAE6 A0 04
        lda     ($92),y                         ; DAE8 B1 92
        cmp     #$08                            ; DAEA C9 08
        bcc     LDADA                           ; DAEC 90 EC

        cmp     #$0D                            ; DAEE C9 0D
        bcs     LDB25                           ; DAF0 B0 33

        pha                                     ; DAF2 48
        cmp     #$0B                            ; DAF3 C9 0B
        bne     LDB01                           ; DAF5 D0 0A

        lda     $B7                             ; DAF7 A5 B7
        jsr     Push                            ; DAF9 20 7B DF
        lda     $B6                             ; DAFC A5 B6
        jsr     Push                            ; DAFE 20 7B DF
LDB01:
        lda     ptr00BE+1                       ; DB01 A5 BF
        jsr     Push                            ; DB03 20 7B DF
        lda     ptr00BE                         ; DB06 A5 BE
        jsr     Push                            ; DB08 20 7B DF
        pla                                     ; DB0B 68
        cmp     #$08                            ; DB0C C9 08
        bne     LDB1F                           ; DB0E D0 0F

        ldy     #$05                            ; DB10 A0 05
        lda     (ptr00C0),y                     ; DB12 B1 C0
        jsr     Push                            ; DB14 20 7B DF
        iny                                     ; DB17 C8
        lda     (ptr00C0),y                     ; DB18 B1 C0
        jsr     Push                            ; DB1A 20 7B DF
        lda     #$08                            ; DB1D A9 08
LDB1F:
        jsr     Push                            ; DB1F 20 7B DF
        jmp     LDADA                           ; DB22 4C DA DA

; ----------------------------------------------------------------------------
LDB25:
        cmp     #$12                            ; DB25 C9 12
        bcs     LDADA                           ; DB27 B0 B1

        cmp     #$0E                            ; DB29 C9 0E
        bne     LDB4E                           ; DB2B D0 21

        lda     #$09                            ; DB2D A9 09
        jsr     EQPop                           ; DB2F 20 90 DF
        bcs     LDB46                           ; DB32 B0 12

LDB34:
        jsr     Pop                             ; DB34 20 85 DF
        jsr     LM_Put_A                        ; DB37 20 5C DF
        jsr     Pop                             ; DB3A 20 85 DF
        jsr     LM_Put_A                        ; DB3D 20 5C DF
        jmp     LDADA                           ; DB40 4C DA DA

; ----------------------------------------------------------------------------
; Affiche un espace suivi de l'erreur 'UNCOUNT sans COUNT' et d'un CR/LF
LDB43:
        ldx     #$02                            ; DB43 A2 02
        .byte   $2C                             ; DB45 2C
; Affiche un espace suivi de l'erreur 'UNTIL sans REPEAT' et d'un CR/LF
LDB46:
        ldx     #$05                            ; DB46 A2 05
        jsr     LDF72                           ; DB48 20 72 DF

        jmp     LDADA                           ; DB4B 4C DA DA

; ----------------------------------------------------------------------------
LDB4E:
        cmp     #$0F                            ; DB4E C9 0F
        bne     LDB8E                           ; DB50 D0 3C

        lda     #$0A                            ; DB52 A9 0A
        jsr     EQPop                           ; DB54 20 90 DF
        bcs     LDB43                           ; DB57 B0 EA

        jsr     Pop                             ; DB59 20 85 DF
        pha                                     ; DB5C 48
        jsr     LM_Put_A                        ; DB5D 20 5C DF
        jsr     Pop                             ; DB60 20 85 DF
        jsr     LM_Put_A                        ; DB63 20 5C DF
        tax                                     ; DB66 AA
        sec                                     ; DB67 38
        pla                                     ; DB68 68
        sbc     #$02                            ; DB69 E9 02
        bcs     LDB6E                           ; DB6B B0 01

        dex                                     ; DB6D CA
LDB6E:
        sta     RES                             ; DB6E 85 00
        dec     ptr00BE+1                       ; DB70 C6 BF
        ldy     #$F4                            ; DB72 A0 F4
        sta     (ptr00BE),y                     ; DB74 91 BE
        iny                                     ; DB76 C8
        txa                                     ; DB77 8A
        sta     (ptr00BE),y                     ; DB78 91 BE
        clc                                     ; DB7A 18
        lda     RES                             ; DB7B A5 00
        adc     #$01                            ; DB7D 69 01
        ldy     #$F9                            ; DB7F A0 F9
        sta     (ptr00BE),y                     ; DB81 91 BE
        txa                                     ; DB83 8A
        adc     #$00                            ; DB84 69 00
        iny                                     ; DB86 C8
        sta     (ptr00BE),y                     ; DB87 91 BE
        inc     ptr00BE+1                       ; DB89 E6 BF
        jmp     LDADA                           ; DB8B 4C DA DA

; ----------------------------------------------------------------------------
LDB8E:
        cmp     #$10                            ; DB8E C9 10
        bne     LDBBF                           ; DB90 D0 2D

        lda     #$0B                            ; DB92 A9 0B
        jsr     EQPop                           ; DB94 20 90 DF
        bcs     LDBFC                           ; DB97 B0 63

        jsr     Pop                             ; DB99 20 85 DF
        sta     RES                             ; DB9C 85 00
        jsr     Pop                             ; DB9E 20 85 DF
        sta     RES+1                           ; DBA1 85 01
        jsr     Pop                             ; DBA3 20 85 DF
        jsr     LM_Put_A                        ; DBA6 20 5C DF
        jsr     Pop                             ; DBA9 20 85 DF
        jsr     LM_Put_A                        ; DBAC 20 5C DF
        dec     RES+1                           ; DBAF C6 01
        ldy     #$FE                            ; DBB1 A0 FE
        lda     ptr00BE                         ; DBB3 A5 BE
        sta     (RES),y                         ; DBB5 91 00
        iny                                     ; DBB7 C8
        lda     ptr00BE+1                       ; DBB8 A5 BF
        sta     (RES),y                         ; DBBA 91 00
        jmp     LDADA                           ; DBBC 4C DA DA

; ----------------------------------------------------------------------------
LDBBF:
        lda     #$08                            ; DBBF A9 08
        jsr     EQPop                           ; DBC1 20 90 DF
        bcs     LDBF9                           ; DBC4 B0 33

        jsr     Pop                             ; DBC6 20 85 DF
        sta     $97                             ; DBC9 85 97
        jsr     Pop                             ; DBCB 20 85 DF
        sta     $96                             ; DBCE 85 96
        ldy     $C4                             ; DBD0 A4 C4
        cpy     #$07                            ; DBD2 C0 07
        bne     LDBE4                           ; DBD4 D0 0E

        dey                                     ; DBD6 88
        lda     (ptr00C0),y                     ; DBD7 B1 C0
        cmp     $97                             ; DBD9 C5 97
        bne     LDBF9                           ; DBDB D0 1C

        dey                                     ; DBDD 88
        lda     (ptr00C0),y                     ; DBDE B1 C0
        cmp     $96                             ; DBE0 C5 96
        bne     LDBF9                           ; DBE2 D0 15

LDBE4:
        ; Cherche le type du token contenu en $96-97
        jsr     LCA8A                           ; DBE4 20 8A CA

        lda     $92                             ; DBE7 A5 92
        jsr     LM_Put_A                        ; DBE9 20 5C DF
        lda     $93                             ; DBEC A5 93
        jsr     LM_Put_A                        ; DBEE 20 5C DF
        lda     #$4C                            ; DBF1 A9 4C
        jsr     LM_Put_A                        ; DBF3 20 5C DF
        jmp     LDB34                           ; DBF6 4C 34 DB

; ----------------------------------------------------------------------------
; Affiche un espace suivi de l'erreur 'NEXT sans FOR' et d'un CR/LF
LDBF9:
        ldx     #$03                            ; DBF9 A2 03
        .byte   $2C                             ; DBFB 2C
; Affiche un espace suivi de l'erreur 'WEND sans WHILE' et d'un CR/LF
LDBFC:
        ldx     #$0E                            ; DBFC A2 0E
        jsr     LDF72                           ; DBFE 20 72 DF

        jmp     LDADA                           ; DC01 4C DA DA

; ----------------------------------------------------------------------------
LDC04:
        jmp     LDADA                           ; DC04 4C DA DA

; ----------------------------------------------------------------------------
LDC07:
        ldy     #$03                            ; DC07 A0 03
        sty     $C4                             ; DC09 84 C4
        clc                                     ; DC0B 18
        lda     ptr00BE                         ; DC0C A5 BE
        sta     $B6                             ; DC0E 85 B6
        adc     (ptr00C0),y                     ; DC10 71 C0
        sta     $B1                             ; DC12 85 B1
        lda     ptr00BE+1                       ; DC14 A5 BF
        sta     $B7                             ; DC16 85 B7
        adc     #$00                            ; DC18 69 00
        sta     $B2                             ; DC1A 85 B2
        lsr     $B0                             ; DC1C 46 B0
        ldy     #$04                            ; DC1E A0 04
        lda     (ptr00C0),y                     ; DC20 B1 C0
        cmp     #$C0                            ; DC22 C9 C0
        bne     LDC2E                           ; DC24 D0 08

        iny                                     ; DC26 C8
        lda     (ptr00C0),y                     ; DC27 B1 C0
        cmp     #$CC                            ; DC29 C9 CC
        bne     LDC2E                           ; DC2B D0 01

        rts                                     ; DC2D 60

; ----------------------------------------------------------------------------
LDC2E:
        lda     #$00                            ; DC2E A9 00
        pha                                     ; DC30 48
        ldy     #$04                            ; DC31 A0 04
        lda     (ptr00C0),y                     ; DC33 B1 C0

        ; Test de ACC -> Z=0 si ACC € [$00, $09, $0F, $10, $05, $A0, $A1, $A3]
        jsr     LDF9A                           ; DC35 20 9A DF
        beq     LDC48                           ; DC38 F0 0E

        ; Compile l'appel à TraceLine
        ldx     #$07                            ; DC3A A2 07
        ldy     #$D5                            ; DC3C A0 D5
        jsr     LM_JSR_XY                       ; DC3E 20 52 DF

        ldx     $99                             ; DC41 A6 99
        ldy     $9A                             ; DC43 A4 9A
        jsr     LDF57                           ; DC45 20 57 DF

LDC48:
        inc     $C4                             ; DC48 E6 C4
        lda     $C4                             ; DC4A A5 C4
        cmp     $C3                             ; DC4C C5 C3
        bcs     LDC04                           ; DC4E B0 B4

        ldy     $C4                             ; DC50 A4 C4
        lda     (ptr00C0),y                     ; DC52 B1 C0
        cmp     #$20                            ; DC54 C9 20
        beq     LDC04                           ; DC56 F0 AC

        tax                                     ; DC58 AA
        bmi     LDC60                           ; DC59 30 05

        bcs     LDC63                           ; DC5B B0 06

        jmp     LDDB6                           ; DC5D 4C B6 DD

; ----------------------------------------------------------------------------
LDC60:
        jmp     LDCF0                           ; DC60 4C F0 DC

; ----------------------------------------------------------------------------
LDC63:
        cmp     #$50                            ; DC63 C9 50
        bcs     LDC60                           ; DC65 B0 F9

        cmp     #$2D                            ; DC67 C9 2D
        bne     LDC6F                           ; DC69 D0 04

        pha                                     ; DC6B 48
LDC6C:
        jmp     LDC48                           ; DC6C 4C 48 DC

; ----------------------------------------------------------------------------
LDC6F:
        cmp     #$2E                            ; DC6F C9 2E
        bne     LDC97                           ; DC71 D0 24

LDC73:
        pla                                     ; DC73 68
        cmp     #$2D                            ; DC74 C9 2D
        beq     LDC84                           ; DC76 F0 0C

        pla                                     ; DC78 68
        sta     $92                             ; DC79 85 92
        pla                                     ; DC7B 68
        sta     $93                             ; DC7C 85 93
        jsr     LDF23                           ; DC7E 20 23 DF
        jmp     LDC73                           ; DC81 4C 73 DC

; ----------------------------------------------------------------------------
LDC84:
        pla                                     ; DC84 68
        pha                                     ; DC85 48
        cmp     #$02                            ; DC86 C9 02
        bne     LDC6C                           ; DC88 D0 E2

        pla                                     ; DC8A 68
        pla                                     ; DC8B 68
        sta     $92                             ; DC8C 85 92
        pla                                     ; DC8E 68
        sta     $93                             ; DC8F 85 93
        jsr     LDF23                           ; DC91 20 23 DF
        jmp     LDC48                           ; DC94 4C 48 DC

; ----------------------------------------------------------------------------
LDC97:
        cmp     #$3D                            ; DC97 C9 3D
        bne     LDCBA                           ; DC99 D0 1F

        ldy     $C4                             ; DC9B A4 C4
        iny                                     ; DC9D C8
        lda     (ptr00C0),y                     ; DC9E B1 C0

        ldx     #$88                            ; DCA0 A2 88
        ldy     #$D0                            ; DCA2 A0 D0
        cmp     #$2C                            ; DCA4 C9 2C
        beq     LDCB2                           ; DCA6 F0 0A

        cmp     #$2F                            ; DCA8 C9 2F
        beq     LDCB2                           ; DCAA F0 06

        dec     $C4                             ; DCAC C6 C4

        ; Compile JSR $D086
        ldx     #$86                            ; DCAE A2 86
        ldy     #$D0                            ; DCB0 A0 D0
LDCB2:
        jsr     LM_JSR_XY                       ; DCB2 20 52 DF

        inc     $C4                             ; DCB5 E6 C4
        jmp     LDC48                           ; DCB7 4C 48 DC

; ----------------------------------------------------------------------------
LDCBA:
        sta     $8F                             ; DCBA 85 8F
LDCBC:
        pla                                     ; DCBC 68
        cmp     #$01                            ; DCBD C9 01
        beq     LDCD1                           ; DCBF F0 10

        cmp     #$2D                            ; DCC1 C9 2D
        beq     LDCD1                           ; DCC3 F0 0C

        pla                                     ; DCC5 68
        sta     $92                             ; DCC6 85 92
        pla                                     ; DCC8 68
        sta     $93                             ; DCC9 85 93
        jsr     LDF23                           ; DCCB 20 23 DF
        jmp     LDCBC                           ; DCCE 4C BC DC

; ----------------------------------------------------------------------------
LDCD1:
        ; Offset dans la table LE411 := ($BF)-#$20
        pha                                     ; DCD1 48
        lda     $8F                             ; DCD2 A5 8F

LDCD4:
        ; Offset dans la table LE411 := ACC-#$20
        sec                                     ; DCD4 38
        sbc     #$20                            ; DCD5 E9 20

        ; Copie des octets de la table LE411
        ; vers le programme compilé
        tax                                     ; DCD7 AA
        ldy     LE490,x                         ; DCD8 BC 90 E4
LDCDB:
        tya                                     ; DCDB 98
        cmp     LE490+1,x                       ; DCDC DD 91 E4
        beq     LDCEA                           ; DCDF F0 09

        lda     LE411,y                         ; DCE1 B9 11 E4
        jsr     LM_Put_A                        ; DCE4 20 5C DF
        iny                                     ; DCE7 C8
        bne     LDCDB                           ; DCE8 D0 F1

LDCEA:
        jmp     LDC48                           ; DCEA 4C 48 DC

; ----------------------------------------------------------------------------
LDCED:
        jmp     LDDB6                           ; DCED 4C B6 DD

; ----------------------------------------------------------------------------
LDCF0:
        cmp     #$C0                            ; DCF0 C9 C0
        bcs     LDCED                           ; DCF2 B0 F9

        cmp     #$B0                            ; DCF4 C9 B0
        bcc     LDCED                           ; DCF6 90 F5

        beq     LDD01                           ; DCF8 F0 07

        cmp     #$B1                            ; DCFA C9 B1
        bne     LDD09                           ; DCFC D0 0B

        ; Code 'CLC'
        lda     #$18                            ; DCFE A9 18
        .byte   $2C                             ; DD00 2C
LDD01:
        ; Code 'SEC'
        lda     #$38                            ; DD01 A9 38
        jsr     LM_Put_A                        ; DD03 20 5C DF

        jmp     LDC48                           ; DD06 4C 48 DC

; ----------------------------------------------------------------------------
LDD09:
        cmp     #$B5                            ; DD09 C9 B5
        bne     LDD28                           ; DD0B D0 1B

LDD0D:
        pla                                     ; DD0D 68
        beq     LDD1C                           ; DD0E F0 0C

        pla                                     ; DD10 68
        sta     $92                             ; DD11 85 92
        pla                                     ; DD13 68
        sta     $93                             ; DD14 85 93
        jsr     LDF23                           ; DD16 20 23 DF
        jmp     LDD0D                           ; DD19 4C 0D DD

; ----------------------------------------------------------------------------
LDD1C:
        pha                                     ; DD1C 48
        lda     ptr00BE                         ; DD1D A5 BE
        ldy     ptr00BE+1                       ; DD1F A4 BF
        sta     $B3                             ; DD21 85 B3
        sty     $B4                             ; DD23 84 B4
        jmp     LDD51                           ; DD25 4C 51 DD

; ----------------------------------------------------------------------------
LDD28:
        cmp     #$B4                            ; DD28 C9 B4
        bne     LDD96                           ; DD2A D0 6A

LDD2C:
        pla                                     ; DD2C 68
        beq     LDD3B                           ; DD2D F0 0C

        pla                                     ; DD2F 68
        sta     $92                             ; DD30 85 92
        pla                                     ; DD32 68
        sta     $93                             ; DD33 85 93
        jsr     LDF23                           ; DD35 20 23 DF
        jmp     LDD2C                           ; DD38 4C 2C DD

; ----------------------------------------------------------------------------
LDD3B:
        pha                                     ; DD3B 48
        ldy     #$00                            ; DD3C A0 00
        clc                                     ; DD3E 18
        lda     ptr00BE                         ; DD3F A5 BE
        adc     #$03                            ; DD41 69 03
        sta     ($B3),y                         ; DD43 91 B3
        iny                                     ; DD45 C8
        lda     ptr00BE+1                       ; DD46 A5 BF
        adc     #$00                            ; DD48 69 00
        sta     ($B3),y                         ; DD4A 91 B3
        lda     #$4C                            ; DD4C A9 4C
        jsr     LM_Put_A                        ; DD4E 20 5C DF
LDD51:
        lda     $B1                             ; DD51 A5 B1
        jsr     LM_Put_A                        ; DD53 20 5C DF
        lda     $B2                             ; DD56 A5 B2
        jsr     LM_Put_A                        ; DD58 20 5C DF
        ldy     $C4                             ; DD5B A4 C4
        iny                                     ; DD5D C8
        lda     (ptr00C0),y                     ; DD5E B1 C0
        cmp     #$D0                            ; DD60 C9 D0
        bcc     LDD8C                           ; DD62 90 28

        ; Cherche le type du token contenu en $96-97
        sta     $96                             ; DD64 85 96
        iny                                     ; DD66 C8
        lda     (ptr00C0),y                     ; DD67 B1 C0
        sta     $97                             ; DD69 85 97
        jsr     LCA8A                           ; DD6B 20 8A CA

        cmp     #$06                            ; DD6E C9 06
        beq     LDD79                           ; DD70 F0 07

        cmp     #$07                            ; DD72 C9 07
        beq     LDD84                           ; DD74 F0 0E

LDD76:
        jmp     LDC48                           ; DD76 4C 48 DC

; ----------------------------------------------------------------------------
LDD79:
        lda     #$EA                            ; DD79 A9 EA
        jsr     LM_Put_A                        ; DD7B 20 5C DF
        jsr     LM_Put_A                        ; DD7E 20 5C DF
        jsr     LM_Put_A                        ; DD81 20 5C DF
LDD84:
        lda     #$4C                            ; DD84 A9 4C
        jsr     LM_Put_A                        ; DD86 20 5C DF
        jmp     LDDF6                           ; DD89 4C F6 DD

; ----------------------------------------------------------------------------
LDD8C:
        ldx     #$1E                            ; DD8C A2 1E
        ldy     #$D5                            ; DD8E A0 D5
        jsr     LM_JSR_XY                       ; DD90 20 52 DF
        jmp     LDC48                           ; DD93 4C 48 DC

; ----------------------------------------------------------------------------
LDD96:
        cmp     #$B3                            ; DD96 C9 B3
        bne     LDD76                           ; DD98 D0 DC

LDD9A:
        pla                                     ; DD9A 68
        cmp     #$01                            ; DD9B C9 01
        beq     LDDAB                           ; DD9D F0 0C

        pla                                     ; DD9F 68
        sta     $92                             ; DDA0 85 92
        pla                                     ; DDA2 68
        sta     $93                             ; DDA3 85 93
        jsr     LDF23                           ; DDA5 20 23 DF
        jmp     LDD9A                           ; DDA8 4C 9A DD

; ----------------------------------------------------------------------------
LDDAB:
        pha                                     ; DDAB 48
        ; Compile 'JSR $E048'
        ldx     #$48                            ; DDAC A2 48
        ldy     #$E0                            ; DDAE A0 E0
        jsr     LM_JSR_XY                       ; DDB0 20 52 DF

        jmp     LDC48                           ; DDB3 4C 48 DC

; ----------------------------------------------------------------------------
LDDB6:
        sta     $96                             ; DDB6 85 96
        cmp     #$C0                            ; DDB8 C9 C0
        bcc     LDDC2                           ; DDBA 90 06

        iny                                     ; DDBC C8
        inc     $C4                             ; DDBD E6 C4
        lda     (ptr00C0),y                     ; DDBF B1 C0
        .byte   $2C                             ; DDC1 2C

LDDC2:
        lda     #$00                            ; DDC2 A9 00

        sta     $97                             ; DDC4 85 97
        ; Cherche le type du token contenu en $96-97
        jsr     LCA8A                           ; DDC6 20 8A CA

        cmp     #$01                            ; DDC9 C9 01
        bne     LDE20                           ; DDCB D0 53

        tax                                     ; DDCD AA
        lda     $96                             ; DDCE A5 96
        beq     LDE19                           ; DDD0 F0 47

        cmp     #$A1                            ; DDD2 C9 A1
        beq     LDDE4                           ; DDD4 F0 0E

        cmp     #$A2                            ; DDD6 C9 A2
        beq     LDDE4                           ; DDD8 F0 0A

        cmp     #$AC                            ; DDDA C9 AC
        beq     LDDE4                           ; DDDC F0 06

        jmp     LDF18                           ; DDDE 4C 18 DF

; ----------------------------------------------------------------------------
        jmp     LDF17                           ; DDE1 4C 17 DF

; ----------------------------------------------------------------------------
LDDE4:
        jsr     LDF23                           ; DDE4 20 23 DF
        ldy     $C4                             ; DDE7 A4 C4
        iny                                     ; DDE9 C8
        lda     (ptr00C0),y                     ; DDEA B1 C0
        sta     $96                             ; DDEC 85 96
        iny                                     ; DDEE C8
        lda     (ptr00C0),y                     ; DDEF B1 C0
        sta     $97                             ; DDF1 85 97
        ; Cherche le type du token contenu en $96-97
        jsr     LCA8A                           ; DDF3 20 8A CA

LDDF6:
        ldy     #$03                            ; DDF6 A0 03
        lda     ($92),y                         ; DDF8 B1 92
        beq     LDE07                           ; DDFA F0 0B

        lda     $92                             ; DDFC A5 92
        ldy     $93                             ; DDFE A4 93
        sta     TR0                             ; DE00 85 0C
        sty     TR1                             ; DE02 84 0D
        ; Erreur: 'ligne/label xxx absent'
        jsr     LD978                           ; DE04 20 78 D9

LDE07:
        ldy     #$06                            ; DE07 A0 06
        lda     ($92),y                         ; DE09 B1 92
        tay                                     ; DE0B A8
        iny                                     ; DE0C C8
        iny                                     ; DE0D C8
        lda     ($92),y                         ; DE0E B1 92
        jsr     LM_Put_A                        ; DE10 20 5C DF
        iny                                     ; DE13 C8
        lda     ($92),y                         ; DE14 B1 92
        jsr     LM_Put_A                        ; DE16 20 5C DF
LDE19:
        inc     $C4                             ; DE19 E6 C4
        inc     $C4                             ; DE1B E6 C4
        jmp     LDC48                           ; DE1D 4C 48 DC

; ----------------------------------------------------------------------------
LDE20:
        cmp     #$06                            ; DE20 C9 06
        bne     LDE61                           ; DE22 D0 3D

        cpx     #$03                            ; DE24 E0 03
        bne     LDE35                           ; DE26 D0 0D

        jsr     LM_JSR_D368_Ptr92               ; DE28 20 42 DF

        ; Compile JSR $F542
        ldx     #$42                            ; DE2B A2 42
        ldy     #$F5                            ; DE2D A0 F5
        jsr     LM_JSR_XY                       ; DE2F 20 52 DF

        jmp     LDC48                           ; DE32 4C 48 DC

; ----------------------------------------------------------------------------
LDE35:
        ldx     #$CB                            ; DE35 A2 CB
        ldy     #$E8                            ; DE37 A0 E8
        jsr     LM_JSR_XY                       ; DE39 20 52 DF
        lda     #$20                            ; DE3C A9 20
        jsr     LM_Put_A                        ; DE3E 20 5C DF
        ldy     #$06                            ; DE41 A0 06
        lda     ($92),y                         ; DE43 B1 92
        tay                                     ; DE45 A8
        iny                                     ; DE46 C8
        iny                                     ; DE47 C8
        lda     ($92),y                         ; DE48 B1 92
        jsr     LM_Put_A                        ; DE4A 20 5C DF
        iny                                     ; DE4D C8
        lda     ($92),y                         ; DE4E B1 92
        jsr     LM_Put_A                        ; DE50 20 5C DF
        lda     #$EA                            ; DE53 A9 EA
        jsr     LM_Put_A                        ; DE55 20 5C DF
        jsr     LM_Put_A                        ; DE58 20 5C DF

LDE5B:
        jmp     LDC48                           ; DE5B 4C 48 DC

; ----------------------------------------------------------------------------
LDE5E:
        jmp     LDF06                           ; DE5E 4C 06 DF

; ----------------------------------------------------------------------------
LDE61:
        cmp     #$0C                            ; DE61 C9 0C
        beq     LDE9A                           ; DE63 F0 35

        cmp     #$0D                            ; DE65 C9 0D
        beq     LDE9A                           ; DE67 F0 31

        cmp     #$10                            ; DE69 C9 10
        bcs     LDE9A                           ; DE6B B0 2D

        cmp     #$07                            ; DE6D C9 07
        beq     LDE9A                           ; DE6F F0 29

        cmp     #$09                            ; DE71 C9 09
        beq     LDE79                           ; DE73 F0 04

        cmp     #$08                            ; DE75 C9 08
        bne     LDE5E                           ; DE77 D0 E5

LDE79:
        ldy     $C4                             ; DE79 A4 C4
        dey                                     ; DE7B 88
        dey                                     ; DE7C 88
        lda     (ptr00C0),y                     ; DE7D B1 C0
        cmp     #$0D                            ; DE7F C9 0D
        beq     LDE5B                           ; DE81 F0 D8

        ldy     $C4                             ; DE83 A4 C4
        iny                                     ; DE85 C8
        lda     (ptr00C0),y                     ; DE86 B1 C0
        cmp     #$2F                            ; DE88 C9 2F
        beq     LDE90                           ; DE8A F0 04

        cmp     #$2C                            ; DE8C C9 2C
        bne     LDE9A                           ; DE8E D0 0A

LDE90:
        ; Compile JSR $D268
        ldx     #$68                            ; DE90 A2 68
        ldy     #$D2                            ; DE92 A0 D2
        jsr     LM_JSR_XY_Ptr92                 ; DE94 20 46 DF
        jmp     LDC48                           ; DE97 4C 48 DC

; ----------------------------------------------------------------------------
LDE9A:
        clc                                     ; DE9A 18
LDE9B:
        ror     $91                             ; DE9B 66 91
LDE9D:
        pla                                     ; DE9D 68
        pha                                     ; DE9E 48
        cmp     #$50                            ; DE9F C9 50
        bcc     LDED8                           ; DEA1 90 35

        tsx                                     ; DEA3 BA
        lda     $0104,x                         ; DEA4 BD 04 01
        cmp     $0101,x                         ; DEA7 DD 01 01
        bcc     LDED8                           ; DEAA 90 2C

        lda     $92                             ; DEAC A5 92
        sta     RES                             ; DEAE 85 00
        lda     $93                             ; DEB0 A5 93
        sta     RES+1                           ; DEB2 85 01
        pla                                     ; DEB4 68
        sta     $0104,x                         ; DEB5 9D 04 01
        lda     $0105,x                         ; DEB8 BD 05 01
        sta     $92                             ; DEBB 85 92
        pla                                     ; DEBD 68
        sta     $0105,x                         ; DEBE 9D 05 01
        lda     $0106,x                         ; DEC1 BD 06 01
        sta     $93                             ; DEC4 85 93
        pla                                     ; DEC6 68
        sta     $0106,x                         ; DEC7 9D 06 01
        jsr     LDF23                           ; DECA 20 23 DF
        lda     RES                             ; DECD A5 00
        sta     $92                             ; DECF 85 92
        lda     RES+1                           ; DED1 A5 01
        sta     $93                             ; DED3 85 93
        jmp     LDE9D                           ; DED5 4C 9D DE

; ----------------------------------------------------------------------------
LDED8:
        bit     $91                             ; DED8 24 91
        bmi     LDEF8                           ; DEDA 30 1C

        ldy     #$02                            ; DEDC A0 02
        lda     ($92),y                         ; DEDE B1 92
        cmp     #$02                            ; DEE0 C9 02
        bne     LDEEA                           ; DEE2 D0 06

        jsr     LDF23                           ; DEE4 20 23 DF
        jmp     LDC48                           ; DEE7 4C 48 DC

; ----------------------------------------------------------------------------
LDEEA:
        cmp     #$0C                            ; DEEA C9 0C
        beq     LDEFC                           ; DEEC F0 0E

        cmp     #$0D                            ; DEEE C9 0D
        beq     LDEFC                           ; DEF0 F0 0A

        jsr     LM_JSR_D368_Ptr92               ; DEF2 20 42 DF
        jmp     LDC48                           ; DEF5 4C 48 DC

; ----------------------------------------------------------------------------
LDEF8:
        ldx     #$02                            ; DEF8 A2 02
        bne     LDF18                           ; DEFA D0 1C

; Compile JSR $D05F
LDEFC:
        ldx     #$5F                            ; DEFC A2 5F
        ldy     #$D0                            ; DEFE A0 D0
        jsr     LM_JSR_XY_Ptr92                 ; DF00 20 46 DF
        jmp     LDC48                           ; DF03 4C 48 DC

; ----------------------------------------------------------------------------
LDF06:
        cmp     #$02                            ; DF06 C9 02
        bne     LDF10                           ; DF08 D0 06

        cpx     #$02                            ; DF0A E0 02
        bcs     LDE9B                           ; DF0C B0 8D

        bcc     LDE9A                           ; DF0E 90 8A

LDF10:
        cmp     #$03                            ; DF10 C9 03
        beq     LDF18                           ; DF12 F0 04

        jmp     LDC48                           ; DF14 4C 48 DC

; ----------------------------------------------------------------------------
LDF17:
        tax                                     ; DF17 AA
LDF18:
        lda     $93                             ; DF18 A5 93
        pha                                     ; DF1A 48
        lda     $92                             ; DF1B A5 92
        pha                                     ; DF1D 48
        txa                                     ; DF1E 8A
        pha                                     ; DF1F 48
        jmp     LDC48                           ; DF20 4C 48 DC

; ----------------------------------------------------------------------------
LDF23:
        jsr     LCE3B                           ; DF23 20 3B CE
        tax                                     ; DF26 AA
        bpl     LDF36                           ; DF27 10 0D

        sec                                     ; DF29 38
        tya                                     ; DF2A 98
        adc     $92                             ; DF2B 65 92
        tax                                     ; DF2D AA
        lda     $93                             ; DF2E A5 93
        adc     #$00                            ; DF30 69 00
        tay                                     ; DF32 A8
        jmp     LM_JSR_XY                       ; DF33 4C 52 DF

; ----------------------------------------------------------------------------
LDF36:
        dex                                     ; DF36 CA
        bmi     LDF6A                           ; DF37 30 31

        iny                                     ; DF39 C8
        lda     ($92),y                         ; DF3A B1 92
        jsr     LM_Put_A                        ; DF3C 20 5C DF
        jmp     LDF36                           ; DF3F 4C 36 DF

; ----------------------------------------------------------------------------
; Ajoute JSR $D368 suivi des 2 octets contenus en $92-$93 au programme LM
LM_JSR_D368_Ptr92:
        ldx     #$68                            ; DF42 A2 68
        ldy     #$D3                            ; DF44 A0 D3

; Ajoute JSR XY suivi des 2 octets contenus en $92-$93 au programme LM
LM_JSR_XY_Ptr92:
        jsr     LM_JSR_XY                       ; DF46 20 52 DF
        lda     $92                             ; DF49 A5 92
        jsr     LM_Put_A                        ; DF4B 20 5C DF
        lda     $93                             ; DF4E A5 93
        bne     LM_Put_A                        ; DF50 D0 0A

; Ajoute JSR XY au programme LM (X=LSB)
LM_JSR_XY:
        lda     #$20                            ; DF52 A9 20
        jsr     LM_Put_A                        ; DF54 20 5C DF
LDF57:
        txa                                     ; DF57 8A
        jsr     LM_Put_A                        ; DF58 20 5C DF
        tya                                     ; DF5B 98

; Ajoute l'octet contenu dans le registre A au programme LM
LM_Put_A:
        stx     $8E                             ; DF5C 86 8E
        ldx     #$00                            ; DF5E A2 00
        sta     (ptr00BE,x)                     ; DF60 81 BE

        inc     ptr00BE                         ; DF62 E6 BE
        bne     LDF68                           ; DF64 D0 02
        inc     ptr00BE+1                       ; DF66 E6 BF

LDF68:
        ldx     $8E                             ; DF68 A6 8E
LDF6A:
        rts                                     ; DF6A 60

; ----------------------------------------------------------------------------
; Affiche le n° de passe en cours si TALK SET (ACC=n° de passe)
PrintPasse_A:
        bit     fTalk                           ; DF6B 24 8D
        bmi     LDF6A                           ; DF6D 30 FB

        jmp     PrintErrMsg3                    ; DF6F 4C 8D D5

; ----------------------------------------------------------------------------
; Affiche un espace suivi de l'erreur X et d'un CR/LF
LDF72:
        jsr     Print0_SPACE                    ; DF72 20 DB D5
        jsr     PrintErrMsg3                    ; DF75 20 8D D5
        XCRLF                                   ; DF78 00 25
        rts                                     ; DF7A 60

; ----------------------------------------------------------------------------
Push:
        inc     SP                              ; DF7B EE 00 07
        ldx     SP                              ; DF7E AE 00 07
        sta     Stack,x                         ; DF81 9D 01 07
        rts                                     ; DF84 60

; ----------------------------------------------------------------------------
Pop:
        ldx     SP                              ; DF85 AE 00 07
        lda     Stack,x                         ; DF88 BD 01 07
        dec     SP                              ; DF8B CE 00 07
        clc                                     ; DF8E 18
        rts                                     ; DF8F 60

; ----------------------------------------------------------------------------
; Récupère le sommet de la pile si il est egale à ACC
EQPop:
        ldx     SP                              ; DF90 AE 00 07
        cmp     Stack,x                         ; DF93 DD 01 07
        beq     Pop                             ; DF96 F0 ED

        sec                                     ; DF98 38
        rts                                     ; DF99 60

; ----------------------------------------------------------------------------
; Test de ACC -> Z=0 si ACC € [$00, $09, $0F, $10, $05, $A0, $A1, $A3]
LDF9A:
        cmp     #$00                            ; DF9A C9 00
        beq     LDFB8                           ; DF9C F0 1A

        cmp     #$09                            ; DF9E C9 09
        beq     LDFB8                           ; DFA0 F0 16

        cmp     #$0F                            ; DFA2 C9 0F
        beq     LDFB8                           ; DFA4 F0 12

        cmp     #$10                            ; DFA6 C9 10
        beq     LDFB8                           ; DFA8 F0 0E

        cmp     #$05                            ; DFAA C9 05
        beq     LDFB8                           ; DFAC F0 0A

        cmp     #$A0                            ; DFAE C9 A0
        beq     LDFB8                           ; DFB0 F0 06

        cmp     #$A1                            ; DFB2 C9 A1
        beq     LDFB8                           ; DFB4 F0 02

        cmp     #$A3                            ; DFB6 C9 A3
LDFB8:
        rts                                     ; DFB8 60


; ----------------------------------------------------------------------------
;                       LISTE DES INSTRUCTIONS
; ----------------------------------------------------------------------------
]_lfa:
        .addr   RETURN_lfa                      ; DFB9 C3 DF
; ----------------------------------------------------------------------------
]_pfa:
        .byte   $01,$00,$00,$00,$08             ; DFBB 01 00 00 00 08
; ----------------------------------------------------------------------------
]:      .byte   "]"                             ; DFC0 5D
; ----------------------------------------------------------------------------
        .byte   $8C,$00                         ; DFC1 8C 00

; ----------------------------------------------------------------------------
RETURN_lfa:
        .addr   END_lfa                         ; DFC3 DF DF
; ----------------------------------------------------------------------------
RETURN_pfa:
        .byte   $01,$00,$01,$00,$0D             ; DFC5 01 00 01 00 0D
; ----------------------------------------------------------------------------
RETURN:
        .byte   "RETURN"                        ; DFCA 52 45 54 55 52 4E
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; DFD0 80 03
; ----------------------------------------------------------------------------
        jmp     LDFD5                           ; DFD2 4C D5 DF

; ----------------------------------------------------------------------------
LDFD5:
        dec     $C2                             ; DFD5 C6 C2
        bmi     Error_RETURN                    ; DFD7 30 01
        rts                                     ; DFD9 60

; ----------------------------------------------------------------------------
; Erreur: RETURN sans GOSUB
Error_RETURN:
        ldx     #$19                            ; DFDA A2 19
        jmp     Error_X                         ; DFDC 4C 7E D1

; ----------------------------------------------------------------------------
END_lfa:
        .addr   STOP_lfa                        ; DFDF EF DF
; ----------------------------------------------------------------------------
END_pfa:
        .byte   $01,$00,$03,$00,$0A             ; DFE1 01 00 03 00 0A
; ----------------------------------------------------------------------------
END:
        .byte   "END"                           ; DFE6 45 4E 44
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; DFE9 80 03
; ----------------------------------------------------------------------------
LDFEB:
        jmp     LC068                           ; DFEB 4C 68 C0

; ----------------------------------------------------------------------------
        rts                                     ; DFEE 60

; ----------------------------------------------------------------------------
STOP_lfa:
        .addr   '_lfa                           ; DFEF FF DF
; ----------------------------------------------------------------------------
STOP_pfa:
        .byte   $01,$00,$04,$00,$0B             ; DFF1 01 00 04 00 0B
; ----------------------------------------------------------------------------
STOP:
        .byte   "STOP"                          ; DFF6 53 54 4F 50
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; DFFA 80 03
; ----------------------------------------------------------------------------
LDFFC:
        jsr     Break                           ; DFFC 20 73 D5

; ----------------------------------------------------------------------------
'_lfa:
        .addr   FOR_lfa                         ; DFFF 09 E0
; ----------------------------------------------------------------------------
'_pfa:
        .byte   $01,$00,$05,$00,$08             ; E001 01 00 05 00 08
; ----------------------------------------------------------------------------
':      .byte   "'"                             ; E006 27
; ----------------------------------------------------------------------------
        .byte   $8E,$00                         ; E007 8E 00

; ----------------------------------------------------------------------------
FOR_lfa:
        .addr   REPEAT_lfa                      ; E009 6D E0
; ----------------------------------------------------------------------------
FOR_pfa:
        .byte   $01,$01,$08,$00,$0A             ; E00B 01 01 08 00 0A
; ----------------------------------------------------------------------------
FOR:
        .byte   "FOR"                           ; E010 46 4F 52
; ----------------------------------------------------------------------------
        .byte   $26,$28,$21,$70,$31,$21,$C0,$25 ; E013 26 28 21 70 31 21 C0 25
        .byte   $83                             ; E01B 83
; ----------------------------------------------------------------------------
        jsr     Pop                             ; E01C 20 85 DF
        jsr     LE05C                           ; E01F 20 5C E0
        jsr     Push                            ; E022 20 7B DF
        lda     $BC                             ; E025 A5 BC
        jsr     Push                            ; E027 20 7B DF
        lda     $BD                             ; E02A A5 BD
        jmp     Push                            ; E02C 4C 7B DF

; ----------------------------------------------------------------------------
        beq     LE040                           ; E02F F0 0F

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$12                            ; E031 A2 12
        jsr     LC676                           ; E033 20 76 C6
        bcs     LE045                           ; E036 B0 0D

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; E038 20 74 C6
        bcs     LE045                           ; E03B B0 08

        jmp     LC909                           ; E03D 4C 09 C9

; ----------------------------------------------------------------------------
LE040:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3A                            ; E040 A9 3A
        jsr     LCA69                           ; E042 20 69 CA
LE045:
        rts                                     ; E045 60

; ----------------------------------------------------------------------------
LE046:
        sec                                     ; E046 38
        .byte   $24                             ; E047 24
        clc                                     ; E048 18

        ror     a                               ; E049 6A
        jsr     LE05C                           ; E04A 20 5C E0
        ldx     #$FF                            ; E04D A2 FF
        stx     $C3                             ; E04F 86 C3
        inx                                     ; E051 E8
        stx     FACC1M+1                        ; E052 86 62
        stx     $BA                             ; E054 86 BA
        inx                                     ; E056 E8
        stx     FACC1M                          ; E057 86 61
        jmp     Push                            ; E059 4C 7B DF

; ----------------------------------------------------------------------------
LE05C:
        pha                                     ; E05C 48

        jsr     LD23B                           ; E05D 20 3B D2
        ldy     #$FA                            ; E060 A0 FA

LE062:
        lda     LFF66,y                         ; E062 B9 66 FF
        jsr     Push                            ; E065 20 7B DF
        iny                                     ; E068 C8
        bne     LE062                           ; E069 D0 F7

        pla                                     ; E06B 68
        rts                                     ; E06C 60

; ----------------------------------------------------------------------------
REPEAT_lfa:
        .addr   COUNT_lfa                       ; E06D 7C E0
; ----------------------------------------------------------------------------
REPEAT_pfa:
        .byte   $01,$00,$09,$00,$0D             ; E06F 01 00 09 00 0D
; ----------------------------------------------------------------------------
REPEAT:
        .byte   "REPEAT"                        ; E074 52 45 50 45 41 54
; ----------------------------------------------------------------------------
        .byte   $80,$00                         ; E07A 80 00

; ----------------------------------------------------------------------------
COUNT_lfa:
        .addr   WHILE_lfa                       ; E07C BD E0
; ----------------------------------------------------------------------------
COUNT_pfa:
        .byte   $01,$00,$0A,$00,$0C             ; E07E 01 00 0A 00 0C
; ----------------------------------------------------------------------------
COUNT:
        .byte   "COUNT"                         ; E083 43 4F 55 4E 54
; ----------------------------------------------------------------------------
        .byte   $81,$05                         ; E088 81 05
; ----------------------------------------------------------------------------
        jsr     LE08F                           ; E08A 20 8F E0
        bpl     LE0B6                           ; E08D 10 27
LE08F:
        ldx     #$C3                            ; E08F A2 C3
        jsr     LD486                           ; E091 20 86 D4
        ora     FACC1M+1                        ; E094 05 62
        bne     LE09A                           ; E096 D0 02
        inc     FACC1M                          ; E098 E6 61
LE09A:
        clc                                     ; E09A 18
        pla                                     ; E09B 68
        sta     RES                             ; E09C 85 00
        adc     #$02                            ; E09E 69 02
        tay                                     ; E0A0 A8
        pla                                     ; E0A1 68
        sta     RES+1                           ; E0A2 85 01
        adc     #$00                            ; E0A4 69 00
        pha                                     ; E0A6 48
        tya                                     ; E0A7 98
        pha                                     ; E0A8 48
        ldy     #$01                            ; E0A9 A0 01
        lda     FACC1M                          ; E0AB A5 61
        eor     #$FF                            ; E0AD 49 FF
        adc     #$01                            ; E0AF 69 01
        sta     (RES),y                         ; E0B1 91 00
        iny                                     ; E0B3 C8
        lda     FACC1M+1                        ; E0B4 A5 62
LE0B6:
        eor     #$FF                            ; E0B6 49 FF
        adc     #$00                            ; E0B8 69 00
        sta     (RES),y                         ; E0BA 91 00
        rts                                     ; E0BC 60

; ----------------------------------------------------------------------------
WHILE_lfa:
        .addr   NEXT_lfa                        ; E0BD D7 E0
; ----------------------------------------------------------------------------
WHILE_pfa:
        .byte   $01,$00,$0B,$00,$0C             ; E0BF 01 00 0B 00 0C
; ----------------------------------------------------------------------------
WHILE:
        .byte   "WHILE"                         ; E0C4 57 48 49 4C 45
; ----------------------------------------------------------------------------
        .byte   $84,$07                         ; E0C9 84 07
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; E0CB A5 60
        bne     Error_NEXT                      ; E0CD D0 03
        jmp     L2710                           ; E0CF 4C 10 27

; ----------------------------------------------------------------------------
; Erreur: mauvais NEXT
Error_NEXT:
        ldx     #$17                            ; E0D2 A2 17
        jmp     Error_X                         ; E0D4 4C 7E D1

; ----------------------------------------------------------------------------
NEXT_lfa:
        .addr   UNTIL_lfa                       ; E0D7 24 E2
; ----------------------------------------------------------------------------
NEXT_pfa:
        .byte   $01,$01,$0D,$00,$0B             ; E0D9 01 01 0D 00 0B
; ----------------------------------------------------------------------------
NEXT:
        .byte   "NEXT"                          ; E0DE 4E 45 58 54
; ----------------------------------------------------------------------------
        .byte   $C1,$42,$83                     ; E0E2 C1 42 83
; ----------------------------------------------------------------------------
        pla                                     ; E0E5 68
        sta     RESB                            ; E0E6 85 02
        pla                                     ; E0E8 68
        sta     RESB+1                          ; E0E9 85 03
        ldx     SP                              ; E0EB AE 00 07
        ldy     #$02                            ; E0EE A0 02
        lda     Stack,x                         ; E0F0 BD 01 07
        sta     $BD                             ; E0F3 85 BD
        cmp     (RESB),y                        ; E0F5 D1 02
        bne     Error_NEXT                      ; E0F7 D0 D9
        dey                                     ; E0F9 88
        lda     SP,x                            ; E0FA BD 00 07
        sta     $BC                             ; E0FD 85 BC
        cmp     (RESB),y                        ; E0FF D1 02
        bne     Error_NEXT                      ; E101 D0 CF
        ldy     #$03                            ; E103 A0 03
        lda     ($BC),y                         ; E105 B1 BC
        pha                                     ; E107 48
        lda     #$40                            ; E108 A9 40
        sta     ($BC),y                         ; E10A 91 BC
        ldy     #$06                            ; E10C A0 06
        clc                                     ; E10E 18
        lda     ($BC),y                         ; E10F B1 BC
        adc     $BC                             ; E111 65 BC
        sta     $BC                             ; E113 85 BC
        bcc     LE119                           ; E115 90 02
        inc     $BD                             ; E117 E6 BD
LE119:
        pla                                     ; E119 68
        bne     LE135                           ; E11A D0 19
        sta     $BA                             ; E11C 85 BA
        ldy     #$00                            ; E11E A0 00
        lda     ($BC),y                         ; E120 B1 BC
        sta     FACC1M                          ; E122 85 61
        iny                                     ; E124 C8
        lda     ($BC),y                         ; E125 B1 BC
        sta     FACC1M+1                        ; E127 85 62
        jsr     LD23B                           ; E129 20 3B D2
        ldx     $BC                             ; E12C A6 BC
        ldy     $BD                             ; E12E A4 BD
        XA1XY                                   ; E130 00 83
        ldx     SP                              ; E132 AE 00 07
LE135:
        lda     $06FF,x                         ; E135 BD FF 06
        bpl     LE18B                           ; E138 10 51
        ldy     #$01                            ; E13A A0 01
        lda     ($BC),y                         ; E13C B1 BC
        bmi     LE18B                           ; E13E 30 4B
        dey                                     ; E140 88
        sec                                     ; E141 38
        lda     ($BC),y                         ; E142 B1 BC
        sbc     #$81                            ; E144 E9 81
        bcc     LE18B                           ; E146 90 43
        iny                                     ; E148 C8
        cmp     #$08                            ; E149 C9 08
        bcc     LE155                           ; E14B 90 08
        iny                                     ; E14D C8
        sbc     #$10                            ; E14E E9 10
        bcs     LE18B                           ; E150 B0 39
        adc     #$08                            ; E152 69 08
        clc                                     ; E154 18
LE155:
        tax                                     ; E155 AA
        lda     LE183,x                         ; E156 BD 83 E1
LE159:
        adc     ($BC),y                         ; E159 71 BC
        sta     ($BC),y                         ; E15B 91 BC
        bcc     LE164                           ; E15D 90 05
        lda     #$00                            ; E15F A9 00
        dey                                     ; E161 88
        bpl     LE159                           ; E162 10 F5
LE164:
        ldy     #$01                            ; E164 A0 01
        lda     ($BC),y                         ; E166 B1 BC
        bpl     LE19D                           ; E168 10 33
        and     #$7F                            ; E16A 29 7F
        sta     ($BC),y                         ; E16C 91 BC
        dey                                     ; E16E 88
        lda     ($BC),y                         ; E16F B1 BC
        sec                                     ; E171 38
        adc     #$00                            ; E172 69 00
        sta     ($BC),y                         ; E174 91 BC
        ldx     #$04                            ; E176 A2 04
LE178:
        iny                                     ; E178 C8
        lda     ($BC),y                         ; E179 B1 BC
        ror     a                               ; E17B 6A
        sta     ($BC),y                         ; E17C 91 BC
        dex                                     ; E17E CA
        bne     LE178                           ; E17F D0 F7
        beq     LE19D                           ; E181 F0 1A
LE183:
        .byte   $80                             ; E183 80
        rti                                     ; E184 40

; ----------------------------------------------------------------------------
        jsr     L0810                           ; E185 20 10 08
        .byte   $04                             ; E188 04
        .byte   $02                             ; E189 02
        .byte   $01                             ; E18A 01
LE18B:
        ldy     #$05                            ; E18B A0 05
LE18D:
        lda     $06FE,x                         ; E18D BD FE 06
        sta     FACC1E,y                        ; E190 99 60 00
        dex                                     ; E193 CA
        dey                                     ; E194 88
        bpl     LE18D                           ; E195 10 F6
        lda     $BC                             ; E197 A5 BC
        ldy     $BD                             ; E199 A4 BD
        XADNXT                                  ; E19B 00 85
LE19D:
        ldx     SP                              ; E19D AE 00 07
        ldy     #$00                            ; E1A0 A0 00
        lda     ($BC),y                         ; E1A2 B1 BC
        beq     LE1DF                           ; E1A4 F0 39
        pha                                     ; E1A6 48
        iny                                     ; E1A7 C8
        lda     ($BC),y                         ; E1A8 B1 BC
        eor     $06F8,x                         ; E1AA 5D F8 06
        bmi     LE1E5                           ; E1AD 30 36
        pla                                     ; E1AF 68
        cmp     $06F3,x                         ; E1B0 DD F3 06
        bne     LE1D6                           ; E1B3 D0 21
        lda     ($BC),y                         ; E1B5 B1 BC
        ora     #$80                            ; E1B7 09 80
        cmp     $06F4,x                         ; E1B9 DD F4 06
        bne     LE1D6                           ; E1BC D0 18
        iny                                     ; E1BE C8
        lda     ($BC),y                         ; E1BF B1 BC
        cmp     $06F5,x                         ; E1C1 DD F5 06
        bne     LE1D6                           ; E1C4 D0 10
        iny                                     ; E1C6 C8
        lda     ($BC),y                         ; E1C7 B1 BC
        cmp     $06F6,x                         ; E1C9 DD F6 06
        bne     LE1D6                           ; E1CC D0 08
        iny                                     ; E1CE C8
        lda     ($BC),y                         ; E1CF B1 BC
        cmp     $06F7,x                         ; E1D1 DD F7 06
        beq     LE1F1                           ; E1D4 F0 1B
LE1D6:
        lda     $06F8,x                         ; E1D6 BD F8 06
        bcc     LE1E9                           ; E1D9 90 0E
        eor     #$FF                            ; E1DB 49 FF
        bcs     LE1E9                           ; E1DD B0 0A
LE1DF:
        lda     $06F3,x                         ; E1DF BD F3 06
        beq     LE1F3                           ; E1E2 F0 0F
        .byte   $24                             ; E1E4 24
LE1E5:
        pla                                     ; E1E5 68
        lda     $06F8,x                         ; E1E6 BD F8 06
LE1E9:
        asl     a                               ; E1E9 0A
        lda     #$FF                            ; E1EA A9 FF
        bcs     LE1F3                           ; E1EC B0 05
        lda     #$01                            ; E1EE A9 01
        .byte   $2C                             ; E1F0 2C
LE1F1:
        lda     #$00                            ; E1F1 A9 00
LE1F3:
        ldy     $06FE,x                         ; E1F3 BC FE 06
        bpl     LE1FD                           ; E1F6 10 05
        eor     #$FF                            ; E1F8 49 FF
        clc                                     ; E1FA 18
        adc     #$01                            ; E1FB 69 01
LE1FD:
        tax                                     ; E1FD AA
        bpl     LE20C                           ; E1FE 10 0C
        sec                                     ; E200 38
        lda     SP                              ; E201 AD 00 07
        sbc     #$0F                            ; E204 E9 0F
        sta     SP                              ; E206 8D 00 07
        lda     #$06                            ; E209 A9 06
        .byte   $2C                             ; E20B 2C
LE20C:
        lda     #$03                            ; E20C A9 03
        clc                                     ; E20E 18
        adc     RESB                            ; E20F 65 02
        sta     RESB                            ; E211 85 02
        bcc     LE217                           ; E213 90 02
        inc     RESB+1                          ; E215 E6 03
LE217:
        jmp     (RESB)                          ; E217 6C 02 00

; ----------------------------------------------------------------------------
        beq     LE221                           ; E21A F0 05

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$06                            ; E21C A2 06
        jmp     LC676                           ; E21E 4C 76 C6

; ----------------------------------------------------------------------------
LE221:
        jmp     LC906                           ; E221 4C 06 C9

; ----------------------------------------------------------------------------
UNTIL_lfa:
        .addr   UNCOUNT_lfa                     ; E224 37 E2
; ----------------------------------------------------------------------------
UNTIL_pfa:
        .byte   $01,$00,$0E,$00,$0C             ; E226 01 00 0E 00 0C
; ----------------------------------------------------------------------------
UNTIL:
        .byte   "UNTIL"                         ; E22B 55 4E 54 49 4C
; ----------------------------------------------------------------------------
        .byte   $84,$05                         ; E230 84 05
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; E232 A5 60
        bne     UNCOUNT_pfa                     ; E234 D0 03
        .byte   $4C                             ; E236 4C

; ----------------------------------------------------------------------------
UNCOUNT_lfa:
        .addr   WEND_lfa                        ; E237 52 E2
; ----------------------------------------------------------------------------
UNCOUNT_pfa:
        .byte   $01,$00,$0F,$00,$0E             ; E239 01 00 0F 00 0E
; ----------------------------------------------------------------------------
UNCOUNT:
        .byte   "UNCOUNT"                       ; E23E 55 4E 43 4F 55 4E 54
; ----------------------------------------------------------------------------
        .byte   $80,$0B                         ; E245 80 0B
; ----------------------------------------------------------------------------
        inc     L2710                           ; E247 EE 10 27
        bne     LE251                           ; E24A D0 05
        inc     $2711                           ; E24C EE 11 27
        beq     WEND_pfa                        ; E24F F0 03
LE251:
        .byte   $4C                             ; E251 4C

; ----------------------------------------------------------------------------
WEND_lfa:
        .addr   ^_lfa                           ; E252 60 E2
; ----------------------------------------------------------------------------
WEND_pfa:
        .byte   $01,$00,$10,$00,$0B             ; E254 01 00 10 00 0B
; ----------------------------------------------------------------------------
WEND:
        .byte   "WEND"                          ; E259 57 45 4E 44
; ----------------------------------------------------------------------------
        .byte   $80,$01                         ; E25D 80 01
; ----------------------------------------------------------------------------
        .byte   $4C                             ; E25F 4C

; ----------------------------------------------------------------------------
^_lfa:
        .addr   *_lfa                           ; E260 78 E2
; ----------------------------------------------------------------------------
^_pfa:
        .byte   $03,$64,$12,$00,$08             ; E262 03 64 12 00 08
; ----------------------------------------------------------------------------
^:      .byte   "^"                             ; E267 5E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E268 80 83
; ----------------------------------------------------------------------------
        lda     #$6E                            ; E26A A9 6E
LE26C:
        sta     L07ED+1                         ; E26C 8D EE 07
        jsr     LD311                           ; E26F 20 11 D3
        jsr     L07ED                           ; E272 20 ED 07
        jmp     Error_TRIGO                     ; E275 4C 62 D1

; ----------------------------------------------------------------------------
*_lfa:
        .addr   /_lfa                           ; E278 86 E2
; ----------------------------------------------------------------------------
*_pfa:
        .byte   $03,$5F,$13,$00,$08             ; E27A 03 5F 13 00 08
; ----------------------------------------------------------------------------
*:      .byte   "*"                             ; E27F 2A
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E280 80 83
; ----------------------------------------------------------------------------
        lda     #$6C                            ; E282 A9 6C
        bne     LE26C                           ; E284 D0 E6

; ----------------------------------------------------------------------------
/_lfa:
        .addr   +_lfa                           ; E286 94 E2
; ----------------------------------------------------------------------------
/_pfa:
        .byte   $03,$5F,$14,$00,$08             ; E288 03 5F 14 00 08
; ----------------------------------------------------------------------------
/:      .byte   "/"                             ; E28D 2F
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E28E 80 83
; ----------------------------------------------------------------------------
        lda     #$6D                            ; E290 A9 6D
        bne     LE26C                           ; E292 D0 D8

; ----------------------------------------------------------------------------
+_lfa:
        .addr   -_lfa                           ; E294 C6 E2
; ----------------------------------------------------------------------------
+_pfa:
        .byte   $03,$5A,$15,$00,$08             ; E296 03 5A 15 00 08
; ----------------------------------------------------------------------------
+:      .byte   "+"                             ; E29B 2B
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E29C 80 83
; ----------------------------------------------------------------------------
        bit     $BA                             ; E29E 24 BA
        bpl     LE2BD                           ; E2A0 10 1B

        jsr     LD30E                           ; E2A2 20 0E D3

        clc                                     ; E2A5 18
        lda     FACC1E                          ; E2A6 A5 60
        adc     FACC2E                          ; E2A8 65 68
        bcs     Error_STRLEN                    ; E2AA B0 15

        pha                                     ; E2AC 48
        jsr     LCF5C                           ; E2AD 20 5C CF
        lda     FACC2M                          ; E2B0 A5 69
        ldy     FACC2M+1                        ; E2B2 A4 6A
        ldx     FACC2E                          ; E2B4 A6 68
        jsr     LCF62                           ; E2B6 20 62 CF
        pla                                     ; E2B9 68
        sta     FACC1E                          ; E2BA 85 60
        rts                                     ; E2BC 60

; ----------------------------------------------------------------------------
LE2BD:
        lda     #$6A                            ; E2BD A9 6A
        bne     LE26C                           ; E2BF D0 AB

; Erreur: chaine trop longue
Error_STRLEN:
        ldx     #$1A                            ; E2C1 A2 1A
        jmp     Error_X                         ; E2C3 4C 7E D1

; ----------------------------------------------------------------------------
-_lfa:
        .addr   =_lfa                           ; E2C6 D4 E2
; ----------------------------------------------------------------------------
-_pfa:
        .byte   $03,$5A,$16,$00,$08             ; E2C8 03 5A 16 00 08
; ----------------------------------------------------------------------------
-:      .byte   "-"                             ; E2CD 2D
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E2CE 80 83
; ----------------------------------------------------------------------------
        lda     #$6B                            ; E2D0 A9 6B
        bne     LE26C                           ; E2D2 D0 98

; ----------------------------------------------------------------------------
=_lfa:
        .addr   >=_lfa                          ; E2D4 E2 E2
; ----------------------------------------------------------------------------
=_pfa:
        .byte   $03,$58,$17,$00,$08             ; E2D6 03 58 17 00 08
; ----------------------------------------------------------------------------
=:      .byte   "="                             ; E2DB 3D
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E2DC 80 83
; ----------------------------------------------------------------------------
        lda     #$02                            ; E2DE A9 02
        bne     LE329                           ; E2E0 D0 47

; ----------------------------------------------------------------------------
>=_lfa:
        .addr   <=_lfa                          ; E2E2 F1 E2
; ----------------------------------------------------------------------------
>=_pfa:
        .byte   $03,$58,$18,$00,$09             ; E2E4 03 58 18 00 09
; ----------------------------------------------------------------------------
>=:
        .byte   ">="                            ; E2E9 3E 3D
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E2EB 80 83
; ----------------------------------------------------------------------------
        lda     #$03                            ; E2ED A9 03
        bne     LE329                           ; E2EF D0 38

; ----------------------------------------------------------------------------
<=_lfa:
        .addr   <>_lfa                          ; E2F1 00 E3
; ----------------------------------------------------------------------------
<=_pfa:
        .byte   $03,$58,$19,$00,$09             ; E2F3 03 58 19 00 09
; ----------------------------------------------------------------------------
<=:
        .byte   "<="                            ; E2F8 3C 3D
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E2FA 80 83
; ----------------------------------------------------------------------------
        lda     #$06                            ; E2FC A9 06
        bne     LE329                           ; E2FE D0 29

; ----------------------------------------------------------------------------
<>_lfa:
        .addr   >_lfa                           ; E300 0F E3
; ----------------------------------------------------------------------------
<>_pfa:
        .byte   $03,$58,$1A,$00,$09             ; E302 03 58 1A 00 09
; ----------------------------------------------------------------------------
<>:
        .byte   "<>"                            ; E307 3C 3E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E309 80 83
; ----------------------------------------------------------------------------
        lda     #$05                            ; E30B A9 05
        bne     LE329                           ; E30D D0 1A

; ----------------------------------------------------------------------------
>_lfa:
        .addr   <_lfa                           ; E30F 1D E3
; ----------------------------------------------------------------------------
>_pfa:
        .byte   $03,$58,$1B,$00,$08             ; E311 03 58 1B 00 08
; ----------------------------------------------------------------------------
>:      .byte   ">"                             ; E316 3E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E317 80 83
; ----------------------------------------------------------------------------
        lda     #$01                            ; E319 A9 01
        bne     LE329                           ; E31B D0 0C

; ----------------------------------------------------------------------------
<_lfa:
        .addr   XOR_lfa                         ; E31D B9 E3
; ----------------------------------------------------------------------------
<_pfa:
        .byte   $03,$58,$1C,$00,$08             ; E31F 03 58 1C 00 08
; ----------------------------------------------------------------------------
<:      .byte   "<"                             ; E324 3C
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E325 80 83
; ----------------------------------------------------------------------------
        lda     #$04                            ; E327 A9 04
LE329:
        sta     $90                             ; E329 85 90
        bit     $BA                             ; E32B 24 BA
        bmi     LE376                           ; E32D 30 47
        jsr     LD311                           ; E32F 20 11 D3
        jsr     LE339                           ; E332 20 39 E3
        tax                                     ; E335 AA
        jmp     LE394                           ; E336 4C 94 E3

; ----------------------------------------------------------------------------
LE339:
        lda     FACC2E                          ; E339 A5 68
        tax                                     ; E33B AA
        beq     LE368                           ; E33C F0 2A
        lda     FACC2S                          ; E33E A5 6D
        eor     FACC1S                          ; E340 45 65
        bmi     LE36C                           ; E342 30 28
        cpx     FACC1E                          ; E344 E4 60
        bne     LE360                           ; E346 D0 18
        lda     FACC2M                          ; E348 A5 69
        cmp     FACC1M                          ; E34A C5 61
        bne     LE360                           ; E34C D0 12
        lda     FACC2M+1                        ; E34E A5 6A
        cmp     FACC1M+1                        ; E350 C5 62
        bne     LE360                           ; E352 D0 0C
        lda     FACC2M+2                        ; E354 A5 6B
        cmp     FACC1M+2                        ; E356 C5 63
        bne     LE360                           ; E358 D0 06
        lda     FACC2M+3                        ; E35A A5 6C
        cmp     FACC1M+3                        ; E35C C5 64
        beq     LE375                           ; E35E F0 15
LE360:
        lda     FACC1S                          ; E360 A5 65
        bcc     LE36E                           ; E362 90 0A
        eor     #$FF                            ; E364 49 FF
        bcs     LE36E                           ; E366 B0 06
LE368:
        lda     FACC1E                          ; E368 A5 60
        beq     LE375                           ; E36A F0 09
LE36C:
        lda     FACC1S                          ; E36C A5 65
LE36E:
        rol     a                               ; E36E 2A
        lda     #$FF                            ; E36F A9 FF
        bcs     LE375                           ; E371 B0 02
        lda     #$01                            ; E373 A9 01
LE375:
        rts                                     ; E375 60

; ----------------------------------------------------------------------------
LE376:
        jsr     LD30E                           ; E376 20 0E D3
        lda     FACC2E                          ; E379 A5 68
        tax                                     ; E37B AA
        sec                                     ; E37C 38
        sbc     FACC1E                          ; E37D E5 60
        beq     LE389                           ; E37F F0 08
        lda     #$01                            ; E381 A9 01
        bcc     LE389                           ; E383 90 04
        ldx     FACC1E                          ; E385 A6 60
        lda     #$FF                            ; E387 A9 FF
LE389:
        sta     FACC1S                          ; E389 85 65
        ldy     #$FF                            ; E38B A0 FF
        inx                                     ; E38D E8
LE38E:
        iny                                     ; E38E C8
        dex                                     ; E38F CA
        bne     LE399                           ; E390 D0 07
        ldx     FACC1S                          ; E392 A6 65
LE394:
        bmi     LE3A5                           ; E394 30 0F
        clc                                     ; E396 18
        bcc     LE3A5                           ; E397 90 0C
LE399:
        lda     (FACC2M),y                      ; E399 B1 69
        cmp     (FACC1M),y                      ; E39B D1 61
        beq     LE38E                           ; E39D F0 EF
        ldx     #$FF                            ; E39F A2 FF
        bcs     LE3A5                           ; E3A1 B0 02
        ldx     #$01                            ; E3A3 A2 01
LE3A5:
        inx                                     ; E3A5 E8
        txa                                     ; E3A6 8A
        rol     a                               ; E3A7 2A
        and     $90                             ; E3A8 25 90
        beq     LE3AE                           ; E3AA F0 02
        lda     #$01                            ; E3AC A9 01
LE3AE:
        sta     FACC1M                          ; E3AE 85 61
        sta     FACC1E                          ; E3B0 85 60
        lda     #$00                            ; E3B2 A9 00
        sta     FACC1M+1                        ; E3B4 85 62
        sta     $BA                             ; E3B6 85 BA
        rts                                     ; E3B8 60

; ----------------------------------------------------------------------------
XOR_lfa:
        .addr   AND_lfa                         ; E3B9 D4 E3
; ----------------------------------------------------------------------------
XOR_pfa:
        .byte   $03,$55,$1D,$00,$0A             ; E3BB 03 55 1D 00 0A
; ----------------------------------------------------------------------------
XOR:
        .byte   "XOR"                           ; E3C0 58 4F 52
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E3C3 80 83
; ----------------------------------------------------------------------------
        jsr     LD314                           ; E3C5 20 14 D3
        lda     FACC1M                          ; E3C8 A5 61
        eor     FACC2M                          ; E3CA 45 69
        tay                                     ; E3CC A8
        lda     FACC1M+1                        ; E3CD A5 62
        eor     FACC2M+1                        ; E3CF 45 6A
        jmp     LE3EE                           ; E3D1 4C EE E3

; ----------------------------------------------------------------------------
AND_lfa:
        .addr   OR_lfa                          ; E3D4 F7 E3
; ----------------------------------------------------------------------------
AND_pfa:
        .byte   $03,$52,$1E,$00,$0A             ; E3D6 03 52 1E 00 0A
; ----------------------------------------------------------------------------
AND:
        .byte   "AND"                           ; E3DB 41 4E 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E3DE 80 83
; ----------------------------------------------------------------------------
        jsr     LD314                           ; E3E0 20 14 D3
        lda     FACC1M                          ; E3E3 A5 61
        and     FACC2M                          ; E3E5 25 69
        sta     FACC1M                          ; E3E7 85 61
        tay                                     ; E3E9 A8
        lda     FACC1M+1                        ; E3EA A5 62
        and     FACC2M+1                        ; E3EC 25 6A
LE3EE:
        sta     FACC1M+1                        ; E3EE 85 62
        sty     FACC1M                          ; E3F0 84 61
        ora     FACC1M                          ; E3F2 05 61
        sta     FACC1E                          ; E3F4 85 60
        rts                                     ; E3F6 60

; ----------------------------------------------------------------------------
OR_lfa:
        .addr   COS_lfa                         ; E3F7 2B E5
; ----------------------------------------------------------------------------
OR_pfa:
        .byte   $03,$50,$1F,$00,$09             ; E3F9 03 50 1F 00 09
; ----------------------------------------------------------------------------
OR:
        .byte   "OR"                            ; E3FE 4F 52
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E400 80 83
; ----------------------------------------------------------------------------
        jsr     LD314                           ; E402 20 14 D3
        lda     FACC1M                          ; E405 A5 61
        ora     FACC2M                          ; E407 05 69
        tay                                     ; E409 A8
        lda     FACC1M+1                        ; E40A A5 62
        ora     FACC2M+1                        ; E40C 05 6A
        jmp     LE3EE                           ; E40E 4C EE E3

; ----------------------------------------------------------------------------
LE411:
        jsr     LD51E                           ; E411 20 1E D5                 Procédure $00
        jsr     LD4D7                           ; E414 20 D7 D4                 Procédure $01
        jsr     LE95A                           ; E417 20 5A E9                 Procédure $02
        jsr     LE95F                           ; E41A 20 5F E9                 Procédure

; Ecrit CR/LF sur le canal (L07EB)
        jsr     LE50D                           ; E41D 20 0D E5                 Procédure

        jsr     LE4ED                           ; E420 20 ED E4                 Procédure $03
        jsr     LE4C9                           ; E423 20 C9 E4                 Procédure
        jsr     LE4CF                           ; E426 20 CF E4                 Procédure $04
        jsr     LE4D5                           ; E429 20 D5 E4                 Procédure
        jsr     LE4EC                           ; E42C 20 EC E4                 Procédure $05
        jsr     LC1F3                           ; E42F 20 F3 C1                 Procédure
        jsr     LD28F                           ; E432 20 8F D2                 Procédure
        jsr     LF641                           ; E435 20 41 F6                 Procédure
        jsr     LF5E6                           ; E438 20 E6 F5                 Procédure $01
        jsr     LF5FE                           ; E43B 20 FE F5                 Procédure $01
        jsr     LF60A                           ; E43E 20 0A F6                 Procédure $01
        jsr     LF619                           ; E441 20 19 F6                 Procédure $01
        jsr     LF997                           ; E444 20 97 F9                 Procédure $01
        jsr     LE046                           ; E447 20 46 E0                 Procédure $01
        jsr     LEAF4                           ; E44A 20 F4 EA                 Procédure $01
        jsr     LEB0A                           ; E44D 20 0A EB                 Procédure $01
        jsr     LE4B9                           ; E450 20 B9 E4                 Procédure $01
        jsr     LE4F7                           ; E453 20 F7 E4                 Procédure $01
        jsr     LE517                           ; E456 20 17 E5                 Procédure $01
        jsr     LE51C                           ; E459 20 1C E5                 Procédure $01
        jsr     LD4D7                           ; E45C 20 D7 D4                 Procédure $01
        lda     #$00                            ; E45F A9 00                    Procédure $01
        sta     FACC1E                          ; E461 85 60
        ; Place un XWR1
        lda     #$11                            ; E463 A9 11
        sta     L07EA+1                         ; E465 8D EB 07

; Table de conversion de caractère
LE468:
        .byte   $3A,$2C,$2C,$3B,$00,$00,$00,$00 ; E468 3A 2C 2C 3B 00 00 00 00  : , , ; _ _ _ _
        .byte   $00,$00,$00,$00,$3D,$28,$29,$00 ; E470 00 00 00 00 3D 28 29 00  _ _ _ _ = ( ) _
        .byte   $00,$00,$00,$00,$00,$00,$00,$41 ; E478 00 00 00 00 00 00 00 41  _ _ _ _ _ _ _ A
        .byte   $45,$54,$00,$2C,$2C,$00,$00,$5D ; E480 45 54 00 2C 2C 00 00 5D  E T _ , , _ _ ]
        .byte   $00,$2C,$2C,$00,$40,$00,$00,$00 ; E488 00 2C 2C 00 40 00 00 00  _ , , _ @ _ _ _

; Offsets dans la table $E411. Octet 0: offset debut, Octet 1: offset fin
LE490:
        .byte   $00,$03,$06,$09,$09,$0C,$0F,$12 ; E490 00 03 06 09 09 0C 0F 12
        .byte   $15,$18,$1B,$1E,$21,$21,$21,$21 ; E498 15 18 1B 1E 21 21 21 21
        .byte   $21,$24,$27,$2A,$2D,$30,$33,$36 ; E4A0 21 24 27 2A 2D 30 33 36
        .byte   $36,$36,$36,$39,$3C,$3F,$3F,$42 ; E4A8 36 36 36 39 3C 3F 3F 42
        .byte   $42,$45,$45,$48,$4B,$4B,$4E,$52 ; E4B0 42 45 45 48 4B 4B 4E 52
        .byte   $57                             ; E4B8 57
; ----------------------------------------------------------------------------
LE4B9:
        ldx     #$00                            ; E4B9 A2 00
        stx     $BA                             ; E4BB 86 BA
        stx     $9C                             ; E4BD 86 9C
        stx     FACC1M                          ; E4BF 86 61
        stx     FACC1M+1                        ; E4C1 86 62
        dex                                     ; E4C3 CA
        stx     $9E                             ; E4C4 86 9E
        stx     $9F                             ; E4C6 86 9F
        rts                                     ; E4C8 60

; ----------------------------------------------------------------------------
LE4C9:
        lda     #$90                            ; E4C9 A9 90
        ldy     #$80                            ; E4CB A0 80
        bne     LE4D9                           ; E4CD D0 0A
LE4CF:
        lda     #$8F                            ; E4CF A9 8F
        ldy     #$40                            ; E4D1 A0 40
        bne     LE4D9                           ; E4D3 D0 04
LE4D5:
        lda     #$8E                            ; E4D5 A9 8E
        ldy     #$C0                            ; E4D7 A0 C0
LE4D9:
        sty     $9B                             ; E4D9 84 9B
        pha                                     ; E4DB 48

        ; L07EA: XWR2
        lda     #$12                            ; E4DC A9 12
        sta     L07EA+1                         ; E4DE 8D EB 07

        ldx     #$03                            ; E4E1 A2 03
LE4E3:
        lsr     IOTAB2,x                        ; E4E3 5E B6 02
        dex                                     ; E4E6 CA
        bpl     LE4E3                           ; E4E7 10 FA

        pla                                     ; E4E9 68
        XOP2                                    ; E4EA 00 02
LE4EC:
        rts                                     ; E4EC 60

; ----------------------------------------------------------------------------
LE4ED:
        ; L07EA: XWR0
        lda     #$10                            ; E4ED A9 10
        sta     L07EA+1                         ; E4EF 8D EB 07

        lda     #$00                            ; E4F2 A9 00
        sta     $9B                             ; E4F4 85 9B
        rts                                     ; E4F6 60

; ----------------------------------------------------------------------------
LE4F7:
        jsr     LD1F7                           ; E4F7 20 F7 D1
        lda     FACC1M                          ; E4FA A5 61
        cmp     #$04                            ; E4FC C9 04
        bcs     LE50A                           ; E4FE B0 0A

        adc     #$10                            ; E500 69 10
        sta     L07EA+1                         ; E502 8D EB 07
        lda     #$FF                            ; E505 A9 FF
        sta     $C3                             ; E507 85 C3
        rts                                     ; E509 60

; ----------------------------------------------------------------------------
LE50A:
        jmp     Error_BADVAL                    ; E50A 4C FF F0

; ----------------------------------------------------------------------------
; Ecrit CR/LF sur le canal (L07EB)
LE50D:
        lda     #$0D                            ; E50D A9 0D
        jsr     L07EA                           ; E50F 20 EA 07
        lda     #$0A                            ; E512 A9 0A
        jmp     L07EA                           ; E514 4C EA 07

; ----------------------------------------------------------------------------
LE517:
        lda     #$1F                            ; E517 A9 1F
        jsr     L07EA                           ; E519 20 EA 07
LE51C:
        lda     #$FF                            ; E51C A9 FF
        sta     $C3                             ; E51E 85 C3
        jsr     LD1F7                           ; E520 20 F7 D1
        lda     FACC1M                          ; E523 A5 61
        clc                                     ; E525 18
        adc     #$40                            ; E526 69 40
        jmp     L07EA                           ; E528 4C EA 07

; ----------------------------------------------------------------------------
COS_lfa:
        .addr   SIN_lfa                         ; E52B 3B E5
; ----------------------------------------------------------------------------
COS_pfa:
        .byte   $02,$02,$80,$00,$0A             ; E52D 02 02 80 00 0A
; ----------------------------------------------------------------------------
COS:
        .byte   "COS"                           ; E532 43 4F 53
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E535 80 83
; ----------------------------------------------------------------------------
        lda     #$71                            ; E537 A9 71
        bne     TrigoFct                        ; E539 D0 5E

; ----------------------------------------------------------------------------
SIN_lfa:
        .addr   ABS_lfa                         ; E53B 4B E5
; ----------------------------------------------------------------------------
SIN_pfa:
        .byte   $02,$02,$81,$00,$0A             ; E53D 02 02 81 00 0A
; ----------------------------------------------------------------------------
SIN:
        .byte   "SIN"                           ; E542 53 49 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E545 80 83
; ----------------------------------------------------------------------------
        lda     #$70                            ; E547 A9 70
        bne     TrigoFct                        ; E549 D0 4E

; ----------------------------------------------------------------------------
ABS_lfa:
        .addr   ATN_lfa                         ; E54B 5E E5
; ----------------------------------------------------------------------------
ABS_pfa:
        .byte   $02,$02,$82,$00,$0A             ; E54D 02 02 82 00 0A
; ----------------------------------------------------------------------------
ABS:
        .byte   "ABS"                           ; E552 41 42 53
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E555 80 83
; ----------------------------------------------------------------------------
        lda     $BA                             ; E557 A5 BA
        beq     LE55D                           ; E559 F0 02

        lsr     FACC1S                          ; E55B 46 65
LE55D:
        rts                                     ; E55D 60

; ----------------------------------------------------------------------------
ATN_lfa:
        .addr   DEEK_lfa                        ; E55E 6E E5
; ----------------------------------------------------------------------------
ATN_pfa:
        .byte   $02,$02,$83,$00,$0A             ; E560 02 02 83 00 0A
; ----------------------------------------------------------------------------
ATN:
        .byte   "ATN"                           ; E565 41 54 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E568 80 83
; ----------------------------------------------------------------------------
        lda     #$73                            ; E56A A9 73
        bne     TrigoFct                        ; E56C D0 2B

; ----------------------------------------------------------------------------
DEEK_lfa:
        .addr   DEG_lfa                         ; E56E 8B E5
; ----------------------------------------------------------------------------
DEEK_pfa:
        .byte   $02,$02,$84,$00,$0B             ; E570 02 02 84 00 0B
; ----------------------------------------------------------------------------
DEEK:
        .byte   "DEEK"                          ; E575 44 45 45 4B
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E579 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; E57B 20 F7 D1
        ldy     #$00                            ; E57E A0 00
        lda     (FACC1M),y                      ; E580 B1 61
        tax                                     ; E582 AA
        iny                                     ; E583 C8
        lda     (FACC1M),y                      ; E584 B1 61
        sta     FACC1M+1                        ; E586 85 62
        stx     FACC1M                          ; E588 86 61
        rts                                     ; E58A 60

; ----------------------------------------------------------------------------
DEG_lfa:
        .addr   EXP_lfa                         ; E58B A5 E5
; ----------------------------------------------------------------------------
DEG_pfa:
        .byte   $02,$02,$85,$00,$0A             ; E58D 02 02 85 00 0A
; ----------------------------------------------------------------------------
DEG:
        .byte   "DEG"                           ; E592 44 45 47
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E595 80 83
; ----------------------------------------------------------------------------
        lda     #$7A                            ; E597 A9 7A
; Exécute une fonction Trigo, code de la fonction dans ACC
TrigoFct:
        sta     L07ED+1                         ; E599 8D EE 07
        jsr     LD23B                           ; E59C 20 3B D2
        jsr     L07ED                           ; E59F 20 ED 07
        jmp     Error_TRIGO                     ; E5A2 4C 62 D1

; ----------------------------------------------------------------------------
EXP_lfa:
        .addr   LN_lfa                          ; E5A5 B5 E5
; ----------------------------------------------------------------------------
EXP_pfa:
        .byte   $02,$02,$86,$00,$0A             ; E5A7 02 02 86 00 0A
; ----------------------------------------------------------------------------
EXP:
        .byte   "EXP"                           ; E5AC 45 58 50
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E5AF 80 83
; ----------------------------------------------------------------------------
        lda     #$74                            ; E5B1 A9 74
        bne     TrigoFct                        ; E5B3 D0 E4

; ----------------------------------------------------------------------------
LN_lfa:
        .addr   LOG_lfa                         ; E5B5 C4 E5
; ----------------------------------------------------------------------------
LN_pfa:
        .byte   $02,$02,$87,$00,$09             ; E5B7 02 02 87 00 09
; ----------------------------------------------------------------------------
LN:
        .byte   "LN"                            ; E5BC 4C 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E5BE 80 83
; ----------------------------------------------------------------------------
        lda     #$75                            ; E5C0 A9 75
        bne     TrigoFct                        ; E5C2 D0 D5

; ----------------------------------------------------------------------------
LOG_lfa:
        .addr   PEEK_lfa                        ; E5C4 D4 E5
; ----------------------------------------------------------------------------
LOG_pfa:
        .byte   $02,$02,$88,$00,$0A             ; E5C6 02 02 88 00 0A
; ----------------------------------------------------------------------------
LOG:
        .byte   "LOG"                           ; E5CB 4C 4F 47
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E5CE 80 83
; ----------------------------------------------------------------------------
        lda     #$76                            ; E5D0 A9 76
        bne     TrigoFct                        ; E5D2 D0 C5

; ----------------------------------------------------------------------------
PEEK_lfa:
        .addr   RAD_lfa                         ; E5D4 ED E5
; ----------------------------------------------------------------------------
PEEK_pfa:
        .byte   $02,$02,$89,$00,$0B             ; E5D6 02 02 89 00 0B
; ----------------------------------------------------------------------------
PEEK:
        .byte   "PEEK"                          ; E5DB 50 45 45 4B
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E5DF 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; E5E1 20 F7 D1
        ldy     #$00                            ; E5E4 A0 00
        lda     (FACC1M),y                      ; E5E6 B1 61
        sta     FACC1M                          ; E5E8 85 61
        sty     FACC1M+1                        ; E5EA 84 62
        rts                                     ; E5EC 60

; ----------------------------------------------------------------------------
RAD_lfa:
        .addr   RND_lfa                         ; E5ED FD E5
; ----------------------------------------------------------------------------
RAD_pfa:
        .byte   $02,$02,$8A,$00,$0A             ; E5EF 02 02 8A 00 0A
; ----------------------------------------------------------------------------
RAD:
        .byte   "RAD"                           ; E5F4 52 41 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E5F7 80 83
; ----------------------------------------------------------------------------
        lda     #$79                            ; E5F9 A9 79
        bne     TrigoFct                        ; E5FB D0 9C

; ----------------------------------------------------------------------------
RND_lfa:
        .addr   SQR_lfa                         ; E5FD 0D E6
; ----------------------------------------------------------------------------
RND_pfa:
        .byte   $02,$02,$8B,$00,$0A             ; E5FF 02 02 8B 00 0A
; ----------------------------------------------------------------------------
RND:
        .byte   "RND"                           ; E604 52 4E 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E607 80 83
; ----------------------------------------------------------------------------
        lda     #$77                            ; E609 A9 77
        bne     TrigoFct                        ; E60B D0 8C

; ----------------------------------------------------------------------------
SQR_lfa:
        .addr   TAN_lfa                         ; E60D 1E E6
; ----------------------------------------------------------------------------
SQR_pfa:
        .byte   $02,$02,$8C,$00,$0A             ; E60F 02 02 8C 00 0A
; ----------------------------------------------------------------------------
SQR:
        .byte   "SQR"                           ; E614 53 51 52
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E617 80 83
; ----------------------------------------------------------------------------
        lda     #$78                            ; E619 A9 78
        jmp     TrigoFct                        ; E61B 4C 99 E5

; ----------------------------------------------------------------------------
TAN_lfa:
        .addr   LOB$_lfa                        ; E61E 2F E6
; ----------------------------------------------------------------------------
TAN_pfa:
        .byte   $02,$02,$8D,$00,$0A             ; E620 02 02 8D 00 0A
; ----------------------------------------------------------------------------
TAN:
        .byte   "TAN"                           ; E625 54 41 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E628 80 83
; ----------------------------------------------------------------------------
        lda     #$72                            ; E62A A9 72
        jmp     TrigoFct                        ; E62C 4C 99 E5

; ----------------------------------------------------------------------------
LOB$_lfa:
        .addr   LO$_lfa                         ; E62F 7B E6
; ----------------------------------------------------------------------------
LOB$_pfa:
        .byte   $02,$04,$8E,$00,$0B             ; E631 02 04 8E 00 0B
; ----------------------------------------------------------------------------
LOB$:
        .byte   "LOB$"                          ; E636 4C 4F 42 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E63A 80 83
; ----------------------------------------------------------------------------
        clc                                     ; E63C 18
        ldy     #$01                            ; E63D A0 01
        bcc     LE646                           ; E63F 90 05
LE641:
        clc                                     ; E641 18
        .byte   $24                             ; E642 24
LE643:
        sec                                     ; E643 38
        ldy     #$00                            ; E644 A0 00
LE646:
        ror     $8F                             ; E646 66 8F
        sty     $8E                             ; E648 84 8E
        jsr     LCF5C                           ; E64A 20 5C CF
        ldy     $8E                             ; E64D A4 8E
        beq     LE65B                           ; E64F F0 0A
        lda     FACC1E                          ; E651 A5 60
        beq     LE67A                           ; E653 F0 25
        dey                                     ; E655 88
        lda     (FACC1M),y                      ; E656 B1 61
        jmp     LE674                           ; E658 4C 74 E6

; ----------------------------------------------------------------------------
LE65B:
        cpy     FACC1E                          ; E65B C4 60
        bcs     LE67A                           ; E65D B0 1B
        lda     (FACC1M),y                      ; E65F B1 61
        bit     $8F                             ; E661 24 8F
        bmi     LE671                           ; E663 30 0C
        cmp     #$41                            ; E665 C9 41
        bcc     LE674                           ; E667 90 0B
        cmp     #$5B                            ; E669 C9 5B
        bcs     LE674                           ; E66B B0 07
        adc     #$20                            ; E66D 69 20
        bcc     LE674                           ; E66F 90 03
LE671:
        jsr     LCB45                           ; E671 20 45 CB
LE674:
        sta     (FACC1M),y                      ; E674 91 61
        iny                                     ; E676 C8
        jmp     LE65B                           ; E677 4C 5B E6

; ----------------------------------------------------------------------------
LE67A:
        rts                                     ; E67A 60

; ----------------------------------------------------------------------------
LO$_lfa:
        .addr   UP$_lfa                         ; E67B 8A E6
; ----------------------------------------------------------------------------
LO$_pfa:
        .byte   $02,$04,$8F,$00,$0A             ; E67D 02 04 8F 00 0A
; ----------------------------------------------------------------------------
LO$:
        .byte   "LO$"                           ; E682 4C 4F 24
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; E685 80 03
; ----------------------------------------------------------------------------
        jsr     LE641                           ; E687 20 41 E6

; ----------------------------------------------------------------------------
UP$_lfa:
        .addr   BIN$_lfa                        ; E68A 99 E6
; ----------------------------------------------------------------------------
UP$_pfa:
        .byte   $02,$04,$90,$00,$0A             ; E68C 02 04 90 00 0A
; ----------------------------------------------------------------------------
UP$:
        .byte   "UP$"                           ; E691 55 50 24
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; E694 80 03
; ----------------------------------------------------------------------------
        jsr     LE643                           ; E696 20 43 E6

; ----------------------------------------------------------------------------
BIN$_lfa:
        .addr   CHR$_lfa                        ; E699 DA E6
; ----------------------------------------------------------------------------
BIN$_pfa:
        .byte   $02,$03,$91,$00,$0B             ; E69B 02 03 91 00 0B
; ----------------------------------------------------------------------------
BIN$:
        .byte   "BIN$"                          ; E6A0 42 49 4E 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E6A4 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; E6A6 20 F7 D1
        sec                                     ; E6A9 38
        ror     RES                             ; E6AA 66 00
        ldy     #$10                            ; E6AC A0 10
        lda     #$25                            ; E6AE A9 25
        sta     L0100                           ; E6B0 8D 00 01
        ldx     #$01                            ; E6B3 A2 01
LE6B5:
        asl     FACC1M                          ; E6B5 06 61
        rol     FACC1M+1                        ; E6B7 26 62
        bcs     LE6C0                           ; E6B9 B0 05
        bit     RES                             ; E6BB 24 00
        bmi     LE6CA                           ; E6BD 30 0B
        .byte   $2C                             ; E6BF 2C
LE6C0:
        sta     RES                             ; E6C0 85 00
        lda     #$00                            ; E6C2 A9 00
        adc     #$30                            ; E6C4 69 30
        sta     L0100,x                         ; E6C6 9D 00 01
        inx                                     ; E6C9 E8
LE6CA:
        dey                                     ; E6CA 88
        bne     LE6B5                           ; E6CB D0 E8
LE6CD:
        cpx     #$01                            ; E6CD E0 01
        bne     LE6D7                           ; E6CF D0 06
        inx                                     ; E6D1 E8
        lda     #$30                            ; E6D2 A9 30
        sta     $0101                           ; E6D4 8D 01 01
LE6D7:
        jmp     LE779                           ; E6D7 4C 79 E7

; ----------------------------------------------------------------------------
CHR$_lfa:
        .addr   HEX$_lfa                        ; E6DA F6 E6
; ----------------------------------------------------------------------------
CHR$_pfa:
        .byte   $02,$03,$92,$00,$0B             ; E6DC 02 03 92 00 0B
; ----------------------------------------------------------------------------
CHR$:
        .byte   "CHR$"                          ; E6E1 43 48 52 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E6E5 80 83
; ----------------------------------------------------------------------------
        jsr     LD22E                           ; E6E7 20 2E D2
        pha                                     ; E6EA 48
        lda     #$01                            ; E6EB A9 01
        jsr     LCF52                           ; E6ED 20 52 CF
        ldy     #$00                            ; E6F0 A0 00
        pla                                     ; E6F2 68
        sta     (FACC1M),y                      ; E6F3 91 61
        rts                                     ; E6F5 60

; ----------------------------------------------------------------------------
HEX$_lfa:
        .addr   SPC$_lfa                        ; E6F6 40 E7
; ----------------------------------------------------------------------------
HEX$_pfa:
        .byte   $02,$03,$93,$00,$0B             ; E6F8 02 03 93 00 0B
; ----------------------------------------------------------------------------
HEX$:
        .byte   "HEX$"                          ; E6FD 48 45 58 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E701 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; E703 20 F7 D1
        sec                                     ; E706 38
        ror     RES                             ; E707 66 00
        lda     #$23                            ; E709 A9 23
        sta     L0100                           ; E70B 8D 00 01
        ldx     #$01                            ; E70E A2 01
        lda     FACC1M+1                        ; E710 A5 62
        jsr     LE71D                           ; E712 20 1D E7
        lda     FACC1M                          ; E715 A5 61
        jsr     LE71D                           ; E717 20 1D E7
        jmp     LE6CD                           ; E71A 4C CD E6

; ----------------------------------------------------------------------------
LE71D:
        pha                                     ; E71D 48
        lsr     a                               ; E71E 4A
        lsr     a                               ; E71F 4A
        lsr     a                               ; E720 4A
        lsr     a                               ; E721 4A
        jsr     LE728                           ; E722 20 28 E7
        pla                                     ; E725 68
        and     #$0F                            ; E726 29 0F
LE728:
        ora     #$30                            ; E728 09 30
        cmp     #$3A                            ; E72A C9 3A
        bcc     LE730                           ; E72C 90 02
        adc     #$06                            ; E72E 69 06
LE730:
        cmp     #$30                            ; E730 C9 30
        bne     LE739                           ; E732 D0 05
        bit     RES                             ; E734 24 00
        bmi     LE73F                           ; E736 30 07
        .byte   $2C                             ; E738 2C
LE739:
        sta     RES                             ; E739 85 00
        sta     L0100,x                         ; E73B 9D 00 01
        inx                                     ; E73E E8
LE73F:
        rts                                     ; E73F 60

; ----------------------------------------------------------------------------
SPC$_lfa:
        .addr   STR$_lfa                        ; E740 5F E7
; ----------------------------------------------------------------------------
SPC$_pfa:
        .byte   $02,$03,$94,$00,$0B             ; E742 02 03 94 00 0B
; ----------------------------------------------------------------------------
SPC$:
        .byte   "SPC$"                          ; E747 53 50 43 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E74B 80 83
; ----------------------------------------------------------------------------
        jsr     LD22E                           ; E74D 20 2E D2
LE750:
        jsr     LCF52                           ; E750 20 52 CF
        tay                                     ; E753 A8
        beq     LE75E                           ; E754 F0 08
LE756:
        lda     #$20                            ; E756 A9 20
        dey                                     ; E758 88
        sta     (FACC1M),y                      ; E759 91 61
        tya                                     ; E75B 98
        bne     LE756                           ; E75C D0 F8
LE75E:
        rts                                     ; E75E 60

; ----------------------------------------------------------------------------
STR$_lfa:
        .addr   ASC_lfa                         ; E75F 80 E7
; ----------------------------------------------------------------------------
STR$_pfa:
        .byte   $02,$03,$95,$00,$0B             ; E761 02 03 95 00 0B
; ----------------------------------------------------------------------------
STR$:
        .byte   "STR$"                          ; E766 53 54 52 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E76A 80 83
; ----------------------------------------------------------------------------
        jsr     LD23B                           ; E76C 20 3B D2
        XA1DEC                                  ; E76F 00 68
        ldx     #$FF                            ; E771 A2 FF
LE773:
        inx                                     ; E773 E8
        lda     L0100,x                         ; E774 BD 00 01
        bne     LE773                           ; E777 D0 FA
LE779:
        lda     #$00                            ; E779 A9 00
        ldy     #$01                            ; E77B A0 01
        jmp     LCF62                           ; E77D 4C 62 CF

; ----------------------------------------------------------------------------
ASC_lfa:
        .addr   LEN_lfa                         ; E780 9F E7
; ----------------------------------------------------------------------------
ASC_pfa:
        .byte   $02,$05,$96,$00,$0A             ; E782 02 05 96 00 0A
; ----------------------------------------------------------------------------
ASC:
        .byte   "ASC"                           ; E787 41 53 43
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E78A 80 83
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; E78C A5 60
        beq     LE794                           ; E78E F0 04
        ldy     #$00                            ; E790 A0 00
        lda     (FACC1M),y                      ; E792 B1 61
LE794:
        sta     FACC1M                          ; E794 85 61
        lda     #$00                            ; E796 A9 00
        sta     FACC1M+1                        ; E798 85 62
        lda     #$00                            ; E79A A9 00
        sta     $BA                             ; E79C 85 BA
        rts                                     ; E79E 60

; ----------------------------------------------------------------------------
LEN_lfa:
        .addr   VAL_lfa                         ; E79F B0 E7
; ----------------------------------------------------------------------------
LEN_pfa:
        .byte   $02,$05,$97,$00,$0A             ; E7A1 02 05 97 00 0A
; ----------------------------------------------------------------------------
LEN:
        .byte   "LEN"                           ; E7A6 4C 45 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E7A9 80 83
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; E7AB A5 60
        jmp     LE794                           ; E7AD 4C 94 E7

; ----------------------------------------------------------------------------
VAL_lfa:
        .addr   TRUE_lfa                        ; E7B0 DB E7
; ----------------------------------------------------------------------------
VAL_pfa:
        .byte   $02,$05,$98,$00,$0A             ; E7B2 02 05 98 00 0A
; ----------------------------------------------------------------------------
VAL:
        .byte   "VAL"                           ; E7B7 56 41 4C
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E7BA 80 83
; ----------------------------------------------------------------------------
LE7BC:
        ldy     FACC1E                          ; E7BC A4 60
        lda     (FACC1M),y                      ; E7BE B1 61
        pha                                     ; E7C0 48
        sty     TR0                             ; E7C1 84 0C
        lda     #$00                            ; E7C3 A9 00
        sta     (FACC1M),y                      ; E7C5 91 61
        lda     FACC1M                          ; E7C7 A5 61
        ldy     FACC1M+1                        ; E7C9 A4 62
        sta     TR1                             ; E7CB 85 0D
        sty     TR2                             ; E7CD 84 0E
        XDECA1                                  ; E7CF 00 69
        pla                                     ; E7D1 68
        ldy     TR0                             ; E7D2 A4 0C
        sta     (TR1),y                         ; E7D4 91 0D
        lda     #$40                            ; E7D6 A9 40
        sta     $BA                             ; E7D8 85 BA
        rts                                     ; E7DA 60

; ----------------------------------------------------------------------------
TRUE_lfa:
        .addr   FALSE_lfa                       ; E7DB 07 E8
; ----------------------------------------------------------------------------
TRUE_pfa:
        .byte   $02,$00,$99,$00,$0B             ; E7DD 02 00 99 00 0B
; ----------------------------------------------------------------------------
TRUE:
        .byte   "TRUE"                          ; E7E2 54 52 55 45
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E7E6 80 83
; ----------------------------------------------------------------------------
        lda     #$01                            ; E7E8 A9 01
        .byte   $2C                             ; E7EA 2C
LE7EB:
        lda     #$00                            ; E7EB A9 00
        ldy     #$00                            ; E7ED A0 00
LE7EF:
        sta     $8E                             ; E7EF 85 8E
        sty     $8F                             ; E7F1 84 8F
        jsr     LD40A                           ; E7F3 20 0A D4
        lda     $8F                             ; E7F6 A5 8F
        sta     FACC1M+1                        ; E7F8 85 62
        lda     $8E                             ; E7FA A5 8E
LE7FC:
        sta     FACC1M                          ; E7FC 85 61
        ora     FACC1M+1                        ; E7FE 05 62
        sta     FACC1E                          ; E800 85 60
        lda     #$00                            ; E802 A9 00
        sta     $BA                             ; E804 85 BA
        rts                                     ; E806 60

; ----------------------------------------------------------------------------
FALSE_lfa:
        .addr   PI_lfa                          ; E807 18 E8
; ----------------------------------------------------------------------------
FALSE_pfa:
        .byte   $02,$00,$9A,$00,$0C             ; E809 02 00 9A 00 0C
; ----------------------------------------------------------------------------
FALSE:
        .byte   "FALSE"                         ; E80E 46 41 4C 53 45
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; E813 80 03
; ----------------------------------------------------------------------------
        jsr     LE7EB                           ; E815 20 EB E7

; ----------------------------------------------------------------------------
PI_lfa:
        .addr   SGN_lfa                         ; E818 2D E8
; ----------------------------------------------------------------------------
PI_pfa:
        .byte   $02,$00,$9B,$00,$09             ; E81A 02 00 9B 00 09
; ----------------------------------------------------------------------------
PI:
        .byte   "PI"                            ; E81F 50 49
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E821 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; E823 20 0A D4
        XPI                                     ; E826 00 7C
        lda     #$40                            ; E828 A9 40
        sta     $BA                             ; E82A 85 BA
        rts                                     ; E82C 60

; ----------------------------------------------------------------------------
SGN_lfa:
        .addr   INT_lfa                         ; E82D 51 E8
; ----------------------------------------------------------------------------
SGN_pfa:
        .byte   $02,$02,$9C,$00,$0A             ; E82F 02 02 9C 00 0A
; ----------------------------------------------------------------------------
SGN:
        .byte   "SGN"                           ; E834 53 47 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E837 80 83
; ----------------------------------------------------------------------------
        jsr     LD23B                           ; E839 20 3B D2
        lda     FACC1E                          ; E83C A5 60
        beq     LE850                           ; E83E F0 10
        ldx     #$81                            ; E840 A2 81
        stx     FACC1E                          ; E842 86 60
        dex                                     ; E844 CA
        stx     FACC1M                          ; E845 86 61
        ldx     #$03                            ; E847 A2 03
        lda     #$00                            ; E849 A9 00
LE84B:
        sta     FACC1M,x                        ; E84B 95 61
        dex                                     ; E84D CA
        bne     LE84B                           ; E84E D0 FB
LE850:
        rts                                     ; E850 60

; ----------------------------------------------------------------------------
INT_lfa:
        .addr   KEY$_lfa                        ; E851 64 E8
; ----------------------------------------------------------------------------
INT_pfa:
        .byte   $02,$02,$9D,$00,$0A             ; E853 02 02 9D 00 0A
; ----------------------------------------------------------------------------
INT:
        .byte   "INT"                           ; E858 49 4E 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E85B 80 83
; ----------------------------------------------------------------------------
        lda     $BA                             ; E85D A5 BA
        beq     LE863                           ; E85F F0 02
        XINT                                    ; E861 00 7B
LE863:
        rts                                     ; E863 60

; ----------------------------------------------------------------------------
KEY$_lfa:
        .addr   RAND_lfa                        ; E864 8D E8
; ----------------------------------------------------------------------------
KEY$_pfa:
        .byte   $02,$01,$9E,$00,$0B             ; E866 02 01 9E 00 0B
; ----------------------------------------------------------------------------
KEY$:
        .byte   "KEY$"                          ; E86B 4B 45 59 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E86F 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; E871 20 0A D4
        XRD0                                    ; E874 00 08
        bcs     LE884                           ; E876 B0 0C
        pha                                     ; E878 48
        lda     #$01                            ; E879 A9 01
        jsr     LCF52                           ; E87B 20 52 CF
        ldy     #$00                            ; E87E A0 00
        pla                                     ; E880 68
        sta     (FACC1M),y                      ; E881 91 61
        rts                                     ; E883 60

; ----------------------------------------------------------------------------
LE884:
        lda     #$00                            ; E884 A9 00
        sta     FACC1E                          ; E886 85 60
        lda     #$80                            ; E888 A9 80
        sta     $BA                             ; E88A 85 BA
        rts                                     ; E88C 60

; ----------------------------------------------------------------------------
RAND_lfa:
        .addr   REM_lfa                         ; E88D 9F E8
; ----------------------------------------------------------------------------
RAND_pfa:
        .byte   $02,$02,$9F,$00,$0B             ; E88F 02 02 9F 00 0B
; ----------------------------------------------------------------------------
RAND:
        .byte   "RAND"                          ; E894 52 41 4E 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E898 80 83
; ----------------------------------------------------------------------------
        lda     #$7D                            ; E89A A9 7D
        jmp     TrigoFct                        ; E89C 4C 99 E5

; ----------------------------------------------------------------------------
REM_lfa:
        .addr   GOTO_lfa                        ; E89F AB E8
; ----------------------------------------------------------------------------
REM_pfa:
        .byte   $01,$00,$A0,$00,$0A             ; E8A1 01 00 A0 00 0A
; ----------------------------------------------------------------------------
REM:
        .byte   "REM"                           ; E8A6 52 45 4D
; ----------------------------------------------------------------------------
        .byte   $8E,$00                         ; E8A9 8E 00

; ----------------------------------------------------------------------------
GOTO_lfa:
        .addr   GOSUB_lfa                       ; E8AB B9 E8
; ----------------------------------------------------------------------------
GOTO_pfa:
        .byte   $01,$00,$A1,$00,$0B             ; E8AD 01 00 A1 00 0B
; ----------------------------------------------------------------------------
GOTO:
        .byte   "GOTO"                          ; E8B2 47 4F 54 4F
; ----------------------------------------------------------------------------
        .byte   $8D,$01                         ; E8B6 8D 01
; ----------------------------------------------------------------------------
        .byte   $4C                             ; E8B8 4C

; ----------------------------------------------------------------------------
GOSUB_lfa:
        .addr   CLS_lfa                         ; E8B9 D8 E8
; ----------------------------------------------------------------------------
GOSUB_pfa:
        .byte   $01,$00,$A2,$00,$0C             ; E8BB 01 00 A2 00 0C
; ----------------------------------------------------------------------------
GOSUB:
        .byte   "GOSUB"                         ; E8C0 47 4F 53 55 42
; ----------------------------------------------------------------------------
        .byte   $8D,$04                         ; E8C5 8D 04
; ----------------------------------------------------------------------------
        jsr     LE8CB                           ; E8C7 20 CB E8
        .byte   $20                             ; E8CA 20
LE8CB:
        inc     $C2                             ; E8CB E6 C2
        tsx                                     ; E8CD BA
        cpx     #$28                            ; E8CE E0 28
        bcc     Error_GOSUB                     ; E8D0 90 01
        rts                                     ; E8D2 60

; ----------------------------------------------------------------------------
; Erreur: trop de GOSUB
Error_GOSUB:
        ldx     #$1B                            ; E8D3 A2 1B
        jmp     Error_X                         ; E8D5 4C 7E D1

; ----------------------------------------------------------------------------
CLS_lfa:
        .addr   PRINT_lfa                       ; E8D8 E9 E8
; ----------------------------------------------------------------------------
CLS_pfa:
        .byte   $01,$00,$A3,$00,$0A             ; E8DA 01 00 A3 00 0A
; ----------------------------------------------------------------------------
CLS:
        .byte   "CLS"                           ; E8DF 43 4C 53
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; E8E2 80 83
; ----------------------------------------------------------------------------
        lda     #$0C                            ; E8E4 A9 0C
        XWR0                                    ; E8E6 00 10
        rts                                     ; E8E8 60

; ----------------------------------------------------------------------------
PRINT_lfa:
        .addr   LPRINT_lfa                      ; E8E9 AC E9
; ----------------------------------------------------------------------------
PRINT_pfa:
        .byte   $01,$00,$A4,$00,$0C             ; E8EB 01 00 A4 00 0C
; ----------------------------------------------------------------------------
PRINT:
        .byte   "PRINT"                         ; E8F0 50 52 49 4E 54
; ----------------------------------------------------------------------------
        .byte   $23,$C0,$12,$00                 ; E8F5 23 C0 12 00
; ----------------------------------------------------------------------------
LE8F9:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; E8F9 20 69 CA

LE8FC:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; E8FC 20 88 C6
        bne     LE908                           ; E8FF D0 07

LE901:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$25                            ; E901 A9 25
        jsr     LCA69                           ; E903 20 69 CA

LE906:
        clc                                     ; E906 18
LE907:
        rts                                     ; E907 60

; ----------------------------------------------------------------------------
LE908:
        cmp     #$3B                            ; E908 C9 3B
        bne     LE918                           ; E90A D0 0C
        lda     #$23                            ; E90C A9 23
        jsr     LE942                           ; E90E 20 42 E9
LE911:
        jsr     LE94A                           ; E911 20 4A E9
        bne     LE8FC                           ; E914 D0 E6
        beq     LE906                           ; E916 F0 EE
LE918:
        cmp     #$2C                            ; E918 C9 2C
        bne     LE925                           ; E91A D0 09
        lda     #$22                            ; E91C A9 22
        jsr     LE942                           ; E91E 20 42 E9
        bne     LE8FC                           ; E921 D0 D9
        beq     LE906                           ; E923 F0 E1
LE925:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0F                            ; E925 A2 0F
        jsr     LC676                           ; E927 20 76 C6
        bcs     LE907                           ; E92A B0 DB

        beq     LE911                           ; E92C F0 E3
        jsr     LE94A                           ; E92E 20 4A E9
        beq     LE901                           ; E931 F0 CE

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$04                            ; E933 A2 04
        jsr     LC676                           ; E935 20 76 C6
        bcs     LE907                           ; E938 B0 CD

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$24                            ; E93A A9 24
        jsr     LCA69                           ; E93C 20 69 CA

        jmp     LE8FC                           ; E93F 4C FC E8

; ----------------------------------------------------------------------------
LE942:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; E942 20 69 CA

        ; Passe au caractère suivant dans BUFEDT
        jsr     LC686                           ; E945 20 86 C6
        beq     LE956                           ; E948 F0 0C
LE94A:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; E94A 20 88 C6
        beq     LE956                           ; E94D F0 07

        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; E94F 20 50 CB
        bcc     LE957                           ; E952 90 03
        ; "ELSE"?
        cmp     #$B4                            ; E954 C9 B4
LE956:
        rts                                     ; E956 60

; ----------------------------------------------------------------------------
LE957:
        lda     #$01                            ; E957 A9 01
        rts                                     ; E959 60

; ----------------------------------------------------------------------------
LE95A:
        lda     #$01                            ; E95A A9 01
        jmp     L07EA                           ; E95C 4C EA 07

; ----------------------------------------------------------------------------
LE95F:
        lda     #$FF                            ; E95F A9 FF
        sta     $C3                             ; E961 85 C3
        lda     $BA                             ; E963 A5 BA
        bpl     LE978                           ; E965 10 11
        ldx     FACC1E                          ; E967 A6 60
LE969:
        ldy     #$00                            ; E969 A0 00
LE96B:
        txa                                     ; E96B 8A
        beq     LE977                           ; E96C F0 09
        lda     (FACC1M),y                      ; E96E B1 61
        jsr     L07EA                           ; E970 20 EA 07
        iny                                     ; E973 C8
        dex                                     ; E974 CA
        bne     LE96B                           ; E975 D0 F4
LE977:
        rts                                     ; E977 60

; ----------------------------------------------------------------------------
LE978:
        bne     LE9A0                           ; E978 D0 26
        lda     #$20                            ; E97A A9 20
        jsr     L07EA                           ; E97C 20 EA 07
        lda     #$00                            ; E97F A9 00
        sta     DEFAFF                          ; E981 85 14
        lda     #$00                            ; E983 A9 00
        ldy     #$01                            ; E985 A0 01
        sta     TR5                             ; E987 85 11
        sty     TR6                             ; E989 84 12
        lda     FACC1M                          ; E98B A5 61
        ldy     FACC1M+1                        ; E98D A4 62
        ldx     #$03                            ; E98F A2 03
        XBINDX                                  ; E991 00 28
        tya                                     ; E993 98
        tax                                     ; E994 AA
        inx                                     ; E995 E8
LE996:
        lda     #$00                            ; E996 A9 00
        ldy     #$01                            ; E998 A0 01
        sta     FACC1M                          ; E99A 85 61
        sty     FACC1M+1                        ; E99C 84 62
        bne     LE969                           ; E99E D0 C9
LE9A0:
        XA1DEC                                  ; E9A0 00 68
        ldx     #$FF                            ; E9A2 A2 FF
LE9A4:
        inx                                     ; E9A4 E8
        lda     L0100,x                         ; E9A5 BD 00 01
        bne     LE9A4                           ; E9A8 D0 FA
        beq     LE996                           ; E9AA F0 EA

; ----------------------------------------------------------------------------
LPRINT_lfa:
        .addr   SPRINT_lfa                      ; E9AC C1 E9
; ----------------------------------------------------------------------------
LPRINT_pfa:
        .byte   $01,$00,$A5,$00,$0D             ; E9AE 01 00 A5 00 0D
; ----------------------------------------------------------------------------
LPRINT:
        .byte   "LPRINT"                        ; E9B3 4C 50 52 49 4E 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0F,$00                     ; E9B9 C0 0F 00
; ----------------------------------------------------------------------------
        lda     #$29                            ; E9BC A9 29
        jmp     LE8F9                           ; E9BE 4C F9 E8

; ----------------------------------------------------------------------------
SPRINT_lfa:
        .addr   MPRINT_lfa                      ; E9C1 D6 E9
; ----------------------------------------------------------------------------
SPRINT_pfa:
        .byte   $01,$00,$A6,$00,$0D             ; E9C3 01 00 A6 00 0D
; ----------------------------------------------------------------------------
SPRINT:
        .byte   "SPRINT"                        ; E9C8 53 50 52 49 4E 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0F,$00                     ; E9CE C0 0F 00
; ----------------------------------------------------------------------------
        lda     #$27                            ; E9D1 A9 27
        jmp     LE8F9                           ; E9D3 4C F9 E8

; ----------------------------------------------------------------------------
MPRINT_lfa:
        .addr   GET_lfa                         ; E9D6 EB E9
; ----------------------------------------------------------------------------
MPRINT_pfa:
        .byte   $01,$00,$A7,$00,$0D             ; E9D8 01 00 A7 00 0D
; ----------------------------------------------------------------------------
MPRINT:
        .byte   "MPRINT"                        ; E9DD 4D 50 52 49 4E 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0F,$00                     ; E9E3 C0 0F 00
; ----------------------------------------------------------------------------
        lda     #$28                            ; E9E6 A9 28
        jmp     LE8F9                           ; E9E8 4C F9 E8

; ----------------------------------------------------------------------------
GET_lfa:
        .addr   INPUT'_lfa                      ; E9EB 11 EA
; ----------------------------------------------------------------------------
GET_pfa:
        .byte   $01,$00,$A8,$00,$0A             ; E9ED 01 00 A8 00 0A
; ----------------------------------------------------------------------------
GET:
        .byte   "GET"                           ; E9F2 47 45 54
; ----------------------------------------------------------------------------
        .byte   $23,$25,$EF,$83                 ; E9F5 23 25 EF 83
; ----------------------------------------------------------------------------
        lda     #$01                            ; E9F9 A9 01
        jsr     LCF52                           ; E9FB 20 52 CF
        lda     L07EA+1                         ; E9FE AD EB 07
        sec                                     ; EA01 38
        sbc     #$04                            ; EA02 E9 04
        sta     L07EA+1                         ; EA04 8D EB 07
        jsr     L07EA                           ; EA07 20 EA 07
        ldy     #$00                            ; EA0A A0 00
        sta     (FACC1M),y                      ; EA0C 91 61
        jmp     LD28F                           ; EA0E 4C 8F D2

; ----------------------------------------------------------------------------
INPUT'_lfa:
        .addr   null_lfa                        ; EA11 7A EA
; ----------------------------------------------------------------------------
INPUT'_pfa:
        .byte   $01,$00,$A9,$00,$0C             ; EA13 01 00 A9 00 0C
; ----------------------------------------------------------------------------
INPUT':
        .byte   "INPUT'"                        ; EA18 49 4E 50 55 54 27
; ----------------------------------------------------------------------------
        .byte   $EF,$83                         ; EA1E EF 83
; ----------------------------------------------------------------------------
        ldx     #$00                            ; EA20 A2 00
LEA22:
        XRDW0                                   ; EA22 00 0C
        cmp     #$03                            ; EA24 C9 03
        beq     LEA42                           ; EA26 F0 1A
        cmp     #$0D                            ; EA28 C9 0D
        beq     LEA56                           ; EA2A F0 2A
        cmp     #$7F                            ; EA2C C9 7F
        bne     LEA45                           ; EA2E D0 15
        txa                                     ; EA30 8A
        beq     LEA22                           ; EA31 F0 EF
        lda     #$08                            ; EA33 A9 08
        XWR0                                    ; EA35 00 10
        jsr     Print0_SPACE                    ; EA37 20 DB D5
        lda     #$08                            ; EA3A A9 08
        XWR0                                    ; EA3C 00 10
        dex                                     ; EA3E CA
        jmp     LEA22                           ; EA3F 4C 22 EA

; ----------------------------------------------------------------------------
LEA42:
        jmp     LDFFC                           ; EA42 4C FC DF

; ----------------------------------------------------------------------------
LEA45:
        cmp     #$20                            ; EA45 C9 20
        bcc     LEA51                           ; EA47 90 08
        cpx     #$6E                            ; EA49 E0 6E
        beq     LEA22                           ; EA4B F0 D5
        sta     BUFEDT,x                        ; EA4D 9D 90 05
        inx                                     ; EA50 E8
LEA51:
        XWR0                                    ; EA51 00 10
        jmp     LEA22                           ; EA53 4C 22 EA

; ----------------------------------------------------------------------------
LEA56:
        XCRLF                                   ; EA56 00 25
        lda     #$90                            ; EA58 A9 90
        ldy     #$05                            ; EA5A A0 05
        stx     FACC1E                          ; EA5C 86 60
        sta     FACC1M                          ; EA5E 85 61
        sty     FACC1M+1                        ; EA60 84 62
        ldy     #$02                            ; EA62 A0 02
        lda     ($BC),y                         ; EA64 B1 BC
        cmp     #$09                            ; EA66 C9 09
        beq     LEA74                           ; EA68 F0 0A
        cmp     #$0D                            ; EA6A C9 0D
        beq     LEA74                           ; EA6C F0 06
        jsr     LCF5C                           ; EA6E 20 5C CF
        jmp     LD28F                           ; EA71 4C 8F D2

; ----------------------------------------------------------------------------
LEA74:
        jsr     LE7BC                           ; EA74 20 BC E7
        jmp     LD28F                           ; EA77 4C 8F D2

; ----------------------------------------------------------------------------
null_lfa:
        .addr   IF_lfa                          ; EA7A 87 EA
; ----------------------------------------------------------------------------
null_pfa:
        .byte   $01,$00,$AA,$00,$08             ; EA7C 01 00 AA 00 08
; ----------------------------------------------------------------------------
null:
        .byte   $00                             ; EA81 00
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; EA82 80 03
; ----------------------------------------------------------------------------
        jsr     LD28F                           ; EA84 20 8F D2

; ----------------------------------------------------------------------------
IF_lfa:
        .addr   ERRGOTO_lfa                     ; EA87 98 EA
; ----------------------------------------------------------------------------
IF_pfa:
        .byte   $01,$00,$AB,$00,$09             ; EA89 01 00 AB 00 09
; ----------------------------------------------------------------------------
IF:
        .byte   "IF"                            ; EA8E 49 46
; ----------------------------------------------------------------------------
        .byte   $24,$B4,$05                     ; EA90 24 B4 05
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; EA93 A5 60
        bne     ERRGOTO_pfa                     ; EA95 D0 03
        .byte   $4C                             ; EA97 4C

; ----------------------------------------------------------------------------
ERRGOTO_lfa:
        .addr   MID$_lfa                        ; EA98 CB EA
; ----------------------------------------------------------------------------
ERRGOTO_pfa:
        .byte   $01,$00,$AC,$00,$0E             ; EA9A 01 00 AC 00 0E
; ----------------------------------------------------------------------------
ERRGOTO:
        .byte   "ERRGOTO"                       ; EA9F 45 52 52 47 4F 54 4F
; ----------------------------------------------------------------------------
        .byte   $8D,$83                         ; EAA6 8D 83
; ----------------------------------------------------------------------------
        clc                                     ; EAA8 18
        pla                                     ; EAA9 68
        sta     RES                             ; EAAA 85 00
        adc     #$02                            ; EAAC 69 02
        tax                                     ; EAAE AA
        pla                                     ; EAAF 68
        sta     RES+1                           ; EAB0 85 01
        adc     #$00                            ; EAB2 69 00
        pha                                     ; EAB4 48
        txa                                     ; EAB5 8A
        pha                                     ; EAB6 48
        ldy     #$01                            ; EAB7 A0 01
        lda     (RES),y                         ; EAB9 B1 00
        sta     errgotonl                       ; EABB 8D BA 07
        iny                                     ; EABE C8
        lda     (RES),y                         ; EABF B1 00
        sta     errgotonl+1                     ; EAC1 8D BB 07
        lda     fFlags                          ; EAC4 A5 8C
        ora     #$04                            ; EAC6 09 04
        sta     fFlags                          ; EAC8 85 8C
        rts                                     ; EACA 60

; ----------------------------------------------------------------------------
MID$_lfa:
        .addr   LEFT$_lfa                       ; EACB 1F EB
; ----------------------------------------------------------------------------
MID$_pfa:
        .byte   $02,$07,$AD,$00,$0B             ; EACD 02 07 AD 00 0B
; ----------------------------------------------------------------------------
MID$:
        .byte   "MID$"                          ; EAD2 4D 49 44 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EAD6 80 83
; ----------------------------------------------------------------------------
        jsr     LEB45                           ; EAD8 20 45 EB
        ldx     #$00                            ; EADB A2 00
        clc                                     ; EADD 18
        lda     FACC1E                          ; EADE A5 60
        adc     #$02                            ; EAE0 69 02
        sbc     FACC1M+2                        ; EAE2 E5 63
        bcc     LEB3A                           ; EAE4 90 54
        cmp     FACC1M+3                        ; EAE6 C5 64
        bcc     LEAEC                           ; EAE8 90 02
        lda     FACC1M+3                        ; EAEA A5 64
LEAEC:
        tax                                     ; EAEC AA
        dec     FACC1M+2                        ; EAED C6 63
        lda     FACC1M+2                        ; EAEF A5 63
        jmp     LEB3A                           ; EAF1 4C 3A EB

; ----------------------------------------------------------------------------
LEAF4:
        pla                                     ; EAF4 68
        tax                                     ; EAF5 AA
        pla                                     ; EAF6 68
        tay                                     ; EAF7 A8
        lda     #$FF                            ; EAF8 A9 FF
        sta     $C3                             ; EAFA 85 C3
        lda     FACC1E                          ; EAFC A5 60
        pha                                     ; EAFE 48
        lda     FACC1M                          ; EAFF A5 61
        pha                                     ; EB01 48
        lda     FACC1M+1                        ; EB02 A5 62
        pha                                     ; EB04 48
        tya                                     ; EB05 98
        pha                                     ; EB06 48
        txa                                     ; EB07 8A
        pha                                     ; EB08 48
        rts                                     ; EB09 60

; ----------------------------------------------------------------------------
LEB0A:
        pla                                     ; EB0A 68
        sta     RES                             ; EB0B 85 00
        pla                                     ; EB0D 68
        sta     RES+1                           ; EB0E 85 01
        jsr     LD22E                           ; EB10 20 2E D2
        pha                                     ; EB13 48
        lda     #$FF                            ; EB14 A9 FF
        sta     $C3                             ; EB16 85 C3
        lda     RES+1                           ; EB18 A5 01
        pha                                     ; EB1A 48
        lda     RES                             ; EB1B A5 00
        pha                                     ; EB1D 48
        rts                                     ; EB1E 60

; ----------------------------------------------------------------------------
LEFT$_lfa:
        .addr   RIGHT$_lfa                      ; EB1F 7B EB
; ----------------------------------------------------------------------------
LEFT$_pfa:
        .byte   $02,$06,$AE,$00,$0C             ; EB21 02 06 AE 00 0C
; ----------------------------------------------------------------------------
LEFT$:
        .byte   "LEFT$"                         ; EB26 4C 45 46 54 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EB2B 80 83
; ----------------------------------------------------------------------------
        jsr     LEB47                           ; EB2D 20 47 EB
        ldx     FACC1M+2                        ; EB30 A6 63
        cpx     FACC1E                          ; EB32 E4 60
        bcc     LEB38                           ; EB34 90 02
LEB36:
        ldx     FACC1E                          ; EB36 A6 60
LEB38:
        lda     #$00                            ; EB38 A9 00
LEB3A:
        clc                                     ; EB3A 18
        adc     FACC1M                          ; EB3B 65 61
        ldy     FACC1M+1                        ; EB3D A4 62
        bcc     LEB42                           ; EB3F 90 01
        iny                                     ; EB41 C8
LEB42:
        jmp     LCF62                           ; EB42 4C 62 CF

; ----------------------------------------------------------------------------
LEB45:
        sec                                     ; EB45 38
        .byte   $24                             ; EB46 24
LEB47:
        clc                                     ; EB47 18
        pla                                     ; EB48 68
        sta     RESB                            ; EB49 85 02
        pla                                     ; EB4B 68
        sta     RESB+1                          ; EB4C 85 03
        pla                                     ; EB4E 68
        sta     RES+1                           ; EB4F 85 01
        pla                                     ; EB51 68
        sta     RES                             ; EB52 85 00
        bcc     LEB59                           ; EB54 90 03
        pla                                     ; EB56 68
        sta     FACC1M+2                        ; EB57 85 63
LEB59:
        php                                     ; EB59 08
        jsr     LD22E                           ; EB5A 20 2E D2
        plp                                     ; EB5D 28
        bcc     LEB63                           ; EB5E 90 03
        sta     FACC1M+3                        ; EB60 85 64
        .byte   $2C                             ; EB62 2C
LEB63:
        sta     FACC1M+2                        ; EB63 85 63
        pla                                     ; EB65 68
        sta     FACC1M+1                        ; EB66 85 62
        pla                                     ; EB68 68
        sta     FACC1M                          ; EB69 85 61
        pla                                     ; EB6B 68
        sta     FACC1E                          ; EB6C 85 60
        lda     RES                             ; EB6E A5 00
        pha                                     ; EB70 48
        lda     RES+1                           ; EB71 A5 01
        pha                                     ; EB73 48
        lda     RESB+1                          ; EB74 A5 03
        pha                                     ; EB76 48
        lda     RESB                            ; EB77 A5 02
        pha                                     ; EB79 48
        rts                                     ; EB7A 60

; ----------------------------------------------------------------------------
RIGHT$_lfa:
        .addr   HIRES_lfa                       ; EB7B C0 EB
; ----------------------------------------------------------------------------
RIGHT$_pfa:
        .byte   $02,$06,$AF,$00,$0D             ; EB7D 02 06 AF 00 0D
; ----------------------------------------------------------------------------
RIGHT$:
        .byte   "RIGHT$"                        ; EB82 52 49 47 48 54 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EB88 80 83
; ----------------------------------------------------------------------------
        jsr     LEB47                           ; EB8A 20 47 EB
        sec                                     ; EB8D 38
        lda     FACC1E                          ; EB8E A5 60
        sbc     FACC1M+2                        ; EB90 E5 63
        bcc     LEB36                           ; EB92 90 A2
        ldx     FACC1M+2                        ; EB94 A6 63
        bcs     LEB3A                           ; EB96 B0 A2

; ----------------------------------------------------------------------------
; Paramètres de certaines instructions
InstParam_table:
        .byte   "SE"                            ; EB98 53 45
        .byte   $D4                             ; EB9A D4
        .byte   "OF"                            ; EB9B 4F 46
        .byte   $C6                             ; EB9D C6
        .byte   "T"                             ; EB9E 54
        .byte   $CF                             ; EB9F CF
        .byte   "STE"                           ; EBA0 53 54 45
        .byte   $D0                             ; EBA3 D0
        .byte   "ELS"                           ; EBA4 45 4C 53
        .byte   $C5                             ; EBA7 C5
        .byte   "THE"                           ; EBA8 54 48 45
        .byte   $CE                             ; EBAB CE
        .byte   "NO"                            ; EBAC 4E 4F
        .byte   $D4                             ; EBAE D4
        .byte   "USIN"                          ; EBAF 55 53 49 4E
        .byte   $C7                             ; EBB3 C7
        .byte   "A"                             ; EBB4 41
        .byte   $FF                             ; EBB5 FF
        .byte   "TA"                            ; EBB6 54 41
        .byte   $C2                             ; EBB8 C2
        .byte   "A"                             ; EBB9 41
        .byte   $FF                             ; EBBA FF
        .byte   "AUT"                           ; EBBB 41 55 54
        .byte   $CF,$00                         ; EBBE CF 00

; ----------------------------------------------------------------------------
HIRES_lfa:
        .addr   TEXT_lfa                        ; EBC0 D4 EB
; ----------------------------------------------------------------------------
HIRES_pfa:
        .byte   $01,$00,$C0,$00,$0C             ; EBC2 01 00 C0 00 0C
; ----------------------------------------------------------------------------
HIRES:
        .byte   "HIRES"                         ; EBC7 48 49 52 45 53
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EBCC 80 83
; ----------------------------------------------------------------------------
        jsr     LD149                           ; EBCE 20 49 D1
        XHIRES                                  ; EBD1 00 1A
        rts                                     ; EBD3 60

; ----------------------------------------------------------------------------
TEXT_lfa:
        .addr   LIST_lfa                        ; EBD4 E3 EB
; ----------------------------------------------------------------------------
TEXT_pfa:
        .byte   $01,$00,$C0,$01,$0B             ; EBD6 01 00 C0 01 0B
; ----------------------------------------------------------------------------
TEXT:
        .byte   "TEXT"                          ; EBDB 54 45 58 54
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; EBDF 80 02
; ----------------------------------------------------------------------------
        XTEXT                                   ; EBE1 00 19

; ----------------------------------------------------------------------------
LIST_lfa:
        .addr   TRACE_lfa                       ; EBE3 27 EC
; ----------------------------------------------------------------------------
LIST_pfa:
        .byte   $01,$00,$C0,$02,$0B             ; EBE5 01 00 C0 02 0B
; ----------------------------------------------------------------------------
LIST:
        .byte   "LIST"                          ; EBEA 4C 49 53 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0D,$00                     ; EBEE C0 0D 00
; ----------------------------------------------------------------------------
        lda     #$26                            ; EBF1 A9 26
LEBF3:
        pha                                     ; EBF3 48
        jsr     LEC04                           ; EBF4 20 04 EC
        pla                                     ; EBF7 68
        bcs     LEC03                           ; EBF8 B0 09

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; EBFA 20 69 CA

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$2B                            ; EBFD A9 2B
        jsr     LCA69                           ; EBFF 20 69 CA

LEC02:
        clc                                     ; EC02 18
LEC03:
        rts                                     ; EC03 60

; ----------------------------------------------------------------------------
LEC04:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3E                            ; EC04 A9 3E
        jsr     LCA69                           ; EC06 20 69 CA

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; EC09 20 88 C6
        beq     LEC02                           ; EC0C F0 F4
        jsr     LEC1F                           ; EC0E 20 1F EC
        bcs     LEC03                           ; EC11 B0 F0

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; EC13 20 88 C6
        beq     LEC02                           ; EC16 F0 EA

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$09                            ; EC18 A2 09
        jsr     LC676                           ; EC1A 20 76 C6
        bcs     LEC03                           ; EC1D B0 E4

LEC1F:
        jsr     LC909                           ; EC1F 20 09 C9

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0D                            ; EC22 A2 0D
        jmp     LC676                           ; EC24 4C 76 C6

; ----------------------------------------------------------------------------
TRACE_lfa:
        .addr   WORD_lfa                        ; EC27 53 EC
; ----------------------------------------------------------------------------
TRACE_pfa:
        .byte   $01,$00,$C0,$03,$0C             ; EC29 01 00 C0 03 0C
; ----------------------------------------------------------------------------
TRACE:
        .byte   "TRACE"                         ; EC2E 54 52 41 43 45
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; EC33 90 83
; ----------------------------------------------------------------------------
        php                                     ; EC35 08
        asl     fFlags                          ; EC36 06 8C
        plp                                     ; EC38 28
        ror     fFlags                          ; EC39 66 8C
        bpl     LEC4E                           ; EC3B 10 11
        lda     #$8B                            ; EC3D A9 8B
        XCL3                                    ; EC3F 00 07
        lda     #$62                            ; EC41 A9 62
        ldy     #$02                            ; EC43 A0 02
        ldx     #$03                            ; EC45 A2 03
        XSCRSE                                  ; EC47 00 36
        lda     #$8B                            ; EC49 A9 8B
        XOP3                                    ; EC4B 00 03
        rts                                     ; EC4D 60

; ----------------------------------------------------------------------------
LEC4E:
        lda     #$8B                            ; EC4E A9 8B
        XCL3                                    ; EC50 00 07
        rts                                     ; EC52 60

; ----------------------------------------------------------------------------
WORD_lfa:
        .addr   NEW_lfa                         ; EC53 AA EC
; ----------------------------------------------------------------------------
WORD_pfa:
        .byte   $01,$00,$C0,$04,$0B             ; EC55 01 00 C0 04 0B
; ----------------------------------------------------------------------------
WORD:
        .byte   "WORD"                          ; EC5A 57 4F 52 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EC5E 80 83
; ----------------------------------------------------------------------------
        lda     #$01                            ; EC60 A9 01
LEC62:
        ; $94: Type de mot clé à chercher
        sta     $94                             ; EC62 85 94
        ldx     #$B9                            ; EC64 A2 B9
        lda     #$DF                            ; EC66 A9 DF

LEC68:
        ; $92-93: Adrresse d'une entrée dans la table
        stx     $92                             ; EC68 86 92
        sta     $93                             ; EC6A 85 93

        ; Si le type du mmot clé ne correspond pas à calui recherché -> on passe à l'instructioon suivante
        ldy     #$02                            ; EC6C A0 02
        lda     ($92),y                         ; EC6E B1 92
        cmp     $94                             ; EC70 C5 94
        bne     LEC96                           ; EC72 D0 22

        ; On a trouvé une instruction avec le bon type

        ; Si type != $01 ->
        cmp     #$01                            ; EC74 C9 01
        bne     LEC7D                           ; EC76 D0 05

        ; Si type == $01 (commande) et octet suivant le type != $00 ($01: cas de FOR et NEXT uniquement) -> on passe à l'entrée suivante
        iny                                     ; EC78 C8
        lda     ($92),y                         ; EC79 B1 92
        bne     LEC96                           ; EC7B D0 19

LEC7D:
        ; Type != Commande ou (Type == Commande et octet suivant == $00 (ie toutes les commandes sauf FOR et NEXT) )
        ; Calcule la longueur du nom de l'instruction
        sec                                     ; EC7D 38
        ldy     #$06                            ; EC7E A0 06
        lda     ($92),y                         ; EC80 B1 92
        sbc     #$07                            ; EC82 E9 07
        tax                                     ; EC84 AA
        beq     LEC96                           ; EC85 F0 0F

LEC87:
        ; Affiche le nom de l'instructon
        iny                                     ; EC87 C8
        lda     ($92),y                         ; EC88 B1 92
        XWR0                                    ; EC8A 00 10
        dex                                     ; EC8C CA
        bne     LEC87                           ; EC8D D0 F8

        lda     #$01                            ; EC8F A9 01
        XWR0                                    ; EC91 00 10

        ; Teste si on a appuyé sur CTRL+C ou ESC (retour à la procédure appelante si oui)
        jsr     LF1C9                           ; EC93 20 C9 F1

LEC96:
        ; Passe à l'entrée suivante de la table et boucle
        ; tant qu'on n'est pas à la fin de la table
        clc                                     ; EC96 18
        ldy     #$00                            ; EC97 A0 00
        lda     ($92),y                         ; EC99 B1 92
        tax                                     ; EC9B AA
        iny                                     ; EC9C C8
        lda     ($92),y                         ; EC9D B1 92
        bne     LEC68                           ; EC9F D0 C7

        ; Fin de la liste, -> CR+LF
        lda     #$0D                            ; ECA1 A9 0D
        XWR0                                    ; ECA3 00 10
        lda     #$0A                            ; ECA5 A9 0A
        XWR0                                    ; ECA7 00 10
        rts                                     ; ECA9 60

; ----------------------------------------------------------------------------
NEW_lfa:
        .addr   RUN_lfa                         ; ECAA BC EC
; ----------------------------------------------------------------------------
NEW_pfa:
        .byte   $01,$00,$C0,$05,$0A             ; ECAC 01 00 C0 05 0A
; ----------------------------------------------------------------------------
NEW:
        .byte   "NEW"                           ; ECB1 4E 45 57
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; ECB4 80 83
; ----------------------------------------------------------------------------
        jsr     LC384                           ; ECB6 20 84 C3
        jmp     LC068                           ; ECB9 4C 68 C0

; ----------------------------------------------------------------------------
RUN_lfa:
        .addr   OUPS_lfa                        ; ECBC E7 EC
; ----------------------------------------------------------------------------
RUN_pfa:
        .byte   $01,$00,$C0,$07,$0A             ; ECBE 01 00 C0 07 0A
; ----------------------------------------------------------------------------
RUN:
        .byte   "RUN"                           ; ECC3 52 55 4E
; ----------------------------------------------------------------------------
        .byte   $C0,$19,$83                     ; ECC6 C0 19 83
; ----------------------------------------------------------------------------
        ; CLEAR
        jsr     LFDA5                           ; ECC9 20 A5 FD

        lda     FACC1M                          ; ECCC A5 61
        ldy     FACC1M+1                        ; ECCE A4 62
        jsr     LD0ED                           ; ECD0 20 ED D0
        jmp     (ptr00BE)                       ; ECD3 6C BE 00

; ----------------------------------------------------------------------------
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$3E                            ; ECD6 A9 3E
        jsr     LCA69                           ; ECD8 20 69 CA

        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; ECDB 20 88 C6
        beq     LECE5                           ; ECDE F0 05

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0D                            ; ECE0 A2 0D
        jmp     LC676                           ; ECE2 4C 76 C6

; ----------------------------------------------------------------------------
LECE5:
        clc                                     ; ECE5 18
        rts                                     ; ECE6 60

; ----------------------------------------------------------------------------
OUPS_lfa:
        .addr   HELP_lfa                        ; ECE7 F6 EC
; ----------------------------------------------------------------------------
OUPS_pfa:
        .byte   $01,$00,$C0,$08,$0B             ; ECE9 01 00 C0 08 0B
; ----------------------------------------------------------------------------
OUPS:
        .byte   "OUPS"                          ; ECEE 4F 55 50 53
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; ECF2 80 02
; ----------------------------------------------------------------------------
        XOUPS                                   ; ECF4 00 42

; ----------------------------------------------------------------------------
HELP_lfa:
        .addr   POKE_lfa                        ; ECF6 08 ED
; ----------------------------------------------------------------------------
HELP_pfa:
        .byte   $01,$00,$C0,$09,$0B             ; ECF8 01 00 C0 09 0B
; ----------------------------------------------------------------------------
HELP:
        .byte   "HELP"                          ; ECFD 48 45 4C 50
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; ED01 80 83
; ----------------------------------------------------------------------------
LED03:
        ldx     #$00                            ; ED03 A2 00
        jmp     PrintErrMsg4                    ; ED05 4C 87 D5

; ----------------------------------------------------------------------------
POKE_lfa:
        .addr   DOKE_lfa                        ; ED08 32 ED
; ----------------------------------------------------------------------------
POKE_pfa:
        .byte   $01,$00,$C0,$0A,$0B             ; ED0A 01 00 C0 0A 0B
; ----------------------------------------------------------------------------
POKE:
        .byte   "POKE"                          ; ED0F 50 4F 4B 45
; ----------------------------------------------------------------------------
        .byte   $01,$84,$83                     ; ED13 01 84 83
; ----------------------------------------------------------------------------
        jsr     LD481                           ; ED16 20 81 D4
        lda     $BA                             ; ED19 A5 BA
        bmi     POKE_str                        ; ED1B 30 08
        jsr     GetByte                         ; ED1D 20 4F D4
        ldy     #$00                            ; ED20 A0 00
        sta     ($9E),y                         ; ED22 91 9E
LED24:
        rts                                     ; ED24 60

; ----------------------------------------------------------------------------
; POKE "chaine"
POKE_str:
        ldy     FACC1E                          ; ED25 A4 60
LED27:
        tya                                     ; ED27 98
        beq     LED24                           ; ED28 F0 FA
        dey                                     ; ED2A 88
        lda     (FACC1M),y                      ; ED2B B1 61
        sta     ($9E),y                         ; ED2D 91 9E
        jmp     LED27                           ; ED2F 4C 27 ED

; ----------------------------------------------------------------------------
DOKE_lfa:
        .addr   CALL_lfa                        ; ED32 50 ED
; ----------------------------------------------------------------------------
DOKE_pfa:
        .byte   $01,$00,$C0,$0B,$0B             ; ED34 01 00 C0 0B 0B
; ----------------------------------------------------------------------------
DOKE:
        .byte   "DOKE"                          ; ED39 44 4F 4B 45
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; ED3D 01 81 83
; ----------------------------------------------------------------------------
        jsr     LD481                           ; ED40 20 81 D4
        jsr     GetWord                         ; ED43 20 84 D4
        ldx     #$00                            ; ED46 A2 00
        sta     ($9E,x)                         ; ED48 81 9E
        tya                                     ; ED4A 98
        ldy     #$01                            ; ED4B A0 01
        sta     ($9E),y                         ; ED4D 91 9E
        rts                                     ; ED4F 60

; ----------------------------------------------------------------------------
CALL_lfa:
        .addr   PING_lfa                        ; ED50 63 ED
; ----------------------------------------------------------------------------
CALL_pfa:
        .byte   $01,$00,$C0,$0C,$0B             ; ED52 01 00 C0 0C 0B
; ----------------------------------------------------------------------------
CALL:
        .byte   "CALL"                          ; ED57 43 41 4C 4C
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; ED5B 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; ED5D 20 84 D4
        jmp     (FACC1M)                        ; ED60 6C 61 00

; ----------------------------------------------------------------------------
PING_lfa:
        .addr   SHOOT_lfa                       ; ED63 72 ED
; ----------------------------------------------------------------------------
PING_pfa:
        .byte   $01,$00,$C0,$0F,$0B             ; ED65 01 00 C0 0F 0B
; ----------------------------------------------------------------------------
PING:
        .byte   "PING"                          ; ED6A 50 49 4E 47
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; ED6E 80 02
; ----------------------------------------------------------------------------
        XSHOOT                                  ; ED70 00 9D

; ----------------------------------------------------------------------------
SHOOT_lfa:
        .addr   EXPLODE_lfa                     ; ED72 82 ED
; ----------------------------------------------------------------------------
SHOOT_pfa:
        .byte   $01,$00,$C0,$10,$0C             ; ED74 01 00 C0 10 0C
; ----------------------------------------------------------------------------
SHOOT:
        .byte   "SHOOT"                         ; ED79 53 48 4F 4F 54
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; ED7E 80 02
; ----------------------------------------------------------------------------
        XSHOOT                                  ; ED80 00 47

; ----------------------------------------------------------------------------
EXPLODE_lfa:
        .addr   ZAP_lfa                         ; ED82 94 ED
; ----------------------------------------------------------------------------
EXPLODE_pfa:
        .byte   $01,$00,$C0,$11,$0E             ; ED84 01 00 C0 11 0E
; ----------------------------------------------------------------------------
EXPLODE:
        .byte   "EXPLODE"                       ; ED89 45 58 50 4C 4F 44 45
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; ED90 80 02
; ----------------------------------------------------------------------------
        XEXPLO                                  ; ED92 00 9C

; ----------------------------------------------------------------------------
ZAP_lfa:
        .addr   NMI_lfa                         ; ED94 A2 ED
; ----------------------------------------------------------------------------
ZAP_pfa:
        .byte   $01,$00,$C0,$12,$0A             ; ED96 01 00 C0 12 0A
; ----------------------------------------------------------------------------
ZAP:
        .byte   "ZAP"                           ; ED9B 5A 41 50
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; ED9E 80 02
; ----------------------------------------------------------------------------
        XZAP                                    ; EDA0 00 46

; ----------------------------------------------------------------------------
NMI_lfa:
        .addr   RESET_lfa                       ; EDA2 B1 ED
; ----------------------------------------------------------------------------
NMI_pfa:
        .byte   $01,$00,$C0,$13,$0A             ; EDA4 01 00 C0 13 0A
; ----------------------------------------------------------------------------
NMI:
        .byte   "NMI"                           ; EDA9 4E 4D 49
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; EDAC 80 03
; ----------------------------------------------------------------------------
        jsr     LEDC2                           ; EDAE 20 C2 ED

; ----------------------------------------------------------------------------
RESET_lfa:
        .addr   WIDTH_lfa                       ; EDB1 D5 ED
; ----------------------------------------------------------------------------
RESET_pfa:
        .byte   $01,$00,$C0,$14,$0C             ; EDB3 01 00 C0 14 0C
; ----------------------------------------------------------------------------
RESET:
        .byte   "RESET"                         ; EDB8 52 45 53 45 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EDBD 80 83
; ----------------------------------------------------------------------------
        lsr     virq                            ; EDBF 4E FA 02
LEDC2:
        lda     #$00                            ; EDC2 A9 00
        ldy     #$C0                            ; EDC4 A0 C0
        sta     VEXBNK+1                        ; EDC6 8D 15 04
        sty     VEXBNK+2                        ; EDC9 8C 16 04
        lda     #$07                            ; EDCC A9 07
        sta     BNKCID                          ; EDCE 8D 17 04
        sei                                     ; EDD1 78
        jmp     EXBNK                           ; EDD2 4C 0C 04

; ----------------------------------------------------------------------------
WIDTH_lfa:
        .addr   LWIDTH_lfa                      ; EDD5 F0 ED
; ----------------------------------------------------------------------------
WIDTH_pfa:
        .byte   $01,$00,$C0,$15,$0C             ; EDD7 01 00 C0 15 0C
; ----------------------------------------------------------------------------
WIDTH:
        .byte   "WIDTH"                         ; EDDC 57 49 44 54 48
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EDE1 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; EDE3 20 4F D4
        clc                                     ; EDE6 18
        adc     SCRDX                           ; EDE7 6D 28 02
        adc     #$FF                            ; EDEA 69 FF
        sta     SCRFX                           ; EDEC 8D 2C 02
        rts                                     ; EDEF 60

; ----------------------------------------------------------------------------
LWIDTH_lfa:
        .addr   GRAB_lfa                        ; EDF0 08 EE
; ----------------------------------------------------------------------------
LWIDTH_pfa:
        .byte   $01,$00,$C0,$16,$0D             ; EDF2 01 00 C0 16 0D
; ----------------------------------------------------------------------------
LWIDTH:
        .byte   "LWIDTH"                        ; EDF7 4C 57 49 44 54 48
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EDFD 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; EDFF 20 4F D4
        sta     LPRFX                           ; EE02 8D 88 02
        XLPCRL                                  ; EE05 00 49
        rts                                     ; EE07 60

; ----------------------------------------------------------------------------
GRAB_lfa:
        .addr   RELEASE_lfa                     ; EE08 19 EE
; ----------------------------------------------------------------------------
GRAB_pfa:
        .byte   $01,$00,$C0,$17,$0B             ; EE0A 01 00 C0 17 0B
; ----------------------------------------------------------------------------
GRAB:
        .byte   "GRAB"                          ; EE0F 47 52 41 42
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EE13 80 83
; ----------------------------------------------------------------------------
        ldy     #$B4                            ; EE15 A0 B4
        bne     LEE2B                           ; EE17 D0 12

; ----------------------------------------------------------------------------
RELEASE_lfa:
        .addr   LLIST_lfa                       ; EE19 3C EE
; ----------------------------------------------------------------------------
RELEASE_pfa:
        .byte   $01,$00,$C0,$18,$0E             ; EE1B 01 00 C0 18 0E
; ----------------------------------------------------------------------------
RELEASE:
        .byte   "RELEASE"                       ; EE20 52 45 4C 45 41 53 45
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EE27 80 83
; ----------------------------------------------------------------------------
        ldy     #$98                            ; EE29 A0 98
LEE2B:
        lda     #$00                            ; EE2B A9 00
LEE2D:
        sta     HIMEM_val                       ; EE2D 8D FB 07
        sty     HIMEM_val+1                     ; EE30 8C FC 07
        lda     fFlags                          ; EE33 A5 8C
        and     #$BF                            ; EE35 29 BF
        sta     fFlags                          ; EE37 85 8C

        ; CLEAR
        jmp     LFDA5                           ; EE39 4C A5 FD

; ----------------------------------------------------------------------------
LLIST_lfa:
        .addr   MLIST_lfa                       ; EE3C 50 EE
; ----------------------------------------------------------------------------
LLIST_pfa:
        .byte   $01,$00,$C0,$19,$0C             ; EE3E 01 00 C0 19 0C
; ----------------------------------------------------------------------------
LLIST:
        .byte   "LLIST"                         ; EE43 4C 4C 49 53 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0E,$00                     ; EE48 C0 0E 00
; ----------------------------------------------------------------------------
        lda     #$29                            ; EE4B A9 29
        jmp     LEBF3                           ; EE4D 4C F3 EB

; ----------------------------------------------------------------------------
MLIST_lfa:
        .addr   SLIST_lfa                       ; EE50 64 EE
; ----------------------------------------------------------------------------
MLIST_pfa:
        .byte   $01,$00,$C0,$1A,$0C             ; EE52 01 00 C0 1A 0C
; ----------------------------------------------------------------------------
MLIST:
        .byte   "MLIST"                         ; EE57 4D 4C 49 53 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0E,$00                     ; EE5C C0 0E 00
; ----------------------------------------------------------------------------
        lda     #$28                            ; EE5F A9 28
        jmp     LEBF3                           ; EE61 4C F3 EB

; ----------------------------------------------------------------------------
SLIST_lfa:
        .addr   LFEED_lfa                       ; EE64 78 EE
; ----------------------------------------------------------------------------
SLIST_pfa:
        .byte   $01,$00,$C0,$1B,$0C             ; EE66 01 00 C0 1B 0C
; ----------------------------------------------------------------------------
SLIST:
        .byte   "SLIST"                         ; EE6B 53 4C 49 53 54
; ----------------------------------------------------------------------------
        .byte   $C0,$0E,$00                     ; EE70 C0 0E 00
; ----------------------------------------------------------------------------
        lda     #$27                            ; EE73 A9 27
        jmp     LEBF3                           ; EE75 4C F3 EB

; ----------------------------------------------------------------------------
LFEED_lfa:
        .addr   AIDE_lfa                        ; EE78 92 EE
; ----------------------------------------------------------------------------
LFEED_pfa:
        .byte   $01,$00,$C0,$1C,$0C             ; EE7A 01 00 C0 1C 0C
; ----------------------------------------------------------------------------
LFEED:
        .byte   "LFEED"                         ; EE7F 4C 46 45 45 44
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; EE84 90 83
; ----------------------------------------------------------------------------
        php                                     ; EE86 08
        lsr     FLGLPR                          ; EE87 4E 8A 02
        pla                                     ; EE8A 68
        eor     #$01                            ; EE8B 49 01
        lsr     a                               ; EE8D 4A
        rol     FLGLPR                          ; EE8E 2E 8A 02
        rts                                     ; EE91 60

; ----------------------------------------------------------------------------
AIDE_lfa:
        .addr   FUNCTION_lfa                    ; EE92 A2 EE
; ----------------------------------------------------------------------------
AIDE_pfa:
        .byte   $01,$00,$C0,$1D,$0B             ; EE94 01 00 C0 1D 0B
; ----------------------------------------------------------------------------
AIDE:
        .byte   "AIDE"                          ; EE99 41 49 44 45
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; EE9D 80 03
; ----------------------------------------------------------------------------
        jsr     LED03                           ; EE9F 20 03 ED

; ----------------------------------------------------------------------------
FUNCTION_lfa:
        .addr   MOVE_lfa                        ; EEA2 BF EE
; ----------------------------------------------------------------------------
FUNCTION_pfa:
        .byte   $01,$00,$C0,$1E,$0F             ; EEA4 01 00 C0 1E 0F
; ----------------------------------------------------------------------------
FUNCTION:
        .byte   "FUNCTION"                      ; EEA9 46 55 4E 43 54 49 4F 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EEB1 80 83
; ----------------------------------------------------------------------------
        ; Affiche la liste des Fonctions et Constantes
        lda     #$02                            ; EEB3 A9 02
        jsr     LEC62                           ; EEB5 20 62 EC
        XCRLF                                   ; EEB8 00 25
        ; Affiche la liste des Opérateurs logiques ou arithmétiques
        lda     #$03                            ; EEBA A9 03
        jmp     LEC62                           ; EEBC 4C 62 EC

; ----------------------------------------------------------------------------
MOVE_lfa:
        .addr   HIMEM_lfa                       ; EEBF E6 EE
; ----------------------------------------------------------------------------
MOVE_pfa:
        .byte   $01,$00,$C0,$1F,$0B             ; EEC1 01 00 C0 1F 0B
; ----------------------------------------------------------------------------
MOVE:
        .byte   "MOVE"                          ; EEC6 4D 4F 56 45
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; EECA 01 01 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; EECE 20 84 D4
        sta     DECCIB                          ; EED1 85 08
        sty     DECCIB+1                        ; EED3 84 09
        jsr     LD481                           ; EED5 20 81 D4
        sta     DECDEB                          ; EED8 85 04
        sty     DECDEB+1                        ; EEDA 84 05
        jsr     LD47E                           ; EEDC 20 7E D4
        sta     DECFIN                          ; EEDF 85 06
        sty     DECFIN+1                        ; EEE1 84 07
        XDECAL                                  ; EEE3 00 18
        rts                                     ; EEE5 60

; ----------------------------------------------------------------------------
HIMEM_lfa:
        .addr   CURSOR_lfa                      ; EEE6 FA EE
; ----------------------------------------------------------------------------
HIMEM_pfa:
        .byte   $01,$00,$C0,$20,$0C             ; EEE8 01 00 C0 20 0C
; ----------------------------------------------------------------------------
HIMEM:
        .byte   "HIMEM"                         ; EEED 48 49 4D 45 4D
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EEF2 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; EEF4 20 84 D4
        jmp     LEE2D                           ; EEF7 4C 2D EE

; ----------------------------------------------------------------------------
CURSOR_lfa:
        .addr   LOUT_lfa                        ; EEFA 13 EF
; ----------------------------------------------------------------------------
CURSOR_pfa:
        .byte   $01,$00,$C0,$21,$0D             ; EEFC 01 00 C0 21 0D
; ----------------------------------------------------------------------------
CURSOR:
        .byte   "CURSOR"                        ; EF01 43 55 52 53 4F 52
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; EF07 90 83
; ----------------------------------------------------------------------------
        ldx     #$00                            ; EF09 A2 00
        bcc     LEF10                           ; EF0B 90 03
        XCSSCR                                  ; EF0D 00 35
        rts                                     ; EF0F 60

; ----------------------------------------------------------------------------
LEF10:
        XCOSCR                                  ; EF10 00 34
        rts                                     ; EF12 60

; ----------------------------------------------------------------------------
LOUT_lfa:
        .addr   WAIT_lfa                        ; EF13 26 EF
; ----------------------------------------------------------------------------
LOUT_pfa:
        .byte   $01,$00,$C0,$22,$0B             ; EF15 01 00 C0 22 0B
; ----------------------------------------------------------------------------
LOUT:
        .byte   "LOUT"                          ; EF1A 4C 4F 55 54
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EF1E 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; EF20 20 4F D4
        XLPRBI                                  ; EF23 00 48
        rts                                     ; EF25 60

; ----------------------------------------------------------------------------
WAIT_lfa:
        .addr   PATTERN_lfa                     ; EF26 41 EF
; ----------------------------------------------------------------------------
WAIT_pfa:
        .byte   $01,$00,$C0,$23,$0B             ; EF28 01 00 C0 23 0B
; ----------------------------------------------------------------------------
WAIT:
        .byte   "WAIT"                          ; EF2D 57 41 49 54
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EF31 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; EF33 20 84 D4
        sta     $44                             ; EF36 85 44
        sty     $45                             ; EF38 84 45
LEF3A:
        lda     $44                             ; EF3A A5 44
        ora     $45                             ; EF3C 05 45
        bne     LEF3A                           ; EF3E D0 FA
        rts                                     ; EF40 60

; ----------------------------------------------------------------------------
PATTERN_lfa:
        .addr   DRV$_lfa                        ; EF41 58 EF
; ----------------------------------------------------------------------------
PATTERN_pfa:
        .byte   $01,$00,$C0,$24,$0E             ; EF43 01 00 C0 24 0E
; ----------------------------------------------------------------------------
PATTERN:
        .byte   "PATTERN"                       ; EF48 50 41 54 54 45 52 4E
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; EF4F 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; EF51 20 4F D4
        sta     HRSPAT                          ; EF54 8D AA 02
        rts                                     ; EF57 60

; ----------------------------------------------------------------------------
DRV$_lfa:
        .addr   EXT$_lfa                        ; EF58 78 EF
; ----------------------------------------------------------------------------
DRV$_pfa:
        .byte   $02,$01,$C0,$27,$0B             ; EF5A 02 01 C0 27 0B
; ----------------------------------------------------------------------------
DRV$:
        .byte   "DRV$"                          ; EF5F 44 52 56 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EF63 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; EF65 20 0A D4
        lda     #$01                            ; EF68 A9 01
        jsr     LCF52                           ; EF6A 20 52 CF

        ; Converti le n° de lecteur en lettre
        lda     DRVDEF                          ; EF6D AD 0C 02
        clc                                     ; EF70 18
        adc     #$41                            ; EF71 69 41
        ldy     #$00                            ; EF73 A0 00
        sta     (FACC1M),y                      ; EF75 91 61
        rts                                     ; EF77 60

; ----------------------------------------------------------------------------
EXT$_lfa:
        .addr   EXT_lfa                         ; EF78 91 EF
; ----------------------------------------------------------------------------
EXT$_pfa:
        .byte   $02,$01,$C0,$29,$0B             ; EF7A 02 01 C0 29 0B
; ----------------------------------------------------------------------------
EXT$:
        .byte   "EXT$"                          ; EF7F 45 58 54 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EF83 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; EF85 20 0A D4
        lda     #$5D                            ; EF88 A9 5D
        ldy     #$05                            ; EF8A A0 05
        ldx     #$03                            ; EF8C A2 03
        jmp     LCF62                           ; EF8E 4C 62 CF

; ----------------------------------------------------------------------------
EXT_lfa:
        .addr   TCOPY_lfa                       ; EF91 B1 EF
; ----------------------------------------------------------------------------
EXT_pfa:
        .byte   $01,$00,$C0,$2A,$0A             ; EF93 01 00 C0 2A 0A
; ----------------------------------------------------------------------------
EXT:
        .byte   "EXT"                           ; EF98 45 58 54
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; EF9B 82 83
; ----------------------------------------------------------------------------
        lda     FACC1E                          ; EF9D A5 60
        cmp     #$03                            ; EF9F C9 03
        bne     LEFAE                           ; EFA1 D0 0B
        ldy     #$02                            ; EFA3 A0 02
LEFA5:
        lda     (FACC1M),y                      ; EFA5 B1 61
        sta     EXTDEF,y                        ; EFA7 99 5D 05
        dey                                     ; EFAA 88
        bpl     LEFA5                           ; EFAB 10 F8
        rts                                     ; EFAD 60

; ----------------------------------------------------------------------------
LEFAE:
        jmp     Error_BADVAL                    ; EFAE 4C FF F0

; ----------------------------------------------------------------------------
TCOPY_lfa:
        .addr   HCOPY_lfa                       ; EFB1 C6 EF
; ----------------------------------------------------------------------------
TCOPY_pfa:
        .byte   $01,$00,$C0,$2B,$0C             ; EFB3 01 00 C0 2B 0C
; ----------------------------------------------------------------------------
TCOPY:
        .byte   "TCOPY"                         ; EFB8 54 43 4F 50 59
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EFBD 80 83
; ----------------------------------------------------------------------------
        lda     #$00                            ; EFBF A9 00
        sta     $28                             ; EFC1 85 28
        XHCSRC                                  ; EFC3 00 4A
        rts                                     ; EFC5 60

; ----------------------------------------------------------------------------
HCOPY_lfa:
        .addr   AZERTY_lfa                      ; EFC6 DA EF
; ----------------------------------------------------------------------------
HCOPY_pfa:
        .byte   $01,$00,$C0,$2C,$0C             ; EFC8 01 00 C0 2C 0C
; ----------------------------------------------------------------------------
HCOPY:
        .byte   "HCOPY"                         ; EFCD 48 43 4F 50 59
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EFD2 80 83
; ----------------------------------------------------------------------------
        jsr     LD14F                           ; EFD4 20 4F D1
        XHCHRS                                  ; EFD7 00 4C
        rts                                     ; EFD9 60

; ----------------------------------------------------------------------------
AZERTY_lfa:
        .addr   QWERTY_lfa                      ; EFDA EE EF
; ----------------------------------------------------------------------------
AZERTY_pfa:
        .byte   $01,$00,$C0,$34,$0D             ; EFDC 01 00 C0 34 0D
; ----------------------------------------------------------------------------
AZERTY:
        .byte   "AZERTY"                        ; EFE1 41 5A 45 52 54 59
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EFE7 80 83
; ----------------------------------------------------------------------------
        lda     #$01                            ; EFE9 A9 01
        XGOKBD                                  ; EFEB 00 52
        rts                                     ; EFED 60

; ----------------------------------------------------------------------------
QWERTY_lfa:
        .addr   FRENCH_lfa                      ; EFEE 02 F0
; ----------------------------------------------------------------------------
QWERTY_pfa:
        .byte   $01,$00,$C0,$35,$0D             ; EFF0 01 00 C0 35 0D
; ----------------------------------------------------------------------------
QWERTY:
        .byte   "QWERTY"                        ; EFF5 51 57 45 52 54 59
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; EFFB 80 83
; ----------------------------------------------------------------------------
        lda     #$00                            ; EFFD A9 00
        XGOKBD                                  ; EFFF 00 52
        rts                                     ; F001 60

; ----------------------------------------------------------------------------
FRENCH_lfa:
        .addr   ACCENT_lfa                      ; F002 16 F0
; ----------------------------------------------------------------------------
FRENCH_pfa:
        .byte   $01,$00,$C0,$36,$0D             ; F004 01 00 C0 36 0D
; ----------------------------------------------------------------------------
FRENCH:
        .byte   "FRENCH"                        ; F009 46 52 45 4E 43 48
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F00F 80 83
; ----------------------------------------------------------------------------
        lda     #$02                            ; F011 A9 02
        XGOKBD                                  ; F013 00 52
        rts                                     ; F015 60

; ----------------------------------------------------------------------------
ACCENT_lfa:
        .addr   DELETE_lfa                      ; F016 2E F0
; ----------------------------------------------------------------------------
ACCENT_pfa:
        .byte   $01,$00,$C0,$37,$0D             ; F018 01 00 C0 37 0D
; ----------------------------------------------------------------------------
ACCENT:
        .byte   "ACCENT"                        ; F01D 41 43 43 45 4E 54
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; F023 90 83
; ----------------------------------------------------------------------------
        lda     #$04                            ; F025 A9 04
        bcs     LF02B                           ; F027 B0 02
        lda     #$05                            ; F029 A9 05
LF02B:
        XGOKBD                                  ; F02B 00 52
        rts                                     ; F02D 60

; ----------------------------------------------------------------------------
DELETE_lfa:
        .addr   ASCII_lfa                       ; F02E 44 F0
; ----------------------------------------------------------------------------
DELETE_pfa:
        .byte   $01,$00,$C0,$38,$0D             ; F030 01 00 C0 38 0D
; ----------------------------------------------------------------------------
DELETE:
        .byte   "DELETE"                        ; F035 44 45 4C 45 54 45
; ----------------------------------------------------------------------------
        .byte   $C0,$12,$03                     ; F03B C0 12 03
; ----------------------------------------------------------------------------
        jsr     LC4B1                           ; F03E 20 B1 C4
        jmp     LEC04                           ; F041 4C 04 EC

; ----------------------------------------------------------------------------
ASCII_lfa:
        .addr   TALK_lfa                        ; F044 86 F0
; ----------------------------------------------------------------------------
ASCII_pfa:
        .byte   $01,$00,$C0,$3D,$0C             ; F046 01 00 C0 3D 0C
; ----------------------------------------------------------------------------
ASCII:
        .byte   "ASCII"                         ; F04B 41 53 43 49 49
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F050 80 83
; ----------------------------------------------------------------------------
        jsr     Print0_SPACE                    ; F052 20 DB D5
        jsr     Print0_SPACE                    ; F055 20 DB D5
        ldx     #$00                            ; F058 A2 00
LF05A:
        jsr     Print0_SPACE                    ; F05A 20 DB D5
        txa                                     ; F05D 8A
        XHEXA                                   ; F05E 00 2A
        tya                                     ; F060 98
        XWR0                                    ; F061 00 10
        inx                                     ; F063 E8
        cpx     #$10                            ; F064 E0 10
        bne     LF05A                           ; F066 D0 F2
        XCRLF                                   ; F068 00 25
        XCRLF                                   ; F06A 00 25
        ldx     #$20                            ; F06C A2 20
LF06E:
        txa                                     ; F06E 8A
        jsr     LF333                           ; F06F 20 33 F3
        ldy     #$10                            ; F072 A0 10
LF074:
        jsr     Print0_SPACE                    ; F074 20 DB D5
        txa                                     ; F077 8A
        XWR0                                    ; F078 00 10
        inx                                     ; F07A E8
        dey                                     ; F07B 88
        bne     LF074                           ; F07C D0 F6
        XCRLF                                   ; F07E 00 25
        txa                                     ; F080 8A
        bpl     LF06E                           ; F081 10 EB
        XCRLF                                   ; F083 00 25
        rts                                     ; F085 60

; ----------------------------------------------------------------------------
TALK_lfa:
        .addr   CLOCKOFF_lfa                    ; F086 9E F0
; ----------------------------------------------------------------------------
TALK_pfa:
        .byte   $01,$00,$C0,$3E,$0B             ; F088 01 00 C0 3E 0B
; ----------------------------------------------------------------------------
TALK:
        .byte   "TALK"                          ; F08D 54 41 4C 4B
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; F091 90 83
; ----------------------------------------------------------------------------
        php                                     ; F093 08
        lda     fTalk                           ; F094 A5 8D
        asl     a                               ; F096 0A
        plp                                     ; F097 28
        ror     a                               ; F098 6A
        eor     #$80                            ; F099 49 80
        sta     fTalk                           ; F09B 85 8D
        rts                                     ; F09D 60

; ----------------------------------------------------------------------------
CLOCKOFF_lfa:
        .addr   CLOCKSET_lfa                    ; F09E B1 F0
; ----------------------------------------------------------------------------
CLOCKOFF_pfa:
        .byte   $01,$00,$C0,$48,$0F             ; F0A0 01 00 C0 48 0F
; ----------------------------------------------------------------------------
CLOCKOFF:
        .byte   "CLOCKOFF"                      ; F0A5 43 4C 4F 43 4B 4F 46 46
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F0AD 80 02
; ----------------------------------------------------------------------------
        XCLCL                                   ; F0AF 00 3D

; ----------------------------------------------------------------------------
CLOCKSET_lfa:
        .addr   SSPEED_lfa                      ; F0B1 C8 F0
; ----------------------------------------------------------------------------
CLOCKSET_pfa:
        .byte   $01,$00,$C0,$49,$0F             ; F0B3 01 00 C0 49 0F
; ----------------------------------------------------------------------------
CLOCKSET:
        .byte   "CLOCKSET"                      ; F0B8 43 4C 4F 43 4B 53 45 54
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F0C0 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; F0C2 20 84 D4
        XWCLK                                   ; F0C5 00 3E
        rts                                     ; F0C7 60

; ----------------------------------------------------------------------------
SSPEED_lfa:
        .addr   SMODE_lfa                       ; F0C8 24 F1
; ----------------------------------------------------------------------------
SSPEED_pfa:
        .byte   $01,$00,$C0,$4A,$0D             ; F0CA 01 00 C0 4A 0D
; ----------------------------------------------------------------------------
SSPEED:
        .byte   "SSPEED"                        ; F0CF 53 53 50 45 45 44
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F0D5 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; F0D7 20 84 D4
        ldy     #$20                            ; F0DA A0 20
LF0DC:
        lda     FACC1M+1                        ; F0DC A5 62
        cmp     SSPEED_table+1,y                ; F0DE D9 05 F1
        bne     LF0FB                           ; F0E1 D0 18
        lda     FACC1M                          ; F0E3 A5 61
        cmp     SSPEED_table,y                  ; F0E5 D9 04 F1
        bne     LF0FB                           ; F0E8 D0 11
        tya                                     ; F0EA 98
        lsr     a                               ; F0EB 4A
        sta     RES                             ; F0EC 85 00
        lda     ACIACT                          ; F0EE AD 1F 03
        and     #$F0                            ; F0F1 29 F0
        ora     RES                             ; F0F3 05 00
        sta     ACIACT                          ; F0F5 8D 1F 03
        sta     $59                             ; F0F8 85 59
LF0FA:
        rts                                     ; F0FA 60

; ----------------------------------------------------------------------------
LF0FB:
        dey                                     ; F0FB 88
        dey                                     ; F0FC 88
        bpl     LF0DC                           ; F0FD 10 DD
; Erreur: valeur incorrecte
Error_BADVAL:
        ldx     #$12                            ; F0FF A2 12
        jmp     Error_X                         ; F101 4C 7E D1

; ----------------------------------------------------------------------------
SSPEED_table:
        .word   $0010,$0032,$004B,$006D         ; F104 10 00 32 00 4B 00 6D 00
        .word   $0086,$0096,$012C,$0258         ; F10C 86 00 96 00 2C 01 58 02
        .word   $04B0,$0708,$0960,$0E10         ; F114 B0 04 08 07 60 09 10 0E
        .word   $12C0,$1C20,$2580,$4B00         ; F11C C0 12 20 1C 80 25 00 4B

; ----------------------------------------------------------------------------
SMODE_lfa:
        .addr   ERRLIST_lfa                     ; F124 94 F1
; ----------------------------------------------------------------------------
SMODE_pfa:
        .byte   $01,$00,$C0,$4B,$0C             ; F126 01 00 C0 4B 0C
; ----------------------------------------------------------------------------
SMODE:
        .byte   "SMODE"                         ; F12B 53 4D 4F 44 45
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; F130 82 83
; ----------------------------------------------------------------------------
        ldy     FACC1E                          ; F132 A4 60
LF134:
        dey                                     ; F134 88
        bmi     LF0FA                           ; F135 30 C3
        ldx     #$0D                            ; F137 A2 0D
LF139:
        lda     SMODE_table1,x                  ; F139 BD 6A F1
        cmp     (FACC1M),y                      ; F13C D1 61
        beq     LF145                           ; F13E F0 05
        dex                                     ; F140 CA
        bpl     LF139                           ; F141 10 F6
        bmi     Error_BADVAL                    ; F143 30 BA
LF145:
        cpx     #$08                            ; F145 E0 08
        bcs     LF158                           ; F147 B0 0F
        lda     $59                             ; F149 A5 59
        and     SMODE_table2,x                  ; F14B 3D 78 F1
        ora     SMODE_table3,x                  ; F14E 1D 86 F1
        sta     $59                             ; F151 85 59
        sta     ACIACT                          ; F153 8D 1F 03
        bcc     LF134                           ; F156 90 DC
LF158:
        lda     ACIACR                          ; F158 AD 1E 03
        and     SMODE_table2,x                  ; F15B 3D 78 F1
        ora     SMODE_table3,x                  ; F15E 1D 86 F1
        sta     ACIACR                          ; F161 8D 1E 03
        and     #$E0                            ; F164 29 E0
        sta     $5A                             ; F166 85 5A
        bcs     LF134                           ; F168 B0 CA

; ----------------------------------------------------------------------------
SMODE_table1:
        .byte   "015678CBPNOEMS"                ; F16A 30 31 35 36 37 38 43 42
                                                ; F172 50 4E 4F 45 4D 53
; ----------------------------------------------------------------------------
SMODE_table2:
        .byte   $7F,$7F,$9F,$9F,$9F,$9F,$EF,$EF ; F178 7F 7F 9F 9F 9F 9F EF EF
        .byte   $DF,$DF,$3F,$3F,$3F,$3F         ; F180 DF DF 3F 3F 3F 3F
SMODE_table3:
        .byte   $00,$80,$60,$40,$20,$00,$10,$00 ; F186 00 80 60 40 20 00 10 00
        .byte   $20,$00,$00,$40,$80,$C0         ; F18E 20 00 00 40 80 C0

; ----------------------------------------------------------------------------
ERRLIST_lfa:
        .addr   TIME_lfa                        ; F194 E0 F1
; ----------------------------------------------------------------------------
ERRLIST_pfa:
        .byte   $01,$00,$C0,$4C,$0E             ; F196 01 00 C0 4C 0E
; ----------------------------------------------------------------------------
ERRLIST:
        .byte   "ERRLIST"                       ; F19B 45 52 52 4C 49 53 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F1A2 80 83
; ----------------------------------------------------------------------------
        ldx     #$00                            ; F1A4 A2 00
LF1A6:
        txa                                     ; F1A6 8A
        pha                                     ; F1A7 48
        ldx     #$30                            ; F1A8 A2 30
        stx     DEFAFF                          ; F1AA 86 14
        ldy     #$00                            ; F1AC A0 00
        ldx     #$00                            ; F1AE A2 00
        XDECIM                                  ; F1B0 00 29
        jsr     Print0_SPACE                    ; F1B2 20 DB D5
        pla                                     ; F1B5 68
        tax                                     ; F1B6 AA
        stx     TR0                             ; F1B7 86 0C
        jsr     PrintErrMsg1                    ; F1B9 20 7B D5
        jsr     LF1C7                           ; F1BC 20 C7 F1
        ldx     TR0                             ; F1BF A6 0C
        inx                                     ; F1C1 E8
        cpx     #$1C                            ; F1C2 E0 1C
        bne     LF1A6                           ; F1C4 D0 E0
LF1C6:
        rts                                     ; F1C6 60

; ----------------------------------------------------------------------------
LF1C7:
        XCRLF                                   ; F1C7 00 25
LF1C9:
        ; Teste si on a appuyé sur CTRL+C ou ESC (retour à la procédure appelante de la procédure appelante si oui)
        XRD0                                    ; F1C9 00 08
        bcs     LF1C6                           ; F1CB B0 F9
        ; CTRL+C?
        cmp     #$03                            ; F1CD C9 03
        beq     LF1DB                           ; F1CF F0 0A
        XRDW0                                   ; F1D1 00 0C
        ; ESC?
        cmp     #$1B                            ; F1D3 C9 1B
        beq     LF1DB                           ; F1D5 F0 04
        ; CTRL+C?
        cmp     #$03                            ; F1D7 C9 03
        bne     LF1C6                           ; F1D9 D0 EB
LF1DB:
        ; Oubli l'adresse de la procédure appelante
        pla                                     ; F1DB 68
        pla                                     ; F1DC 68
        XCRLF                                   ; F1DD 00 25
        rts                                     ; F1DF 60

; ----------------------------------------------------------------------------
TIME_lfa:
        .addr   TIME$_lfa                       ; F1E0 0E F2
; ----------------------------------------------------------------------------
TIME_pfa:
        .byte   $01,$00,$C0,$4D,$0B             ; F1E2 01 00 C0 4D 0B
; ----------------------------------------------------------------------------
TIME:
        .byte   "TIME"                          ; F1E7 54 49 4D 45
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F1EB 01 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; F1EE 20 4F D4
        cmp     #$3C                            ; F1F1 C9 3C
        bcs     LF20B                           ; F1F3 B0 16
        ldx     #$00                            ; F1F5 A2 00
        stx     TIMES                           ; F1F7 8E 10 02
        stx     TIMES                           ; F1FA 8E 11 02
        sta     TIMEM                           ; F1FD 8D 12 02
        jsr     LD44C                           ; F200 20 4C D4
        cmp     #$64                            ; F203 C9 64
        bcs     LF20B                           ; F205 B0 04
        sta     TIMEH                           ; F207 8D 13 02
        rts                                     ; F20A 60

; ----------------------------------------------------------------------------
LF20B:
        jmp     Error_BADVAL                    ; F20B 4C FF F0

; ----------------------------------------------------------------------------
TIME$_lfa:
        .addr   LBUF_lfa                        ; F20E 5C F2
; ----------------------------------------------------------------------------
TIME$_pfa:
        .byte   $02,$01,$C0,$4E,$0C             ; F210 02 01 C0 4E 0C
; ----------------------------------------------------------------------------
TIME$:
        .byte   "TIME$"                         ; F215 54 49 4D 45 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F21A 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; F21C 20 0A D4

        lda     #$0A                            ; F21F A9 0A
        jsr     LCF52                           ; F221 20 52 CF

        ; Récupère les 4 octets représentant l'heure en binaire
        ; et les empile(1/10, secondes, minutes, heures)
        ldx     #$00                            ; F224 A2 00
LF226:
        lda     TIMES,x                         ; F226 BD 10 02
        pha                                     ; F229 48
        inx                                     ; F22A E8
        cpx     #$04                            ; F22B E0 04
        bne     LF226                           ; F22D D0 F7

        ; Pointeur pour FACC1M
        ldy     #$00                            ; F22F A0 00
        ; Heures
        pla                                     ; F231 68
        jsr     LF243                           ; F232 20 43 F2
        ; Minutes
        pla                                     ; F235 68
        jsr     LF243                           ; F236 20 43 F2
        ; Secondes
        pla                                     ; F239 68
        jsr     LF243                           ; F23A 20 43 F2
        ; 1/10 de secondes
        pla                                     ; F23D 68
        ora     #$30                            ; F23E 09 30
        jmp     LF258                           ; F240 4C 58 F2

; ----------------------------------------------------------------------------
; Conversion d'une valeur binaire en chaine
; ACC doit être <= 99 sinon pb...
; La chaine est assembée dans FACC1M.
; Y est le pointeur dans FACC1M
LF243:
        ; X: compteur pour les dizaines
        ldx     #$2F                            ; F243 A2 2F
        sec                                     ; F245 38
LF246:
        sbc     #$0A                            ; F246 E9 0A
        inx                                     ; F248 E8
        bcs     LF246                           ; F249 B0 FB
        ; Sauvegarde le reste de la division par 10
        pha                                     ; F24B 48
        ; Converti les dizaines
        txa                                     ; F24C 8A
        jsr     LF258                           ; F24D 20 58 F2
        ; Puis les unités
        pla                                     ; F250 68
        adc     #$3A                            ; F251 69 3A
        jsr     LF258                           ; F253 20 58 F2
        ; Ajoute ':' dans la chaine
        lda     #$3A                            ; F256 A9 3A
LF258:
        sta     (FACC1M),y                      ; F258 91 61
        iny                                     ; F25A C8
        rts                                     ; F25B 60

; ----------------------------------------------------------------------------
LBUF_lfa:
        .addr   SRBUF_lfa                       ; F25C 7E F2
; ----------------------------------------------------------------------------
LBUF_pfa:
        .byte   $01,$00,$C0,$4F,$0B             ; F25E 01 00 C0 4F 0B
; ----------------------------------------------------------------------------
LBUF:
        .byte   "LBUF"                          ; F263 4C 42 55 46
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F267 01 81 83
; ----------------------------------------------------------------------------
        lda     #$24                            ; F26A A9 24
LF26C:
        pha                                     ; F26C 48
        jsr     LD481                           ; F26D 20 81 D4
        sta     RES                             ; F270 85 00
        sty     RES+1                           ; F272 84 01
        jsr     GetWord                         ; F274 20 84 D4
        pla                                     ; F277 68
        tax                                     ; F278 AA
        lda     FACC1M                          ; F279 A5 61
        XINIBU                                  ; F27B 00 58
        rts                                     ; F27D 60

; ----------------------------------------------------------------------------
SRBUF_lfa:
        .addr   SEBUF_lfa                       ; F27E 91 F2
; ----------------------------------------------------------------------------
SRBUF_pfa:
        .byte   $01,$00,$C0,$50,$0C             ; F280 01 00 C0 50 0C
; ----------------------------------------------------------------------------
SRBUF:
        .byte   "SRBUF"                         ; F285 53 52 42 55 46
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F28A 01 81 83
; ----------------------------------------------------------------------------
        lda     #$0C                            ; F28D A9 0C
        bne     LF26C                           ; F28F D0 DB

; ----------------------------------------------------------------------------
SEBUF_lfa:
        .addr   PLOT_lfa                        ; F291 A4 F2
; ----------------------------------------------------------------------------
SEBUF_pfa:
        .byte   $01,$00,$C0,$51,$0C             ; F293 01 00 C0 51 0C
; ----------------------------------------------------------------------------
SEBUF:
        .byte   "SEBUF"                         ; F298 53 45 42 55 46
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F29D 01 81 83
; ----------------------------------------------------------------------------
        lda     #$18                            ; F2A0 A9 18
        bne     LF26C                           ; F2A2 D0 C8

; ----------------------------------------------------------------------------
PLOT_lfa:
        .addr   POP_lfa                         ; F2A4 E1 F2
; ----------------------------------------------------------------------------
PLOT_pfa:
        .byte   $01,$00,$C0,$52,$0B             ; F2A6 01 00 C0 52 0B
; ----------------------------------------------------------------------------
PLOT:
        .byte   "PLOT"                          ; F2AB 50 4C 4F 54
; ----------------------------------------------------------------------------
        .byte   $01,$01,$82,$83                 ; F2AF 01 01 82 83
; ----------------------------------------------------------------------------
        jsr     LD155                           ; F2B3 20 55 D1
        jsr     LD449                           ; F2B6 20 49 D4
        cmp     #$1C                            ; F2B9 C9 1C
        bcs     LF2DE                           ; F2BB B0 21
        XMUL40                                  ; F2BD 00 20
        jsr     LD44C                           ; F2BF 20 4C D4
        cmp     #$28                            ; F2C2 C9 28
        bcs     LF2DE                           ; F2C4 B0 18
        ldy     #$00                            ; F2C6 A0 00
        XADRES                                  ; F2C8 00 22
        lda     #$80                            ; F2CA A9 80
        ldy     #$BB                            ; F2CC A0 BB
        XADRES                                  ; F2CE 00 22
        ldy     FACC1E                          ; F2D0 A4 60
LF2D2:
        tya                                     ; F2D2 98
        beq     LF2DD                           ; F2D3 F0 08
        dey                                     ; F2D5 88
        lda     (FACC1M),y                      ; F2D6 B1 61
        sta     (RES),y                         ; F2D8 91 00
        jmp     LF2D2                           ; F2DA 4C D2 F2

; ----------------------------------------------------------------------------
LF2DD:
        rts                                     ; F2DD 60

; ----------------------------------------------------------------------------
LF2DE:
        jmp     Error_BADVAL                    ; F2DE 4C FF F0

; ----------------------------------------------------------------------------
POP_lfa:
        .addr   SSAVEA_lfa                      ; F2E1 F2 F2
; ----------------------------------------------------------------------------
POP_pfa:
        .byte   $01,$00,$C0,$53,$0A             ; F2E3 01 00 C0 53 0A
; ----------------------------------------------------------------------------
POP:
        .byte   "POP"                           ; F2E8 50 4F 50
; ----------------------------------------------------------------------------
        .byte   $80,$05                         ; F2EB 80 05
; ----------------------------------------------------------------------------
        jsr     LDFD5                           ; F2ED 20 D5 DF
        pla                                     ; F2F0 68
        pla                                     ; F2F1 68

; ----------------------------------------------------------------------------
SSAVEA_lfa:
        .addr   SLOADA_lfa                      ; F2F2 09 F3
; ----------------------------------------------------------------------------
SSAVEA_pfa:
        .byte   $01,$00,$C0,$54,$0D             ; F2F4 01 00 C0 54 0D
; ----------------------------------------------------------------------------
SSAVEA:
        .byte   "SSAVEA"                        ; F2F9 53 53 41 56 45 41
; ----------------------------------------------------------------------------
        .byte   $C0,$CA,$83                     ; F2FF C0 CA 83
; ----------------------------------------------------------------------------
        jsr     LD138                           ; F302 20 38 D1
        sec                                     ; F305 38
        XSSAVE                                  ; F306 00 5F
        rts                                     ; F308 60

; ----------------------------------------------------------------------------
SLOADA_lfa:
        .addr   SLOAD_lfa                       ; F309 3B F3
; ----------------------------------------------------------------------------
SLOADA_pfa:
        .byte   $01,$00,$C0,$55,$0D             ; F30B 01 00 C0 55 0D
; ----------------------------------------------------------------------------
SLOADA:
        .byte   "SLOADA"                        ; F310 53 4C 4F 41 44 41
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F316 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; F318 20 84 D4
        sta     DESALO                          ; F31B 8D 2D 05
        sty     DESALO+1                        ; F31E 8C 2E 05
        sec                                     ; F321 38
        XSLOAD                                  ; F322 00 5E
LF324:
        lda     RES                             ; F324 A5 00
        pha                                     ; F326 48
        lda     RES+1                           ; F327 A5 01
        jsr     LF333                           ; F329 20 33 F3
        pla                                     ; F32C 68
        jsr     LF333                           ; F32D 20 33 F3
        XCRLF                                   ; F330 00 25
        rts                                     ; F332 60

; ----------------------------------------------------------------------------
LF333:
        XHEXA                                   ; F333 00 2A
        XWR0                                    ; F335 00 10
        tya                                     ; F337 98
        XWR0                                    ; F338 00 10
        rts                                     ; F33A 60

; ----------------------------------------------------------------------------
SLOAD_lfa:
        .addr   SSAVE"_lfa                      ; F33B 4F F3
; ----------------------------------------------------------------------------
SLOAD_pfa:
        .byte   $01,$00,$C0,$56,$0C             ; F33D 01 00 C0 56 0C
; ----------------------------------------------------------------------------
SLOAD:
        .byte   "SLOAD"                         ; F342 53 4C 4F 41 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F347 80 83
; ----------------------------------------------------------------------------
        clc                                     ; F349 18
        XSLOAD                                  ; F34A 00 5E
        jmp     LF515                           ; F34C 4C 15 F5

; ----------------------------------------------------------------------------
SSAVE"_lfa:
        .addr   SDUMP_lfa                       ; F34F 66 F3
; ----------------------------------------------------------------------------
SSAVE"_pfa:
        .byte   $01,$00,$C0,$57,$0C             ; F351 01 00 C0 57 0C
; ----------------------------------------------------------------------------
SSAVE":
        .byte   "SSAVE"                         ; F356 53 53 41 56 45
        .byte   $22                             ; F35B 22
; ----------------------------------------------------------------------------
        .byte   $C0,$9B,$83                     ; F35C C0 9B 83
; ----------------------------------------------------------------------------
        jsr     LD138                           ; F35F 20 38 D1
        clc                                     ; F362 18
        XSSAVE                                  ; F363 00 5F
        rts                                     ; F365 60

; ----------------------------------------------------------------------------
SDUMP_lfa:
        .addr   CONSOLE_lfa                     ; F366 76 F3
; ----------------------------------------------------------------------------
SDUMP_pfa:
        .byte   $01,$00,$C0,$58,$0C             ; F368 01 00 C0 58 0C
; ----------------------------------------------------------------------------
SDUMP:
        .byte   "SDUMP"                         ; F36D 53 44 55 4D 50
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F372 80 02
; ----------------------------------------------------------------------------
        XSDUMP                                  ; F374 00 5C

; ----------------------------------------------------------------------------
CONSOLE_lfa:
        .addr   MLOADA_lfa                      ; F376 88 F3
; ----------------------------------------------------------------------------
CONSOLE_pfa:
        .byte   $01,$00,$C0,$5A,$0E             ; F378 01 00 C0 5A 0E
; ----------------------------------------------------------------------------
CONSOLE:
        .byte   "CONSOLE"                       ; F37D 43 4F 4E 53 4F 4C 45
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F384 80 02
; ----------------------------------------------------------------------------
        XCONDO                                  ; F386 00 5D

; ----------------------------------------------------------------------------
MLOADA_lfa:
        .addr   MSAVEA_lfa                      ; F388 A6 F3
; ----------------------------------------------------------------------------
MLOADA_pfa:
        .byte   $01,$00,$C0,$5B,$0D             ; F38A 01 00 C0 5B 0D
; ----------------------------------------------------------------------------
MLOADA:
        .byte   "MLOADA"                        ; F38F 4D 4C 4F 41 44 41
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F395 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; F397 20 84 D4
        sta     DESALO                          ; F39A 8D 2D 05
        sty     DESALO+1                        ; F39D 8C 2E 05
        sec                                     ; F3A0 38
        XMLOAD                                  ; F3A1 00 60
        jmp     LF324                           ; F3A3 4C 24 F3

; ----------------------------------------------------------------------------
MSAVEA_lfa:
        .addr   MLOAD_lfa                       ; F3A6 C0 F3
; ----------------------------------------------------------------------------
MSAVEA_pfa:
        .byte   $01,$00,$C0,$5C,$0D             ; F3A8 01 00 C0 5C 0D
; ----------------------------------------------------------------------------
MSAVEA:
        .byte   "MSAVEA"                        ; F3AD 4D 53 41 56 45 41
; ----------------------------------------------------------------------------
        .byte   $C0,$16,$83                     ; F3B3 C0 16 83
; ----------------------------------------------------------------------------
        jsr     LD138                           ; F3B6 20 38 D1
        sec                                     ; F3B9 38
        XMSAVE                                  ; F3BA 00 61
        rts                                     ; F3BC 60

; ----------------------------------------------------------------------------
        jmp     LF59A                           ; F3BD 4C 9A F5

; ----------------------------------------------------------------------------
MLOAD_lfa:
        .addr   MSAVE"_lfa                      ; F3C0 D4 F3
; ----------------------------------------------------------------------------
MLOAD_pfa:
        .byte   $01,$00,$C0,$5D,$0C             ; F3C2 01 00 C0 5D 0C
; ----------------------------------------------------------------------------
MLOAD:
        .byte   "MLOAD"                         ; F3C7 4D 4C 4F 41 44
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F3CC 80 83
; ----------------------------------------------------------------------------
        clc                                     ; F3CE 18
        XMLOAD                                  ; F3CF 00 60
        jmp     LF515                           ; F3D1 4C 15 F5

; ----------------------------------------------------------------------------
MSAVE"_lfa:
        .addr   RING_lfa                        ; F3D4 EE F3
; ----------------------------------------------------------------------------
MSAVE"_pfa:
        .byte   $01,$00,$C0,$5E,$0C             ; F3D6 01 00 C0 5E 0C
; ----------------------------------------------------------------------------
MSAVE":
        .byte   "MSAVE"                         ; F3DB 4D 53 41 56 45
        .byte   $22                             ; F3E0 22
; ----------------------------------------------------------------------------
        .byte   $C0,$16,$83                     ; F3E1 C0 16 83
; ----------------------------------------------------------------------------
        jsr     LD138                           ; F3E4 20 38 D1
        clc                                     ; F3E7 18
        XMSAVE                                  ; F3E8 00 61
        rts                                     ; F3EA 60

; ----------------------------------------------------------------------------
        jmp     LF595                           ; F3EB 4C 95 F5

; ----------------------------------------------------------------------------
RING_lfa:
        .addr   CONNECT_lfa                     ; F3EE 08 F4
; ----------------------------------------------------------------------------
RING_pfa:
        .byte   $01,$00,$C0,$5F,$0B             ; F3F0 01 00 C0 5F 0B
; ----------------------------------------------------------------------------
RING:
        .byte   "RING"                          ; F3F5 52 49 4E 47
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F3F9 80 83
; ----------------------------------------------------------------------------
LF3FB:
        XRING                                   ; F3FB 00 62
        bcc     LF407                           ; F3FD 90 08
        XRD0                                    ; F3FF 00 08
        bcs     LF3FB                           ; F401 B0 F8
        cmp     #$03                            ; F403 C9 03
        bne     LF3FB                           ; F405 D0 F4
LF407:
        rts                                     ; F407 60

; ----------------------------------------------------------------------------
CONNECT_lfa:
        .addr   WCXFIN_lfa                      ; F408 1A F4
; ----------------------------------------------------------------------------
CONNECT_pfa:
        .byte   $01,$00,$C0,$60,$0E             ; F40A 01 00 C0 60 0E
; ----------------------------------------------------------------------------
CONNECT:
        .byte   "CONNECT"                       ; F40F 43 4F 4E 4E 45 43 54
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F416 80 02
; ----------------------------------------------------------------------------
        XLIGNE                                  ; F418 00 64

; ----------------------------------------------------------------------------
WCXFIN_lfa:
        .addr   UNCONNECT_lfa                   ; F41A 2B F4
; ----------------------------------------------------------------------------
WCXFIN_pfa:
        .byte   $01,$00,$C0,$61,$0D             ; F41C 01 00 C0 61 0D
; ----------------------------------------------------------------------------
WCXFIN:
        .byte   "WCXFIN"                        ; F421 57 43 58 46 49 4E
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F427 80 02
; ----------------------------------------------------------------------------
        XSCXFI                                  ; F429 00 63

; ----------------------------------------------------------------------------
UNCONNECT_lfa:
        .addr   SOUT_lfa                        ; F42B 3F F4
; ----------------------------------------------------------------------------
UNCONNECT_pfa:
        .byte   $01,$00,$C0,$62,$10             ; F42D 01 00 C0 62 10
; ----------------------------------------------------------------------------
UNCONNECT:
        .byte   "UNCONNECT"                     ; F432 55 4E 43 4F 4E 4E 45 43
                                                ; F43A 54
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; F43B 80 02
; ----------------------------------------------------------------------------
        XDECON                                  ; F43D 00 65

; ----------------------------------------------------------------------------
SOUT_lfa:
        .addr   MOUT_lfa                        ; F43F 52 F4
; ----------------------------------------------------------------------------
SOUT_pfa:
        .byte   $01,$00,$C0,$63,$0B             ; F441 01 00 C0 63 0B
; ----------------------------------------------------------------------------
SOUT:
        .byte   "SOUT"                          ; F446 53 4F 55 54
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F44A 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; F44C 20 4F D4
        SOUT                                    ; F44F 00 67
        rts                                     ; F451 60

; ----------------------------------------------------------------------------
MOUT_lfa:
        .addr   POS_lfa                         ; F452 65 F4
; ----------------------------------------------------------------------------
MOUT_pfa:
        .byte   $01,$00,$C0,$64,$0B             ; F454 01 00 C0 64 0B
; ----------------------------------------------------------------------------
MOUT:
        .byte   "MOUT"                          ; F459 4D 4F 55 54
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F45D 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; F45F 20 4F D4
        XMOUT                                   ; F462 00 66
        rts                                     ; F464 60

; ----------------------------------------------------------------------------
POS_lfa:
        .addr   DIR_lfa                         ; F465 84 F4
; ----------------------------------------------------------------------------
POS_pfa:
        .byte   $02,$02,$C0,$65,$0A             ; F467 02 02 C0 65 0A
; ----------------------------------------------------------------------------
POS:
        .byte   "POS"                           ; F46C 50 4F 53
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F46F 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; F471 20 F7 D1
        and     #$07                            ; F474 29 07
        tax                                     ; F476 AA
        ldy     SCRX,x                          ; F477 BC 20 02
        cmp     #$04                            ; F47A C9 04
        bcc     LF481                           ; F47C 90 03
        ldy     LPRX                            ; F47E AC 86 02
LF481:
        sty     FACC1M                          ; F481 84 61
        rts                                     ; F483 60

; ----------------------------------------------------------------------------
DIR_lfa:
        .addr   DELBAK_lfa                      ; F484 94 F4
; ----------------------------------------------------------------------------
DIR_pfa:
        .byte   $01,$00,$C0,$68,$0A             ; F486 01 00 C0 68 0A
; ----------------------------------------------------------------------------
DIR:
        .byte   "DIR"                           ; F48B 44 49 52
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F48E 96 83
; ----------------------------------------------------------------------------
LF490:
        lda     #$56                            ; F490 A9 56
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        bne     LF4D9                           ; F492 D0 45

; ----------------------------------------------------------------------------
DELBAK_lfa:
        .addr   DEL_lfa                         ; F494 A7 F4
; ----------------------------------------------------------------------------
DELBAK_pfa:
        .byte   $01,$00,$C0,$6A,$0D             ; F496 01 00 C0 6A 0D
; ----------------------------------------------------------------------------
DELBAK:
        .byte   "DELBAK"                        ; F49B 44 45 4C 42 41 4B
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F4A1 96 83
; ----------------------------------------------------------------------------
        lda     #$4A                            ; F4A3 A9 4A
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        bne     LF4D9                           ; F4A5 D0 32

; ----------------------------------------------------------------------------
DEL_lfa:
        .addr   PROT_lfa                        ; F4A7 B7 F4
; ----------------------------------------------------------------------------
DEL_pfa:
        .byte   $01,$00,$C0,$70,$0A             ; F4A9 01 00 C0 70 0A
; ----------------------------------------------------------------------------
DEL:
        .byte   "DEL"                           ; F4AE 44 45 4C
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F4B1 96 83
; ----------------------------------------------------------------------------
        lda     #$4D                            ; F4B3 A9 4D
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        bne     LF4D9                           ; F4B5 D0 22

; ----------------------------------------------------------------------------
PROT_lfa:
        .addr   UNPROT_lfa                      ; F4B7 C8 F4
; ----------------------------------------------------------------------------
PROT_pfa:
        .byte   $01,$00,$C0,$71,$0B             ; F4B9 01 00 C0 71 0B
; ----------------------------------------------------------------------------
PROT:
        .byte   "PROT"                          ; F4BE 50 52 4F 54
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F4C2 96 83
; ----------------------------------------------------------------------------
        lda     #$50                            ; F4C4 A9 50
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        bne     LF4D9                           ; F4C6 D0 11

; ----------------------------------------------------------------------------
UNPROT_lfa:
        .addr   INIT_lfa                        ; F4C8 E1 F4
; ----------------------------------------------------------------------------
UNPROT_pfa:
        .byte   $01,$00,$C0,$72,$0D             ; F4CA 01 00 C0 72 0D
; ----------------------------------------------------------------------------
UNPROT:
        .byte   "UNPROT"                        ; F4CF 55 4E 50 52 4F 54
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F4D5 96 83
; ----------------------------------------------------------------------------
        lda     #$53                            ; F4D7 A9 53
LF4D9:
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        pha                                     ; F4D9 48

        ; Vérification du nom de fichier demandé (modification du lecteur par défaut autorisée)
        jsr     LF995                           ; F4DA 20 95 F9

        pla                                     ; F4DD 68
        jmp     EXEDOS                          ; F4DE 4C 64 F9

; ----------------------------------------------------------------------------
INIT_lfa:
        .addr   LOAD_lfa                        ; F4E1 FB F4
; ----------------------------------------------------------------------------
INIT_pfa:
        .byte   $01,$00,$C0,$33,$0B             ; F4E3 01 00 C0 33 0B
; ----------------------------------------------------------------------------
INIT:
        .byte   "INIT"                          ; F4E8 49 4E 49 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F4EC 80 83
; ----------------------------------------------------------------------------
        lda     #$00                            ; F4EE A9 00
        sta     FISALO                          ; F4F0 8D 2F 05
        sta     FISALO+1                        ; F4F3 8D 30 05
        lda     #$5C                            ; F4F6 A9 5C
        jmp     EXEDOS                          ; F4F8 4C 64 F9

; ----------------------------------------------------------------------------
LOAD_lfa:
        .addr   SAVEM"_lfa                      ; F4FB 4A F5
; ----------------------------------------------------------------------------
LOAD_pfa:
        .byte   $01,$00,$C0,$74,$0B             ; F4FD 01 00 C0 74 0B
; ----------------------------------------------------------------------------
LOAD:
        .byte   "LOAD"                          ; F502 4C 4F 41 44
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; F506 82 83
; ----------------------------------------------------------------------------
        jsr     LF997                           ; F508 20 97 F9
LF50B:
        lda     #$68                            ; F50B A9 68
        jsr     EXEDOS                          ; F50D 20 64 F9
        lda     #$62                            ; F510 A9 62
        jsr     EXEDOS                          ; F512 20 64 F9
LF515:
        lda     FTYPE                           ; F515 AD 2C 05
        lsr     a                               ; F518 4A
        lda     FTYPE                           ; F519 AD 2C 05
        bpl     LF53D                           ; F51C 10 1F
        lda     FISALO                          ; F51E AD 2F 05
        ldy     FISALO+1                        ; F521 AC 30 05
        sta     SCEFIN                          ; F524 85 5E
        sty     SCEFIN+1                        ; F526 84 5F
        php                                     ; F528 08
        jsr     LCAE8                           ; F529 20 E8 CA
        plp                                     ; F52C 28
        bcc     LF53A                           ; F52D 90 0B
        ldx     #$00                            ; F52F A2 00
        jsr     LDA03                           ; F531 20 03 DA

        ; CLEAR
        jsr     LFDA5                           ; F534 20 A5 FD

        jmp     (ptr_07F9)                      ; F537 6C F9 07

; ----------------------------------------------------------------------------
LF53A:
        jmp     LC0FF                           ; F53A 4C FF C0

; ----------------------------------------------------------------------------
LF53D:
        bcc     LF549                           ; F53D 90 0A
        jmp     (EXSALO)                        ; F53F 6C 31 05

; ----------------------------------------------------------------------------
        ; Vérification du nom de fichier demandé (modification du lecteur par défaut autorisée)
        jsr     LF995                           ; F542 20 95 F9
        cmp     #$02                            ; F545 C9 02
        bne     LF50B                           ; F547 D0 C2
LF549:
        rts                                     ; F549 60

; ----------------------------------------------------------------------------
SAVEM"_lfa:
        .addr   SAVEO"_lfa                      ; F54A 5D F5
; ----------------------------------------------------------------------------
SAVEM"_pfa:
        .byte   $01,$00,$C0,$75,$0C             ; F54C 01 00 C0 75 0C
; ----------------------------------------------------------------------------
SAVEM":
        .byte   "SAVEM"                         ; F551 53 41 56 45 4D
        .byte   $22                             ; F556 22
; ----------------------------------------------------------------------------
        .byte   $C0,$4A,$03                     ; F557 C0 4A 03
; ----------------------------------------------------------------------------
        jsr     LF62E                           ; F55A 20 2E F6

; ----------------------------------------------------------------------------
SAVEO"_lfa:
        .addr   SAVEU"_lfa                      ; F55D 70 F5
; ----------------------------------------------------------------------------
SAVEO"_pfa:
        .byte   $01,$00,$C0,$76,$0C             ; F55F 01 00 C0 76 0C
; ----------------------------------------------------------------------------
SAVEO":
        .byte   "SAVEO"                         ; F564 53 41 56 45 4F
        .byte   $22                             ; F569 22
; ----------------------------------------------------------------------------
        .byte   $C0,$37,$03                     ; F56A C0 37 03
; ----------------------------------------------------------------------------
        jsr     LF62B                           ; F56D 20 2B F6

; ----------------------------------------------------------------------------
SAVEU"_lfa:
        .addr   SAVE"_lfa                       ; F570 83 F5
; ----------------------------------------------------------------------------
SAVEU"_pfa:
        .byte   $01,$00,$C0,$77,$0C             ; F572 01 00 C0 77 0C
; ----------------------------------------------------------------------------
SAVEU":
        .byte   "SAVEU"                         ; F577 53 41 56 45 55
        .byte   $22                             ; F57C 22
; ----------------------------------------------------------------------------
        .byte   $C0,$24,$03                     ; F57D C0 24 03
; ----------------------------------------------------------------------------
        jsr     LF631                           ; F580 20 31 F6

; ----------------------------------------------------------------------------
SAVE"_lfa:
        .addr   BACKUP_lfa                      ; F583 63 F6
; ----------------------------------------------------------------------------
SAVE"_pfa:
        .byte   $01,$00,$C0,$78,$0B             ; F585 01 00 C0 78 0B
; ----------------------------------------------------------------------------
SAVE":
        .byte   "SAVE"                          ; F58A 53 41 56 45
        .byte   $22                             ; F58E 22
; ----------------------------------------------------------------------------
        .byte   $C0,$11,$03                     ; F58F C0 11 03
; ----------------------------------------------------------------------------
        jsr     LF634                           ; F592 20 34 F6
LF595:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$36                            ; F595 A9 36
        jsr     LCA69                           ; F597 20 69 CA

LF59A:
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$31                            ; F59A A9 31
        jsr     LCA69                           ; F59C 20 69 CA

LF59F:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; F59F 20 88 C6
        beq     LF5B8                           ; F5A2 F0 14

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$09                            ; F5A4 A2 09
        jsr     LC676                           ; F5A6 20 76 C6

        ; Recherche le paramètre pointé par BUFEDT,$C4 dans la table InstParam_table (C=1 si trouvé)
        jsr     LCB50                           ; F5A9 20 50 CB
        bcc     LF5BA                           ; F5AC 90 0C

        stx     $C4                             ; F5AE 86 C4

        ; Compile ACC,#$FF en $600,$C5 et ajuste $C5 (ACC est inchangé)
        jsr     LCA7A                           ; F5B0 20 7A CA

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$32                            ; F5B3 A9 32
        jsr     LCA69                           ; F5B5 20 69 CA

LF5B8:
        clc                                     ; F5B8 18
        rts                                     ; F5B9 60

; ----------------------------------------------------------------------------
LF5BA:
        ; Saute les espaces jusqu'au prochain caractère dans BUFEDT
        jsr     LC688                           ; F5BA 20 88 C6
        jsr     LCB45                           ; F5BD 20 45 CB
        ldx     #$33                            ; F5C0 A2 33
        cmp     #$41                            ; F5C2 C9 41
        beq     LF5D0                           ; F5C4 F0 0A
        inx                                     ; F5C6 E8
        cmp     #$45                            ; F5C7 C9 45
        beq     LF5D0                           ; F5C9 F0 05
        inx                                     ; F5CB E8
        cmp     #$54                            ; F5CC C9 54
        bne     LF5E4                           ; F5CE D0 14
LF5D0:
        txa                                     ; F5D0 8A
        pha                                     ; F5D1 48
        clc                                     ; F5D2 18
        adc     #$04                            ; F5D3 69 04

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        jsr     LCA69                           ; F5D5 20 69 CA

        inc     $C4                             ; F5D8 E6 C4

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; F5DA 20 74 C6

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        pla                                     ; F5DD 68
        jsr     LCA69                           ; F5DE 20 69 CA

        jmp     LF59F                           ; F5E1 4C 9F F5

; ----------------------------------------------------------------------------
LF5E4:
        sec                                     ; F5E4 38
        rts                                     ; F5E5 60

; ----------------------------------------------------------------------------
LF5E6:
        lda     #$01                            ; F5E6 A9 01
        ora     FTYPE                           ; F5E8 0D 2C 05
        sta     FTYPE                           ; F5EB 8D 2C 05
        asl     a                               ; F5EE 0A
        bpl     LF5FD                           ; F5EF 10 0C
        lda     DESALO                          ; F5F1 AD 2D 05
        ldy     DESALO+1                        ; F5F4 AC 2E 05
        sta     EXSALO                          ; F5F7 8D 31 05
        sty     EXSALO+1                        ; F5FA 8C 32 05
LF5FD:
        rts                                     ; F5FD 60

; ----------------------------------------------------------------------------
LF5FE:
        jsr     GetWord                         ; F5FE 20 84 D4
        sta     DESALO                          ; F601 8D 2D 05
        sty     DESALO+1                        ; F604 8C 2E 05
        jmp     LF613                           ; F607 4C 13 F6

; ----------------------------------------------------------------------------
LF60A:
        jsr     GetWord                         ; F60A 20 84 D4
        sta     FISALO                          ; F60D 8D 2F 05
        sty     FISALO+1                        ; F610 8C 30 05
LF613:
        lda     #$40                            ; F613 A9 40
        sta     FTYPE                           ; F615 8D 2C 05
        rts                                     ; F618 60

; ----------------------------------------------------------------------------
LF619:
        jsr     GetWord                         ; F619 20 84 D4
        sta     EXSALO                          ; F61C 8D 31 05
        sty     EXSALO+1                        ; F61F 8C 32 05
        lda     #$01                            ; F622 A9 01
        ora     FTYPE                           ; F624 0D 2C 05
        sta     FTYPE                           ; F627 8D 2C 05
        rts                                     ; F62A 60

; ----------------------------------------------------------------------------
LF62B:
        lda     #$00                            ; F62B A9 00
        .byte   $2C                             ; F62D 2C
LF62E:
        lda     #$40                            ; F62E A9 40
        .byte   $2C                             ; F630 2C
LF631:
        lda     #$C0                            ; F631 A9 C0
        .byte   $2C                             ; F633 2C
LF634:
        lda     #$80                            ; F634 A9 80
        sta     VASALO0                         ; F636 8D 28 05
        jsr     LD138                           ; F639 20 38 D1
        lda     #$6B                            ; F63C A9 6B
        jmp     EXEDOS                          ; F63E 4C 64 F9

; ----------------------------------------------------------------------------
LF641:
        lda     SCEFIN                          ; F641 A5 5E
        ldy     SCEFIN+1                        ; F643 A4 5F
        sta     FISALO                          ; F645 8D 2F 05
        sty     FISALO+1                        ; F648 8C 30 05
        lda     #$F0                            ; F64B A9 F0
        ldy     #$07                            ; F64D A0 07
        sta     DESALO                          ; F64F 8D 2D 05
        sty     DESALO+1                        ; F652 8C 2E 05
        lda     #$00                            ; F655 A9 00
        sta     EXSALO                          ; F657 8D 31 05
        sta     EXSALO+1                        ; F65A 8D 32 05
        lda     #$80                            ; F65D A9 80
        sta     FTYPE                           ; F65F 8D 2C 05
        rts                                     ; F662 60

; ----------------------------------------------------------------------------
BACKUP_lfa:
        .addr   LDIR_lfa                        ; F663 90 F6
; ----------------------------------------------------------------------------
BACKUP_pfa:
        .byte   $01,$00,$C0,$79,$0D             ; F665 01 00 C0 79 0D
; ----------------------------------------------------------------------------
BACKUP:
        .byte   "BACKUP"                        ; F66A 42 41 43 4B 55 50
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F670 80 83
; ----------------------------------------------------------------------------
        jsr     LD155                           ; F672 20 55 D1
        lda     DRVDEF                          ; F675 AD 0C 02
        sta     BUFNOM                          ; F678 8D 17 05
        ldx     TABDRV+1                        ; F67B AE 09 02
        beq     LF682                           ; F67E F0 02
        lda     #$01                            ; F680 A9 01
LF682:
        sta     BUFNOM+1                        ; F682 8D 18 05
        lda     #$59                            ; F685 A9 59
        jsr     EXEDOS                          ; F687 20 64 F9
        jsr     LC384                           ; F68A 20 84 C3
        jmp     LDFEB                           ; F68D 4C EB DF

; ----------------------------------------------------------------------------
LDIR_lfa:
        .addr   DNAME_lfa                       ; F690 B1 F6
; ----------------------------------------------------------------------------
LDIR_pfa:
        .byte   $01,$00,$C0,$7B,$0B             ; F692 01 00 C0 7B 0B
; ----------------------------------------------------------------------------
LDIR:
        .byte   "LDIR"                          ; F697 4C 44 49 52
; ----------------------------------------------------------------------------
        .byte   $96,$83                         ; F69B 96 83
; ----------------------------------------------------------------------------
        lda     #$88                            ; F69D A9 88
        XCL0                                    ; F69F 00 04
        lda     #$8E                            ; F6A1 A9 8E
        XOP0                                    ; F6A3 00 00

        ; DIR
        jsr     LF490                           ; F6A5 20 90 F4

        lda     #$8E                            ; F6A8 A9 8E
        XCL0                                    ; F6AA 00 04
        lda     #$88                            ; F6AC A9 88
        XOP0                                    ; F6AE 00 00
        rts                                     ; F6B0 60

; ----------------------------------------------------------------------------
DNAME_lfa:
        .addr   COPYO_lfa                       ; F6B1 C4 F6
; ----------------------------------------------------------------------------
DNAME_pfa:
        .byte   $01,$00,$C0,$7C,$0C             ; F6B3 01 00 C0 7C 0C
; ----------------------------------------------------------------------------
DNAME:
        .byte   "DNAME"                         ; F6B8 44 4E 41 4D 45
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; F6BD 82 83
; ----------------------------------------------------------------------------
        lda     #$3B                            ; F6BF A9 3B
        jmp     EXEDOS                          ; F6C1 4C 64 F9

; ----------------------------------------------------------------------------
COPYO_lfa:
        .addr   COPYM_lfa                       ; F6C4 D7 F6
; ----------------------------------------------------------------------------
COPYO_pfa:
        .byte   $01,$00,$C0,$7D,$0C             ; F6C6 01 00 C0 7D 0C
; ----------------------------------------------------------------------------
COPYO:
        .byte   "COPYO"                         ; F6CB 43 4F 50 59 4F
; ----------------------------------------------------------------------------
        .byte   $C0,$45,$83                     ; F6D0 C0 45 83
; ----------------------------------------------------------------------------
        lda     #$00                            ; F6D3 A9 00
        beq     LF6FA                           ; F6D5 F0 23

; ----------------------------------------------------------------------------
COPYM_lfa:
        .addr   COPY_lfa                        ; F6D7 EA F6
; ----------------------------------------------------------------------------
COPYM_pfa:
        .byte   $01,$00,$C0,$7E,$0C             ; F6D9 01 00 C0 7E 0C
; ----------------------------------------------------------------------------
COPYM:
        .byte   "COPYM"                         ; F6DE 43 4F 50 59 4D
; ----------------------------------------------------------------------------
        .byte   $C0,$32,$83                     ; F6E3 C0 32 83
; ----------------------------------------------------------------------------
        lda     #$40                            ; F6E6 A9 40
        bne     LF6FA                           ; F6E8 D0 10

; ----------------------------------------------------------------------------
COPY_lfa:
        .addr   REN_lfa                         ; F6EA 0D F7
; ----------------------------------------------------------------------------
COPY_pfa:
        .byte   $01,$00,$C0,$7F,$0B             ; F6EC 01 00 C0 7F 0B
; ----------------------------------------------------------------------------
COPY:
        .byte   "COPY"                          ; F6F1 43 4F 50 59
; ----------------------------------------------------------------------------
        .byte   $C0,$1F,$83                     ; F6F5 C0 1F 83
; ----------------------------------------------------------------------------
        lda     #$80                            ; F6F8 A9 80
LF6FA:
        sta     VASALO0                         ; F6FA 8D 28 05
        lda     #$00                            ; F6FD A9 00
        sta     $0529                           ; F6FF 8D 29 05
        jsr     LF722                           ; F702 20 22 F7
        lda     #$38                            ; F705 A9 38
        jmp     EXEDOS                          ; F707 4C 64 F9

; ----------------------------------------------------------------------------
        jmp     LF738                           ; F70A 4C 38 F7

; ----------------------------------------------------------------------------
REN_lfa:
        .addr   ESAVE_lfa                       ; F70D 4F F7
; ----------------------------------------------------------------------------
REN_pfa:
        .byte   $01,$00,$C0,$80,$0A             ; F70F 01 00 C0 80 0A
; ----------------------------------------------------------------------------
REN:
        .byte   "REN"                           ; F714 52 45 4E
; ----------------------------------------------------------------------------
        .byte   $C0,$2A,$83                     ; F717 C0 2A 83
; ----------------------------------------------------------------------------
        jsr     LF722                           ; F71A 20 22 F7
        lda     #$47                            ; F71D A9 47
        jmp     EXEDOS                          ; F71F 4C 64 F9

; ----------------------------------------------------------------------------
LF722:
        ; AY: Nom du fichier, X: longueur du nom
        ldx     $9D                             ; F722 A6 9D
        lda     $9E                             ; F724 A5 9E
        ldy     $9F                             ; F726 A4 9F
        XNOMFI                                  ; F728 00 24

        ; Copie BUFNOM à la base de la pile 6502 (BUFTRV)
        ldx     #$0C                            ; F72A A2 0C
LF72C:
        lda     BUFNOM,x                        ; F72C BD 17 05
        sta     L0100,x                         ; F72F 9D 00 01
        dex                                     ; F732 CA
        bpl     LF72C                           ; F733 10 F7

        ; Vérification du nom de fichier demandé (modification du lecteur par défaut autorisée)
        jmp     LF995                           ; F735 4C 95 F9

; ----------------------------------------------------------------------------
LF738:
        jsr     LF749                           ; F738 20 49 F7
        bcs     LF74E                           ; F73B B0 11

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$11                            ; F73D A2 11
        jsr     LC676                           ; F73F 20 76 C6
        bcs     LF74E                           ; F742 B0 0A

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$45                            ; F744 A9 45
        jsr     LCA69                           ; F746 20 69 CA

LF749:
        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$02                            ; F749 A2 02
        jmp     LC676                           ; F74B 4C 76 C6

; ----------------------------------------------------------------------------
LF74E:
        rts                                     ; F74E 60

; ----------------------------------------------------------------------------
ESAVE_lfa:
        .addr   OPEN_lfa                        ; F74F 65 F7
; ----------------------------------------------------------------------------
ESAVE_pfa:
        .byte   $01,$00,$C0,$83,$0C             ; F751 01 00 C0 83 0C
; ----------------------------------------------------------------------------
ESAVE:
        .byte   "ESAVE"                         ; F756 45 53 41 56 45
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; F75B 82 83
; ----------------------------------------------------------------------------
        jsr     LF997                           ; F75D 20 97 F9
        lda     #$35                            ; F760 A9 35
        jmp     EXEDOS                          ; F762 4C 64 F9

; ----------------------------------------------------------------------------
OPEN_lfa:
        .addr   CLOSE_lfa                       ; F765 92 F7
; ----------------------------------------------------------------------------
OPEN_pfa:
        .byte   $01,$00,$C0,$84,$0B             ; F767 01 00 C0 84 0B
; ----------------------------------------------------------------------------
OPEN:
        .byte   "OPEN"                          ; F76C 4F 50 45 4E
; ----------------------------------------------------------------------------
        .byte   $01,$01,$82,$83                 ; F770 01 01 82 83
; ----------------------------------------------------------------------------
        jsr     LD44C                           ; F774 20 4C D4
        ldx     #$10                            ; F777 A2 10
        cmp     #$01                            ; F779 C9 01
        bcc     LF781                           ; F77B 90 04
        bne     LF7A8                           ; F77D D0 29
        ldx     #$08                            ; F77F A2 08
LF781:
        stx     FTYPE                           ; F781 8E 2C 05
        jsr     LF997                           ; F784 20 97 F9
        jsr     LD449                           ; F787 20 49 D4
        sta     FICNUM                          ; F78A 8D 48 05
        lda     #$1A                            ; F78D A9 1A
        jmp     EXEDOS                          ; F78F 4C 64 F9

; ----------------------------------------------------------------------------
CLOSE_lfa:
        .addr   PUT_lfa                         ; F792 09 F8
; ----------------------------------------------------------------------------
CLOSE_pfa:
        .byte   $01,$00,$C0,$85,$0C             ; F794 01 00 C0 85 0C
; ----------------------------------------------------------------------------
CLOSE:
        .byte   "CLOSE"                         ; F799 43 4C 4F 53 45
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F79E 81 83
; ----------------------------------------------------------------------------
        jsr     LF8E1                           ; F7A0 20 E1 F8
        lda     #$1D                            ; F7A3 A9 1D
        jmp     EXEDOS                          ; F7A5 4C 64 F9

; ----------------------------------------------------------------------------
LF7A8:
        jmp     Error_BADVAL                    ; F7A8 4C FF F0

; ----------------------------------------------------------------------------
        ldx     #$09                            ; F7AB A2 09
        lda     FACC1S                          ; F7AD A5 65
        bpl     LF7B2                           ; F7AF 10 01
        dex                                     ; F7B1 CA
LF7B2:
        stx     $94                             ; F7B2 86 94
        ldx     DECFIN                          ; F7B4 A6 06
        ldy     DECFIN+1                        ; F7B6 A4 07
        clc                                     ; F7B8 18
        and     #$7F                            ; F7B9 29 7F
        adc     #$07                            ; F7BB 69 07
        jsr     LC9EA                           ; F7BD 20 EA C9
        bcc     LF7C7                           ; F7C0 90 05
        lda     #$00                            ; F7C2 A9 00
        sta     FACC1E                          ; F7C4 85 60
LF7C6:
        rts                                     ; F7C6 60

; ----------------------------------------------------------------------------
LF7C7:
        ldy     #$06                            ; F7C7 A0 06
        lda     $92                             ; F7C9 A5 92
        ldx     $93                             ; F7CB A6 93
        sta     $BC                             ; F7CD 85 BC
        stx     $BD                             ; F7CF 86 BD
        adc     ($92),y                         ; F7D1 71 92
        bcc     LF7D6                           ; F7D3 90 01
        inx                                     ; F7D5 E8
LF7D6:
        sta     $C4                             ; F7D6 85 C4
        stx     $C5                             ; F7D8 86 C5
        bit     $51                             ; F7DA 24 51
        bpl     LF806                           ; F7DC 10 28
        ldy     #$04                            ; F7DE A0 04
LF7E0:
        lda     ($C4),y                         ; F7E0 B1 C4
        sta     FACC1E,y                        ; F7E2 99 60 00
        dey                                     ; F7E5 88
        bpl     LF7E0                           ; F7E6 10 F8
        bit     FACC1S                          ; F7E8 24 65
        bmi     LF7C6                           ; F7EA 30 DA
        ldy     #$03                            ; F7EC A0 03
        lda     ($BC),y                         ; F7EE B1 BC
        bne     LF7C6                           ; F7F0 D0 D4
        sta     $BA                             ; F7F2 85 BA
        lda     FACC1E                          ; F7F4 A5 60
        ldx     FACC1M                          ; F7F6 A6 61
        sta     FACC1M                          ; F7F8 85 61
        stx     FACC1M+1                        ; F7FA 86 62
        jsr     LD23B                           ; F7FC 20 3B D2
        lda     FACC1M                          ; F7FF A5 61
        and     #$7F                            ; F801 29 7F
        sta     FACC1M                          ; F803 85 61
        rts                                     ; F805 60

; ----------------------------------------------------------------------------
LF806:
        jmp     LF8C9                           ; F806 4C C9 F8

; ----------------------------------------------------------------------------
PUT_lfa:
        .addr   TAKE_lfa                        ; F809 1A F8
; ----------------------------------------------------------------------------
PUT_pfa:
        .byte   $01,$00,$C0,$86,$0A             ; F80B 01 00 C0 86 0A
; ----------------------------------------------------------------------------
PUT:
        .byte   "PUT"                           ; F810 50 55 54
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F813 01 81 83
; ----------------------------------------------------------------------------
        lda     #$23                            ; F816 A9 23
        bne     LF82A                           ; F818 D0 10

; ----------------------------------------------------------------------------
TAKE_lfa:
        .addr   JUMP_lfa                        ; F81A 4B F8
; ----------------------------------------------------------------------------
TAKE_pfa:
        .byte   $01,$00,$C0,$87,$0B             ; F81C 01 00 C0 87 0B
; ----------------------------------------------------------------------------
TAKE:
        .byte   "TAKE"                          ; F821 54 41 4B 45
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F825 01 81 83
; ----------------------------------------------------------------------------
        lda     #$20                            ; F828 A9 20
LF82A:
        ldx     vnmi                            ; F82A AE F4 02
        stx     XFIELD                          ; F82D 8E 4C 05
        ldx     #$AB                            ; F830 A2 AB
        ldy     #$F7                            ; F832 A0 F7
        stx     $054D                           ; F834 8E 4D 05
        sty     $054E                           ; F837 8C 4E 05
LF83A:
        pha                                     ; F83A 48
        jsr     LF8E7                           ; F83B 20 E7 F8
        jsr     GetWord                         ; F83E 20 84 D4
        sta     DESALO                          ; F841 8D 2D 05
        sty     DESALO+1                        ; F844 8C 2E 05
        pla                                     ; F847 68
        jmp     EXEDOS                          ; F848 4C 64 F9

; ----------------------------------------------------------------------------
JUMP_lfa:
        .addr   APPEND_lfa                      ; F84B 5D F8
; ----------------------------------------------------------------------------
JUMP_pfa:
        .byte   $01,$00,$C0,$88,$0B             ; F84D 01 00 C0 88 0B
; ----------------------------------------------------------------------------
JUMP:
        .byte   "JUMP"                          ; F852 4A 55 4D 50
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; F856 01 81 83
; ----------------------------------------------------------------------------
        lda     #$2C                            ; F859 A9 2C
        bne     LF83A                           ; F85B D0 DD

; ----------------------------------------------------------------------------
APPEND_lfa:
        .addr   REWIND_lfa                      ; F85D 70 F8
; ----------------------------------------------------------------------------
APPEND_pfa:
        .byte   $01,$00,$C0,$89,$0D             ; F85F 01 00 C0 89 0D
; ----------------------------------------------------------------------------
APPEND:
        .byte   "APPEND"                        ; F864 41 50 50 45 4E 44
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F86A 81 83
; ----------------------------------------------------------------------------
        lda     #$26                            ; F86C A9 26
        bne     LF881                           ; F86E D0 11

; ----------------------------------------------------------------------------
REWIND_lfa:
        .addr   SPUT_lfa                        ; F870 89 F8
; ----------------------------------------------------------------------------
REWIND_pfa:
        .byte   $01,$00,$C0,$8A,$0D             ; F872 01 00 C0 8A 0D
; ----------------------------------------------------------------------------
REWIND:
        .byte   "REWIND"                        ; F877 52 45 57 49 4E 44
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F87D 81 83
; ----------------------------------------------------------------------------
        lda     #$29                            ; F87F A9 29
LF881:
        pha                                     ; F881 48
        jsr     LF8E1                           ; F882 20 E1 F8
        pla                                     ; F885 68
        jmp     EXEDOS                          ; F886 4C 64 F9

; ----------------------------------------------------------------------------
SPUT_lfa:
        .addr   STAKE_lfa                       ; F889 B1 F8
; ----------------------------------------------------------------------------
SPUT_pfa:
        .byte   $01,$00,$C0,$8B,$0B             ; F88B 01 00 C0 8B 0B
; ----------------------------------------------------------------------------
SPUT:
        .byte   "SPUT"                          ; F890 53 50 55 54
; ----------------------------------------------------------------------------
        .byte   $01,$84,$83                     ; F894 01 84 83
; ----------------------------------------------------------------------------
        jsr     LF8E7                           ; F897 20 E7 F8
        lda     $BA                             ; F89A A5 BA
        bmi     LF8AA                           ; F89C 30 0C
        jsr     LD23B                           ; F89E 20 3B D2
        lda     FACC1S                          ; F8A1 A5 65
        ora     #$7F                            ; F8A3 09 7F
        and     FACC1M                          ; F8A5 25 61
        sta     FACC1M                          ; F8A7 85 61
        lsr     a                               ; F8A9 4A
LF8AA:
        sta     FACC1S                          ; F8AA 85 65
        lda     #$14                            ; F8AC A9 14
        jmp     EXEDOS                          ; F8AE 4C 64 F9

; ----------------------------------------------------------------------------
STAKE_lfa:
        .addr   FST_lfa                         ; F8B1 EE F8
; ----------------------------------------------------------------------------
STAKE_pfa:
        .byte   $01,$00,$C0,$8C,$0C             ; F8B3 01 00 C0 8C 0C
; ----------------------------------------------------------------------------
STAKE:
        .byte   "STAKE"                         ; F8B8 53 54 41 4B 45
; ----------------------------------------------------------------------------
        .byte   $01,$27,$EF,$83                 ; F8BD 01 27 EF 83
; ----------------------------------------------------------------------------
        jsr     LF8E7                           ; F8C1 20 E7 F8
        lda     #$17                            ; F8C4 A9 17
        jsr     EXEDOS                          ; F8C6 20 64 F9
LF8C9:
        lda     FACC1S                          ; F8C9 A5 65
        bmi     LF8DB                           ; F8CB 30 0E
        lda     FACC1M                          ; F8CD A5 61
        sta     FACC1S                          ; F8CF 85 65
        ora     #$80                            ; F8D1 09 80
        sta     FACC1M                          ; F8D3 85 61
        lda     #$40                            ; F8D5 A9 40
        sta     $BA                             ; F8D7 85 BA
        bne     LF8DE                           ; F8D9 D0 03
LF8DB:
        jsr     LCF5C                           ; F8DB 20 5C CF
LF8DE:
        jmp     LD28F                           ; F8DE 4C 8F D2

; ----------------------------------------------------------------------------
LF8E1:
        jsr     GetByte                         ; F8E1 20 4F D4
        jmp     LF8EA                           ; F8E4 4C EA F8

; ----------------------------------------------------------------------------
LF8E7:
        jsr     LD44C                           ; F8E7 20 4C D4
LF8EA:
        sta     FICNUM                          ; F8EA 8D 48 05
        rts                                     ; F8ED 60

; ----------------------------------------------------------------------------
FST_lfa:
        .addr   FILE_lfa                        ; F8EE 0D F9
; ----------------------------------------------------------------------------
FST_pfa:
        .byte   $02,$02,$C0,$8F,$0A             ; F8F0 02 02 C0 8F 0A
; ----------------------------------------------------------------------------
FST:
        .byte   "FST"                           ; F8F5 46 53 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; F8F8 80 83
; ----------------------------------------------------------------------------
        jsr     LD22E                           ; F8FA 20 2E D2
        sta     FICNUM                          ; F8FD 8D 48 05
        lda     #$11                            ; F900 A9 11
        jsr     EXEDOS                          ; F902 20 64 F9
        lda     FACC1M                          ; F905 A5 61
        jmp     LE7FC                           ; F907 4C FC E7

; ----------------------------------------------------------------------------
LF90A:
        jmp     Error_BADVAL                    ; F90A 4C FF F0

; ----------------------------------------------------------------------------
FILE_lfa:
        .addr   MERGE_lfa                       ; F90D 4E F9
; ----------------------------------------------------------------------------
FILE_pfa:
        .byte   $01,$00,$C0,$90,$0B             ; F90F 01 00 C0 90 0B
; ----------------------------------------------------------------------------
FILE:
        .byte   "FILE"                          ; F914 46 49 4C 45
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; F918 81 83
; ----------------------------------------------------------------------------
        jsr     LF8E1                           ; F91A 20 E1 F8
        tax                                     ; F91D AA
        beq     LF90A                           ; F91E F0 EA
        cmp     #$11                            ; F920 C9 11
        bcs     LF90A                           ; F922 B0 E6
        sta     NBFIC                           ; F924 8D 49 05
        lda     #$FF                            ; F927 A9 FF
        sta     BITMFC                          ; F929 8D 44 05
        sta     BITMFC+1                        ; F92C 8D 45 05
        lda     #$2F                            ; F92F A9 2F
        jsr     EXEDOS                          ; F931 20 64 F9
        sec                                     ; F934 38
        lda     ptr_07F9                        ; F935 AD F9 07
        sbc     DECDEB                          ; F938 E5 04
        sta     $07B5                           ; F93A 8D B5 07
        sta     TAMPFC                          ; F93D 8D 42 05
        lda     ptr_07F9+1                      ; F940 AD FA 07
        sbc     DECDEB+1                        ; F943 E5 05
        sta     $07B6                           ; F945 8D B6 07
        sta     TAMPFC+1                        ; F948 8D 43 05

        ; CLEAR
        jmp     LFDA5                           ; F94B 4C A5 FD

; ----------------------------------------------------------------------------
MERGE_lfa:
        .addr   CURSET_lfa                      ; F94E 36 FA
; ----------------------------------------------------------------------------
MERGE_pfa:
        .byte   $01,$00,$C0,$91,$0C             ; F950 01 00 C0 91 0C
; ----------------------------------------------------------------------------
MERGE:
        .byte   "MERGE"                         ; F955 4D 45 52 47 45
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; F95A 82 83
; ----------------------------------------------------------------------------
        lda     #$0E                            ; F95C A9 0E
        ; Vérification du nom de fichier demandé et appel fonction STRATSED en ACC
        jsr     LF4D9                           ; F95E 20 D9 F4

        jmp     LC068                           ; F961 4C 68 C0

; ----------------------------------------------------------------------------
;LF964:
; Appel à une fonction STRATSED(n° fonction dans ACC)
EXEDOS:
        ; Poids faible (vecteur STRATSED)
        sta     VEXBNK+1                        ; F964 8D 15 04
        ; Sauvegarde P,X
        php                                     ; F967 08
        txa                                     ; F968 8A
        pha                                     ; F969 48

        ; Vérification de la présence ou non du STRATSED (sortie en erreur le cas échéant)
        jsr     LD15B                           ; F96A 20 5B D1

        ; Poids fort toujours à $FF
        lda     #$FF                            ; F96D A9 FF
        sta     VEXBNK+2                        ; F96F 8D 16 04
        ; Banque = 0
        lda     #$00                            ; F972 A9 00
        sta     BNKCID                          ; F974 8D 17 04

        sta     $0512                           ; F977 8D 12 05

        ; Récupère X
        pla                                     ; F97A 68

        ; Saute 2 adresses de retour
        tsx                                     ; F97B BA
        dex                                     ; F97C CA
        dex                                     ; F97D CA
        dex                                     ; F97E CA
        dex                                     ; F97F CA
        stx     SAVES                           ; F980 8E 13 05

        ; Restaure X
        tax                                     ; F983 AA
        ; Appel au STRATSED
        jsr     EXBNK                           ; F984 20 0C 04

        ; Restaure P
        plp                                     ; F987 28

        ; Erreur?
        lda     $0512                           ; F988 AD 12 05
        beq     LF994                           ; F98B F0 07

        ; Erreur STRATSED+3
        clc                                     ; F98D 18
        adc     #$03                            ; F98E 69 03
        tax                                     ; F990 AA
        jmp     Error_X                         ; F991 4C 7E D1

; ----------------------------------------------------------------------------
LF994:
        rts                                     ; F994 60

; ----------------------------------------------------------------------------
; Vérification du nom de fichier demandé

LF995:
        ; Modification du lecteur par défaut autorisée
        clc                                     ; F995 18
        .byte   $24                             ; F996 24
LF997:
        ; Modification du lecteur par défaut interdite
        sec                                     ; F997 38
        php                                     ; F998 08

        ; Vérification de la présence ou non du STRATSED (sortie en erreur le cas échéant)
        jsr     LD15B                           ; F999 20 5B D1

        ; Vérification du nom du fichier
        ; Code erreur dans X
        ldx     FACC1E                          ; F99C A6 60
        lda     FACC1M                          ; F99E A5 61
        ldy     FACC1M+1                        ; F9A0 A4 62
        XNOMFI                                  ; F9A2 00 24
        txa                                     ; F9A4 8A
        bmi     Error_FNAME                     ; F9A5 30 1C

        plp                                     ; F9A7 28
        ldx     BUFNOM                          ; F9A8 AE 17 05
        bcc     LF9B1                           ; F9AB 90 04

        ; Modification du lecteur par défaut?
        cmp     #$02                            ; F9AD C9 02
        beq     Error_FNAME                     ; F9AF F0 12

LF9B1:
        ;
        cmp     #$02                            ; F9B1 C9 02
        bne     LF9B8                           ; F9B3 D0 03
        ldx     DRVDEF                          ; F9B5 AE 0C 02

LF9B8:
        ; Vérifie que le lecteur demandé est en ligne
        stx     DRIVE                           ; F9B8 8E 00 05
        ldy     TABDRV,x                        ; F9BB BC 08 02
        bne     LF994                           ; F9BE D0 D4
        ldx     #$0D                            ; F9C0 A2 0D
        .byte   $2C                             ; F9C2 2C
; Erreur: 'nom de fichier incorrect' ou 'lecteur absent' via $F9C0
Error_FNAME:
        ldx     #$0C                            ; F9C3 A2 0C
        jmp     Error_X                         ; F9C5 4C 7E D1

; ----------------------------------------------------------------------------
LF9C8:
        sty     L07EA+1                         ; F9C8 8C EB 07
        pha                                     ; F9CB 48
        jsr     LD14F                           ; F9CC 20 4F D1
        jsr     GetByte                         ; F9CF 20 4F D4
        cmp     #$04                            ; F9D2 C9 04
        bcs     LFA25                           ; F9D4 B0 4F
        lsr     a                               ; F9D6 4A
        ror     a                               ; F9D7 6A
        ror     a                               ; F9D8 6A
        sta     $57                             ; F9D9 85 57
        sec                                     ; F9DB 38
        pla                                     ; F9DC 68
        sec                                     ; F9DD 38
        bcs     LF9E4                           ; F9DE B0 04
LF9E0:
        clc                                     ; F9E0 18
        sty     L07EA+1                         ; F9E1 8C EB 07
LF9E4:
        sta     TR7                             ; F9E4 85 13
        ror     TR6                             ; F9E6 66 12
        lda     #$00                            ; F9E8 A9 00
        sta     $90                             ; F9EA 85 90
        sta     HRSERR                          ; F9EC 8D AB 02
        dec     TR7                             ; F9EF C6 13
        beq     LFA13                           ; F9F1 F0 20
        ldx     #$00                            ; F9F3 A2 00
        jsr     LFA28                           ; F9F5 20 28 FA
        dec     TR7                             ; F9F8 C6 13
        beq     LFA13                           ; F9FA F0 17
        ldx     #$06                            ; F9FC A2 06
        jsr     LFA28                           ; F9FE 20 28 FA
        dec     TR7                             ; FA01 C6 13
        beq     LFA13                           ; FA03 F0 0E
        ldx     #$0C                            ; FA05 A2 0C
        jsr     LFA28                           ; FA07 20 28 FA
        dec     TR7                             ; FA0A C6 13
        beq     LFA13                           ; FA0C F0 05
        ldx     #$12                            ; FA0E A2 12
        jsr     LFA28                           ; FA10 20 28 FA
LFA13:
        bit     TR6                             ; FA13 24 12
        bmi     LFA1C                           ; FA15 30 05
        ldx     #$C3                            ; FA17 A2 C3
        jsr     LFA28                           ; FA19 20 28 FA
LFA1C:
        jsr     L07EA                           ; FA1C 20 EA 07
        lda     HRSERR                          ; FA1F AD AB 02
        bne     LFA25                           ; FA22 D0 01
        rts                                     ; FA24 60

; ----------------------------------------------------------------------------
LFA25:
        jmp     Error_BADVAL                    ; FA25 4C FF F0

; ----------------------------------------------------------------------------
LFA28:
        jsr     LD459                           ; FA28 20 59 D4
        ldx     $90                             ; FA2B A6 90
        sta     $4D,x                           ; FA2D 95 4D
        sty     $4E,x                           ; FA2F 94 4E
        inc     $90                             ; FA31 E6 90
        inc     $90                             ; FA33 E6 90
        rts                                     ; FA35 60

; ----------------------------------------------------------------------------
CURSET_lfa:
        .addr   CURMOV_lfa                      ; FA36 4B FA
; ----------------------------------------------------------------------------
CURSET_pfa:
        .byte   $01,$00,$C0,$A0,$0D             ; FA38 01 00 C0 A0 0D
; ----------------------------------------------------------------------------
CURSET:
        .byte   "CURSET"                        ; FA3D 43 55 52 53 45 54
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FA43 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$90                            ; FA47 A0 90
        bne     LFA71                           ; FA49 D0 26

; ----------------------------------------------------------------------------
CURMOV_lfa:
        .addr   DRAW_lfa                        ; FA4B 60 FA
; ----------------------------------------------------------------------------
CURMOV_pfa:
        .byte   $01,$00,$C0,$A1,$0D             ; FA4D 01 00 C0 A1 0D
; ----------------------------------------------------------------------------
CURMOV:
        .byte   "CURMOV"                        ; FA52 43 55 52 4D 4F 56
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FA58 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$91                            ; FA5C A0 91
        bne     LFA71                           ; FA5E D0 11

; ----------------------------------------------------------------------------
DRAW_lfa:
        .addr   ADRAW_lfa                       ; FA60 76 FA
; ----------------------------------------------------------------------------
DRAW_pfa:
        .byte   $01,$00,$C0,$A2,$0B             ; FA62 01 00 C0 A2 0B
; ----------------------------------------------------------------------------
DRAW:
        .byte   "DRAW"                          ; FA67 44 52 41 57
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FA6B 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$8E                            ; FA6F A0 8E
LFA71:
        lda     #$03                            ; FA71 A9 03
LFA73:
        jmp     LF9C8                           ; FA73 4C C8 F9

; ----------------------------------------------------------------------------
ADRAW_lfa:
        .addr   CIRCLE_lfa                      ; FA76 8E FA
; ----------------------------------------------------------------------------
ADRAW_pfa:
        .byte   $01,$00,$C0,$A3,$0C             ; FA78 01 00 C0 A3 0C
; ----------------------------------------------------------------------------
ADRAW:
        .byte   "ADRAW"                         ; FA7D 41 44 52 41 57
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$01,$81,$83         ; FA82 01 01 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$8D                            ; FA88 A0 8D
LFA8A:
        lda     #$05                            ; FA8A A9 05
        bne     LFA73                           ; FA8C D0 E5

; ----------------------------------------------------------------------------
CIRCLE_lfa:
        .addr   BOX_lfa                         ; FA8E A4 FA
; ----------------------------------------------------------------------------
CIRCLE_pfa:
        .byte   $01,$00,$C0,$A4,$0D             ; FA90 01 00 C0 A4 0D
; ----------------------------------------------------------------------------
CIRCLE:
        .byte   "CIRCLE"                        ; FA95 43 49 52 43 4C 45
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; FA9B 01 81 83
; ----------------------------------------------------------------------------
        lda     #$02                            ; FA9E A9 02
        ldy     #$8F                            ; FAA0 A0 8F
        bne     LFA73                           ; FAA2 D0 CF

; ----------------------------------------------------------------------------
BOX_lfa:
        .addr   ABOX_lfa                        ; FAA4 B6 FA
; ----------------------------------------------------------------------------
BOX_pfa:
        .byte   $01,$00,$C0,$A5,$0A             ; FAA6 01 00 C0 A5 0A
; ----------------------------------------------------------------------------
BOX:
        .byte   "BOX"                           ; FAAB 42 4F 58
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FAAE 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$94                            ; FAB2 A0 94
        bne     LFA71                           ; FAB4 D0 BB

; ----------------------------------------------------------------------------
ABOX_lfa:
        .addr   PAPER_lfa                       ; FAB6 CB FA
; ----------------------------------------------------------------------------
ABOX_pfa:
        .byte   $01,$00,$C0,$A6,$0B             ; FAB8 01 00 C0 A6 0B
; ----------------------------------------------------------------------------
ABOX:
        .byte   "ABOX"                          ; FABD 41 42 4F 58
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$01,$81,$83         ; FAC1 01 01 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$95                            ; FAC7 A0 95
        bne     LFA8A                           ; FAC9 D0 BF

; ----------------------------------------------------------------------------
PAPER_lfa:
        .addr   INK_lfa                         ; FACB DC FA
; ----------------------------------------------------------------------------
PAPER_pfa:
        .byte   $01,$00,$C0,$A7,$0C             ; FACD 01 00 C0 A7 0C
; ----------------------------------------------------------------------------
PAPER:
        .byte   "PAPER"                         ; FAD2 50 41 50 45 52
; ----------------------------------------------------------------------------
        .byte   $81,$03                         ; FAD7 81 03
; ----------------------------------------------------------------------------
        jsr     LFAEA                           ; FAD9 20 EA FA

; ----------------------------------------------------------------------------
INK_lfa:
        .addr   RADIAN_lfa                      ; FADC 06 FB
; ----------------------------------------------------------------------------
INK_pfa:
        .byte   $01,$00,$C0,$A8,$0A             ; FADE 01 00 C0 A8 0A
; ----------------------------------------------------------------------------
INK:
        .byte   "INK"                           ; FAE3 49 4E 4B
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; FAE6 81 83
; ----------------------------------------------------------------------------
        sec                                     ; FAE8 38
        .byte   $24                             ; FAE9 24
LFAEA:
        clc                                     ; FAEA 18
        php                                     ; FAEB 08
        jsr     GetByte                         ; FAEC 20 4F D4
        plp                                     ; FAEF 28
        php                                     ; FAF0 08
        bcs     LFAF5                           ; FAF1 B0 02
        ora     #$10                            ; FAF3 09 10
LFAF5:
        pha                                     ; FAF5 48
        lda     FLGTEL                          ; FAF6 AD 0D 02
        and     #$80                            ; FAF9 29 80
        tax                                     ; FAFB AA
        pla                                     ; FAFC 68
        plp                                     ; FAFD 28
        bcc     LFB03                           ; FAFE 90 03
        XINK                                    ; FB00 00 93
        rts                                     ; FB02 60

; ----------------------------------------------------------------------------
LFB03:
        XPAPER                                  ; FB03 00 92
        rts                                     ; FB05 60

; ----------------------------------------------------------------------------
RADIAN_lfa:
        .addr   DEGRE_lfa                       ; FB06 1E FB
; ----------------------------------------------------------------------------
RADIAN_pfa:
        .byte   $01,$00,$C0,$A9,$0D             ; FB08 01 00 C0 A9 0D
; ----------------------------------------------------------------------------
RADIAN:
        .byte   "RADIAN"                        ; FB0D 52 41 44 49 41 4E
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FB13 80 83
; ----------------------------------------------------------------------------
        lda     FLGTEL                          ; FB15 AD 0D 02
        and     #$DF                            ; FB18 29 DF
        sta     FLGTEL                          ; FB1A 8D 0D 02
        rts                                     ; FB1D 60

; ----------------------------------------------------------------------------
DEGRE_lfa:
        .addr   CLCH_lfa                        ; FB1E 35 FB
; ----------------------------------------------------------------------------
DEGRE_pfa:
        .byte   $01,$00,$C0,$AA,$0C             ; FB20 01 00 C0 AA 0C
; ----------------------------------------------------------------------------
DEGRE:
        .byte   "DEGRE"                         ; FB25 44 45 47 52 45
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FB2A 80 83
; ----------------------------------------------------------------------------
        lda     FLGTEL                          ; FB2C AD 0D 02
        ora     #$20                            ; FB2F 09 20
        sta     FLGTEL                          ; FB31 8D 0D 02
        rts                                     ; FB34 60

; ----------------------------------------------------------------------------
CLCH_lfa:
        .addr   OPCH_lfa                        ; FB35 69 FB
; ----------------------------------------------------------------------------
CLCH_pfa:
        .byte   $01,$00,$C0,$AC,$0B             ; FB37 01 00 C0 AC 0B
; ----------------------------------------------------------------------------
CLCH:
        .byte   "CLCH"                          ; FB3C 43 4C 43 48
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; FB40 01 81 83
; ----------------------------------------------------------------------------
        ; Prépare BUFTRV: BRK xx RTS
        jsr     LFB5E                           ; FB43 20 5E FB

        jsr     LD44C                           ; FB46 20 4C D4

        cmp     #$04                            ; FB49 C9 04
        bcs     LFB57                           ; FB4B B0 0A
        adc     #$04                            ; FB4D 69 04
        sta     $0101                           ; FB4F 8D 01 01
        jsr     GetByte                         ; FB52 20 4F D4
        cmp     #$18                            ; FB55 C9 18
LFB57:
        bcs     LFBD2                           ; FB57 B0 79
        ora     #$80                            ; FB59 09 80
        jmp     L0100                           ; FB5B 4C 00 01

; ----------------------------------------------------------------------------
; Prépare BUFTRV: BRK xx RTS
; xx sera mis à jour par la routine appelante
LFB5E:
        lda     #$00                            ; FB5E A9 00
        sta     L0100                           ; FB60 8D 00 01
        lda     #$60                            ; FB63 A9 60
        sta     $0102                           ; FB65 8D 02 01
        rts                                     ; FB68 60

; ----------------------------------------------------------------------------
OPCH_lfa:
        .addr   CROSSX_lfa                      ; FB69 90 FB
; ----------------------------------------------------------------------------
OPCH_pfa:
        .byte   $01,$00,$C0,$AD,$0B             ; FB6B 01 00 C0 AD 0B
; ----------------------------------------------------------------------------
OPCH:
        .byte   "OPCH"                          ; FB70 4F 50 43 48
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; FB74 01 81 83
; ----------------------------------------------------------------------------
        ; Prépare BUFTRV: BRK xx RTS
        jsr     LFB5E                           ; FB77 20 5E FB

        jsr     LD44C                           ; FB7A 20 4C D4
        cmp     #$04                            ; FB7D C9 04
        bcs     LFBD2                           ; FB7F B0 51
        sta     $0101                           ; FB81 8D 01 01
        jsr     GetByte                         ; FB84 20 4F D4
        cmp     #$18                            ; FB87 C9 18
        bcs     LFBD2                           ; FB89 B0 47
        ora     #$80                            ; FB8B 09 80
        jmp     L0100                           ; FB8D 4C 00 01

; ----------------------------------------------------------------------------
CROSSX_lfa:
        .addr   CROSS_lfa                       ; FB90 F2 FB
; ----------------------------------------------------------------------------
CROSSX_pfa:
        .byte   $01,$00,$C0,$AE,$0D             ; FB92 01 00 C0 AE 0D
; ----------------------------------------------------------------------------
CROSSX:
        .byte   "CROSSX"                        ; FB97 43 52 4F 53 53 58
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$81,$83             ; FB9D 01 01 01 81 83
; ----------------------------------------------------------------------------
        ldx     #$00                            ; FBA2 A2 00
        jsr     LFBD5                           ; FBA4 20 D5 FB
        XOP1                                    ; FBA7 00 01
        ldx     #$06                            ; FBA9 A2 06
        jsr     LFBDF                           ; FBAB 20 DF FB
        XOP1                                    ; FBAE 00 01
        ldx     #$0C                            ; FBB0 A2 0C
        jsr     LFBD5                           ; FBB2 20 D5 FB
        XOP2                                    ; FBB5 00 02
        ldx     #$C3                            ; FBB7 A2 C3
        jsr     LFBDF                           ; FBB9 20 DF FB
        XOP2                                    ; FBBC 00 02
LFBBE:
        asl     KBDCTC                          ; FBBE 0E 7E 02
        php                                     ; FBC1 08
        jsr     LFBEB                           ; FBC2 20 EB FB
        XRD2                                    ; FBC5 00 0A
        bcs     LFBCB                           ; FBC7 B0 02
        XWR2                                    ; FBC9 00 12
LFBCB:
        plp                                     ; FBCB 28
        bcc     LFBBE                           ; FBCC 90 F0
        ldx     #$07                            ; FBCE A2 07
        bne     LFC1B                           ; FBD0 D0 49
LFBD2:
        jmp     Error_BADVAL                    ; FBD2 4C FF F0

; ----------------------------------------------------------------------------
LFBD5:
        jsr     LD451                           ; FBD5 20 51 D4
        cmp     #$08                            ; FBD8 C9 08
LFBDA:
        bcs     LFBD2                           ; FBDA B0 F6
        ora     #$80                            ; FBDC 09 80
        rts                                     ; FBDE 60

; ----------------------------------------------------------------------------
LFBDF:
        jsr     LD451                           ; FBDF 20 51 D4
        cmp     #$08                            ; FBE2 C9 08
        bcc     LFBD2                           ; FBE4 90 EC
        cmp     #$18                            ; FBE6 C9 18
        jmp     LFBDA                           ; FBE8 4C DA FB

; ----------------------------------------------------------------------------
LFBEB:
        XRD1                                    ; FBEB 00 09
        bcs     LFBF1                           ; FBED B0 02
        XWR1                                    ; FBEF 00 11
LFBF1:
        rts                                     ; FBF1 60

; ----------------------------------------------------------------------------
CROSS_lfa:
        .addr   RANDOM_lfa                      ; FBF2 22 FC
; ----------------------------------------------------------------------------
CROSS_pfa:
        .byte   $01,$00,$C0,$AF,$0C             ; FBF4 01 00 C0 AF 0C
; ----------------------------------------------------------------------------
CROSS:
        .byte   "CROSS"                         ; FBF9 43 52 4F 53 53
; ----------------------------------------------------------------------------
        .byte   $01,$81,$83                     ; FBFE 01 81 83
; ----------------------------------------------------------------------------
        ldx     #$00                            ; FC01 A2 00
        jsr     LFBD5                           ; FC03 20 D5 FB
        XOP1                                    ; FC06 00 01
        ldx     #$C3                            ; FC08 A2 C3
        jsr     LFBDF                           ; FC0A 20 DF FB
        XOP1                                    ; FC0D 00 01
LFC0F:
        asl     KBDCTC                          ; FC0F 0E 7E 02
        php                                     ; FC12 08
        jsr     LFBEB                           ; FC13 20 EB FB
        plp                                     ; FC16 28
        bcc     LFC0F                           ; FC17 90 F6
        ldx     #$03                            ; FC19 A2 03
LFC1B:
        lsr     IOTAB1,x                        ; FC1B 5E B2 02
        dex                                     ; FC1E CA
        bpl     LFC1B                           ; FC1F 10 FA
        rts                                     ; FC21 60

; ----------------------------------------------------------------------------
RANDOM_lfa:
        .addr   WINDOW_lfa                      ; FC22 47 FC
; ----------------------------------------------------------------------------
RANDOM_pfa:
        .byte   $01,$00,$C0,$B0,$0D             ; FC24 01 00 C0 B0 0D
; ----------------------------------------------------------------------------
RANDOM:
        .byte   "RANDOM"                        ; FC29 52 41 4E 44 4F 4D
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FC2F 80 83
; ----------------------------------------------------------------------------
        lda     V1T1CL                          ; FC31 AD 04 03
        sta     CSRND                           ; FC34 8D F0 02
        lda     V1T2CH                          ; FC37 AD 09 03
        sta     CSRND+1                         ; FC3A 8D F1 02
        lda     V2T2CL                          ; FC3D AD 24 03
        sta     CSRND+2                         ; FC40 8D F2 02
        lsr     CSRND+3                         ; FC43 4E F3 02
        rts                                     ; FC46 60

; ----------------------------------------------------------------------------
WINDOW_lfa:
        .addr   PLAY_lfa                        ; FC47 8C FC
; ----------------------------------------------------------------------------
WINDOW_pfa:
        .byte   $01,$00,$C0,$B1,$0D             ; FC49 01 00 C0 B1 0D
; ----------------------------------------------------------------------------
WINDOW:
        .byte   "WINDOW"                        ; FC4E 57 49 4E 44 4F 57
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$01,$81,$83         ; FC54 01 01 01 01 81 83
; ----------------------------------------------------------------------------
        jsr     LD449                           ; FC5A 20 49 D4
        sta     L0100                           ; FC5D 8D 00 01
        jsr     LD446                           ; FC60 20 46 D4
        sta     $0101                           ; FC63 8D 01 01
        ldx     #$12                            ; FC66 A2 12
        jsr     LD451                           ; FC68 20 51 D4
        sta     $0102                           ; FC6B 8D 02 01
        jsr     GetByte                         ; FC6E 20 4F D4
        sta     $0103                           ; FC71 8D 03 01
        lda     #$80                            ; FC74 A9 80
        ldy     #$BB                            ; FC76 A0 BB
        sta     $0104                           ; FC78 8D 04 01
        sty     $0105                           ; FC7B 8C 05 01
        jsr     LD44C                           ; FC7E 20 4C D4
        tax                                     ; FC81 AA
        lda     #$00                            ; FC82 A9 00
        ldy     #$01                            ; FC84 A0 01
        XSCRSE                                  ; FC86 00 36
        rts                                     ; FC88 60

; ----------------------------------------------------------------------------
        jmp     Error_BADVAL                    ; FC89 4C FF F0

; ----------------------------------------------------------------------------
PLAY_lfa:
        .addr   SOUND_lfa                       ; FC8C A0 FC
; ----------------------------------------------------------------------------
PLAY_pfa:
        .byte   $01,$00,$C0,$B2,$0B             ; FC8E 01 00 C0 B2 0B
; ----------------------------------------------------------------------------
PLAY:
        .byte   "PLAY"                          ; FC93 50 4C 41 59
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$81,$83             ; FC97 01 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$43                            ; FC9C A0 43
        bne     LFCC9                           ; FC9E D0 29

; ----------------------------------------------------------------------------
SOUND_lfa:
        .addr   MUSIC_lfa                       ; FCA0 B6 FC
; ----------------------------------------------------------------------------
SOUND_pfa:
        .byte   $01,$00,$C0,$B3,$0C             ; FCA2 01 00 C0 B3 0C
; ----------------------------------------------------------------------------
SOUND:
        .byte   "SOUND"                         ; FCA7 53 4F 55 4E 44
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FCAC 01 01 81 83
; ----------------------------------------------------------------------------
        lda     #$03                            ; FCB0 A9 03
        ldy     #$44                            ; FCB2 A0 44
        bne     LFCCB                           ; FCB4 D0 15

; ----------------------------------------------------------------------------
MUSIC_lfa:
        .addr   LORES_lfa                       ; FCB6 D1 FC
; ----------------------------------------------------------------------------
MUSIC_pfa:
        .byte   $01,$00,$C0,$B4,$0C             ; FCB8 01 00 C0 B4 0C
; ----------------------------------------------------------------------------
MUSIC:
        .byte   "MUSIC"                         ; FCBD 4D 55 53 49 43
; ----------------------------------------------------------------------------
        .byte   $01,$01,$01,$81,$83             ; FCC2 01 01 01 81 83
; ----------------------------------------------------------------------------
        ldy     #$45                            ; FCC7 A0 45
LFCC9:
        lda     #$04                            ; FCC9 A9 04
LFCCB:
        jmp     LF9E0                           ; FCCB 4C E0 F9

; ----------------------------------------------------------------------------
LFCCE:
        jmp     Error_BADVAL                    ; FCCE 4C FF F0

; ----------------------------------------------------------------------------
LORES_lfa:
        .addr   LPR_lfa                         ; FCD1 FA FC
; ----------------------------------------------------------------------------
LORES_pfa:
        .byte   $01,$00,$C0,$B6,$0C             ; FCD3 01 00 C0 B6 0C
; ----------------------------------------------------------------------------
LORES:
        .byte   "LORES"                         ; FCD8 4C 4F 52 45 53
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; FCDD 81 83
; ----------------------------------------------------------------------------
        jsr     LD155                           ; FCDF 20 55 D1
        jsr     GetByte                         ; FCE2 20 4F D4
        cmp     #$02                            ; FCE5 C9 02
        bcs     LFCCE                           ; FCE7 B0 E5
        adc     #$08                            ; FCE9 69 08
        ldx     #$80                            ; FCEB A2 80
        ldy     #$BB                            ; FCED A0 BB
        stx     RES                             ; FCEF 86 00
        sty     RES+1                           ; FCF1 84 01
        ldy     #$E0                            ; FCF3 A0 E0
        ldx     #$BF                            ; FCF5 A2 BF
        XFILLM                                  ; FCF7 00 1C
        rts                                     ; FCF9 60

; ----------------------------------------------------------------------------
LPR_lfa:
        .addr   SEI_lfa                         ; FCFA 14 FD
; ----------------------------------------------------------------------------
LPR_pfa:
        .byte   $01,$00,$C0,$B7,$0A             ; FCFC 01 00 C0 B7 0A
; ----------------------------------------------------------------------------
LPR:
        .byte   "LPR"                           ; FD01 4C 50 52
; ----------------------------------------------------------------------------
        .byte   $90,$83                         ; FD04 90 83
; ----------------------------------------------------------------------------
        bcs     LFD11                           ; FD06 B0 09
        lda     FLGTEL                          ; FD08 AD 0D 02
        and     #$FD                            ; FD0B 29 FD
        sta     FLGTEL                          ; FD0D 8D 0D 02
        rts                                     ; FD10 60

; ----------------------------------------------------------------------------
LFD11:
        XTSTLP                                  ; FD11 00 1E
        rts                                     ; FD13 60

; ----------------------------------------------------------------------------
SEI_lfa:
        .addr   CLI_lfa                         ; FD14 21 FD
; ----------------------------------------------------------------------------
SEI_pfa:
        .byte   $01,$00,$C0,$B8,$0A             ; FD16 01 00 C0 B8 0A
; ----------------------------------------------------------------------------
SEI:
        .byte   "SEI"                           ; FD1B 53 45 49
; ----------------------------------------------------------------------------
        .byte   $80,$01                         ; FD1E 80 01
; ----------------------------------------------------------------------------
        sei                                     ; FD20 78

; ----------------------------------------------------------------------------
CLI_lfa:
        .addr   ERRNB_lfa                       ; FD21 2E FD
; ----------------------------------------------------------------------------
CLI_pfa:
        .byte   $01,$00,$C0,$B9,$0A             ; FD23 01 00 C0 B9 0A
; ----------------------------------------------------------------------------
CLI:
        .byte   "CLI"                           ; FD28 43 4C 49
; ----------------------------------------------------------------------------
        .byte   $80,$01                         ; FD2B 80 01
; ----------------------------------------------------------------------------
        cli                                     ; FD2D 58

; ----------------------------------------------------------------------------
ERRNB_lfa:
        .addr   ERRNL_lfa                       ; FD2E 43 FD
; ----------------------------------------------------------------------------
ERRNB_pfa:
        .byte   $02,$00,$C0,$C0,$0C             ; FD30 02 00 C0 C0 0C
; ----------------------------------------------------------------------------
ERRNB:
        .byte   "ERRNB"                         ; FD35 45 52 52 4E 42
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FD3A 80 83
; ----------------------------------------------------------------------------
        lda     errnb                           ; FD3C AD B7 07
        ldy     #$00                            ; FD3F A0 00
        beq     LFD57                           ; FD41 F0 14

; ----------------------------------------------------------------------------
ERRNL_lfa:
        .addr   ERROR_lfa                       ; FD43 5A FD
; ----------------------------------------------------------------------------
ERRNL_pfa:
        .byte   $02,$00,$C0,$C1,$0C             ; FD45 02 00 C0 C1 0C
; ----------------------------------------------------------------------------
ERRNL:
        .byte   "ERRNL"                         ; FD4A 45 52 52 4E 4C
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FD4F 80 83
; ----------------------------------------------------------------------------
        lda     errnl                           ; FD51 AD B8 07
        ldy     errnl+1                         ; FD54 AC B9 07
LFD57:
        jmp     LE7EF                           ; FD57 4C EF E7

; ----------------------------------------------------------------------------
ERROR_lfa:
        .addr   RESUME_lfa                      ; FD5A 6F FD
; ----------------------------------------------------------------------------
ERROR_pfa:
        .byte   $01,$00,$C0,$C2,$0C             ; FD5C 01 00 C0 C2 0C
; ----------------------------------------------------------------------------
ERROR:
        .byte   "ERROR"                         ; FD61 45 52 52 4F 52
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; FD66 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; FD68 20 4F D4
        tax                                     ; FD6B AA
        jmp     Error_X                         ; FD6C 4C 7E D1

; ----------------------------------------------------------------------------
RESUME_lfa:
        .addr   ERROFF_lfa                      ; FD6F 81 FD
; ----------------------------------------------------------------------------
RESUME_pfa:
        .byte   $01,$00,$C0,$C3,$0D             ; FD71 01 00 C0 C3 0D
; ----------------------------------------------------------------------------
RESUME:
        .byte   "RESUME"                        ; FD76 52 45 53 55 4D 45
; ----------------------------------------------------------------------------
        .byte   $80,$03                         ; FD7C 80 03
; ----------------------------------------------------------------------------
        jmp     (L07C0)                         ; FD7E 6C C0 07

; ----------------------------------------------------------------------------
ERROFF_lfa:
        .addr   CLEAR_lfa                       ; FD81 97 FD
; ----------------------------------------------------------------------------
ERROFF_pfa:
        .byte   $01,$00,$C0,$C4,$0D             ; FD83 01 00 C0 C4 0D
; ----------------------------------------------------------------------------
ERROFF:
        .byte   "ERROFF"                        ; FD88 45 52 52 4F 46 46
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FD8E 80 83
; ----------------------------------------------------------------------------
        lda     fFlags                          ; FD90 A5 8C
        and     #$FB                            ; FD92 29 FB
        sta     fFlags                          ; FD94 85 8C
        rts                                     ; FD96 60

; ----------------------------------------------------------------------------
CLEAR_lfa:
        .addr   VCOPY_lfa                       ; FD97 09 FE
; ----------------------------------------------------------------------------
CLEAR_pfa:
        .byte   $01,$00,$C0,$C5,$0C             ; FD99 01 00 C0 C5 0C
; ----------------------------------------------------------------------------
CLEAR:
        .byte   "CLEAR"                         ; FD9E 43 4C 45 41 52
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FDA3 80 83
; ----------------------------------------------------------------------------
LFDA5:
        jsr     LCE51                           ; FDA5 20 51 CE
        ldx     #$FD                            ; FDA8 A2 FD
        lda     #$07                            ; FDAA A9 07
        ldy     #$01                            ; FDAC A0 01
LFDAE:
        stx     TR0                             ; FDAE 86 0C
        sta     TR1                             ; FDB0 85 0D
        lda     (TR0),y                         ; FDB2 B1 0C
        beq     LFE08                           ; FDB4 F0 52
        iny                                     ; FDB6 C8
        lda     (TR0),y                         ; FDB7 B1 0C
        tax                                     ; FDB9 AA
        ldy     #$06                            ; FDBA A0 06
        lda     (TR0),y                         ; FDBC B1 0C
        tay                                     ; FDBE A8
        cpx     #$08                            ; FDBF E0 08
        beq     LFDD5                           ; FDC1 F0 12
        cpx     #$09                            ; FDC3 E0 09
        beq     LFDD5                           ; FDC5 F0 0E
        cpx     #$0C                            ; FDC7 E0 0C
        beq     LFDCF                           ; FDC9 F0 04
        cpx     #$0D                            ; FDCB E0 0D
        bne     LFDDF                           ; FDCD D0 10
LFDCF:
        jsr     LFDEA                           ; FDCF 20 EA FD
        jmp     LFDDF                           ; FDD2 4C DF FD

; ----------------------------------------------------------------------------
LFDD5:
        lda     #$00                            ; FDD5 A9 00
        sta     (TR0),y                         ; FDD7 91 0C
        iny                                     ; FDD9 C8
        sta     (TR0),y                         ; FDDA 91 0C
        iny                                     ; FDDC C8
        sta     (TR0),y                         ; FDDD 91 0C
LFDDF:
        ldy     #$00                            ; FDDF A0 00
        lda     (TR0),y                         ; FDE1 B1 0C
        tax                                     ; FDE3 AA
        iny                                     ; FDE4 C8
        lda     (TR0),y                         ; FDE5 B1 0C
        jmp     LFDAE                           ; FDE7 4C AE FD

; ----------------------------------------------------------------------------
LFDEA:
        ldy     #$06                            ; FDEA A0 06
        lda     (TR0),y                         ; FDEC B1 0C
        sec                                     ; FDEE 38
        adc     #$01                            ; FDEF 69 01
        adc     TR0                             ; FDF1 65 0C
        sta     RES                             ; FDF3 85 00
        lda     #$00                            ; FDF5 A9 00
        adc     TR1                             ; FDF7 65 0D
        sta     RES+1                           ; FDF9 85 01
        ldy     #$01                            ; FDFB A0 01
        lda     (TR0),y                         ; FDFD B1 0C
        tax                                     ; FDFF AA
        dey                                     ; FE00 88
        lda     (TR0),y                         ; FE01 B1 0C
        tay                                     ; FE03 A8
        lda     #$00                            ; FE04 A9 00
        XFILLM                                  ; FE06 00 1C
LFE08:
        rts                                     ; FE08 60

; ----------------------------------------------------------------------------
VCOPY_lfa:
        .addr   DIM_lfa                         ; FE09 19 FE
; ----------------------------------------------------------------------------
VCOPY_pfa:
        .byte   $01,$00,$C0,$C6,$0C             ; FE0B 01 00 C0 C6 0C
; ----------------------------------------------------------------------------
VCOPY:
        .byte   "VCOPY"                         ; FE10 56 43 4F 50 59
; ----------------------------------------------------------------------------
        .byte   $80,$02                         ; FE15 80 02
; ----------------------------------------------------------------------------
        XHCVDT                                  ; FE17 00 4B

; ----------------------------------------------------------------------------
DIM_lfa:
        .addr   FRE_lfa                         ; FE19 25 FE
; ----------------------------------------------------------------------------
DIM_pfa:
        .byte   $01,$00,$C0,$CC,$0A             ; FE1B 01 00 C0 CC 0A
; ----------------------------------------------------------------------------
DIM:
        .byte   "DIM"                           ; FE20 44 49 4D
; ----------------------------------------------------------------------------
        .byte   $87,$00                         ; FE23 87 00

; ----------------------------------------------------------------------------
FRE_lfa:
        .addr   PAGE$_lfa                       ; FE25 42 FE
; ----------------------------------------------------------------------------
FRE_pfa:
        .byte   $02,$00,$C0,$CD,$0A             ; FE27 02 00 C0 CD 0A
; ----------------------------------------------------------------------------
FRE:
        .byte   "FRE"                           ; FE2C 46 52 45
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FE2F 80 83
; ----------------------------------------------------------------------------
        sec                                     ; FE31 38
        lda     $07F7                           ; FE32 AD F7 07
        sbc     SCEFIN                          ; FE35 E5 5E
        pha                                     ; FE37 48
        lda     $07F8                           ; FE38 AD F8 07
        sbc     SCEFIN+1                        ; FE3B E5 5F
        tay                                     ; FE3D A8
        pla                                     ; FE3E 68
        jmp     LE7EF                           ; FE3F 4C EF E7

; ----------------------------------------------------------------------------
PAGE$_lfa:
        .addr   SERVEUR_lfa                     ; FE42 5C FE
; ----------------------------------------------------------------------------
PAGE$_pfa:
        .byte   $02,$01,$C0,$CE,$0C             ; FE44 02 01 C0 CE 0C
; ----------------------------------------------------------------------------
PAGE$:
        .byte   "PAGE$"                         ; FE49 50 41 47 45 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FE4E 80 83
; ----------------------------------------------------------------------------
        jsr     LD40A                           ; FE50 20 0A D4
        lda     #$C1                            ; FE53 A9 C1
        ldy     #$9C                            ; FE55 A0 9C
        ldx     #$07                            ; FE57 A2 07
        jmp     LCF62                           ; FE59 4C 62 CF

; ----------------------------------------------------------------------------
SERVEUR_lfa:
        .addr   MINITEL_lfa                     ; FE5C 75 FE
; ----------------------------------------------------------------------------
SERVEUR_pfa:
        .byte   $01,$00,$C0,$CF,$0E             ; FE5E 01 00 C0 CF 0E
; ----------------------------------------------------------------------------
SERVEUR:
        .byte   "SERVEUR"                       ; FE63 53 45 52 56 45 55 52
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; FE6A 81 83
; ----------------------------------------------------------------------------
        jsr     GetByte                         ; FE6C 20 4F D4
        tax                                     ; FE6F AA
        lda     #$C5                            ; FE70 A9 C5
        jmp     LFEAD                           ; FE72 4C AD FE

; ----------------------------------------------------------------------------
MINITEL_lfa:
        .addr   APLIC_lfa                       ; FE75 96 FE
; ----------------------------------------------------------------------------
MINITEL_pfa:
        .byte   $01,$00,$C0,$D0,$0E             ; FE77 01 00 C0 D0 0E
; ----------------------------------------------------------------------------
MINITEL:
        .byte   "MINITEL"                       ; FE7C 4D 49 4E 49 54 45 4C
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FE83 80 83
; ----------------------------------------------------------------------------
        ldx     savem_S                         ; FE85 AE F1 07
        txs                                     ; FE88 9A
LFE89:
        rts                                     ; FE89 60

; ----------------------------------------------------------------------------
        tsx                                     ; FE8A BA
        stx     savem_S                         ; FE8B 8E F1 07
        lda     $0800                           ; FE8E AD 00 08
        beq     LFE89                           ; FE91 F0 F6
        jmp     (ptr_07F9)                      ; FE93 6C F9 07

; ----------------------------------------------------------------------------
APLIC_lfa:
        .addr   TINPUT_lfa                      ; FE96 BD FE
; ----------------------------------------------------------------------------
APLIC_pfa:
        .byte   $01,$00,$C0,$D1,$0C             ; FE98 01 00 C0 D1 0C
; ----------------------------------------------------------------------------
APLIC:
        .byte   "APLIC"                         ; FE9D 41 50 4C 49 43
; ----------------------------------------------------------------------------
        .byte   $81,$83                         ; FEA2 81 83
; ----------------------------------------------------------------------------
        jsr     GetWord                         ; FEA4 20 84 D4
        sta     $4D                             ; FEA7 85 4D
        sty     $4E                             ; FEA9 84 4E
        lda     #$BF                            ; FEAB A9 BF
LFEAD:
        ldy     #$03                            ; FEAD A0 03
        sty     BNKCID                          ; FEAF 8C 17 04
        ldy     #$FF                            ; FEB2 A0 FF
        sta     VEXBNK+1                        ; FEB4 8D 15 04
        sty     VEXBNK+2                        ; FEB7 8C 16 04
        jmp     EXBNK                           ; FEBA 4C 0C 04

; ----------------------------------------------------------------------------
TINPUT_lfa:
        .addr   MIDDLE$_lfa                     ; FEBD 02 FF
; ----------------------------------------------------------------------------
TINPUT_pfa:
        .byte   $01,$00,$C0,$D2,$0D             ; FEBF 01 00 C0 D2 0D
; ----------------------------------------------------------------------------
TINPUT:
        .byte   "TINPUT"                        ; FEC4 54 49 4E 50 55 54
; ----------------------------------------------------------------------------
        .byte   $C0,$1F,$83                     ; FECA C0 1F 83
; ----------------------------------------------------------------------------
        jsr     LD44C                           ; FECD 20 4C D4
        sta     FACC1E                          ; FED0 85 60
        lda     #$BC                            ; FED2 A9 BC
        jsr     LFEAD                           ; FED4 20 AD FE
        jsr     LCF5C                           ; FED7 20 5C CF
        jmp     LD28F                           ; FEDA 4C 8F D2

; ----------------------------------------------------------------------------
        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$47                            ; FEDD A9 47
        jsr     LCA69                           ; FEDF 20 69 CA

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$0F                            ; FEE2 A2 0F
        jsr     LC676                           ; FEE4 20 76 C6
        bcs     LFF01                           ; FEE7 B0 18

        ; Appel à la routine n°1 de la table LC69C (LC6EB, sortie de la routine avec C=1 si erreur)
        jsr     LC674                           ; FEE9 20 74 C6
        bcs     LFF01                           ; FEEC B0 13

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$09                            ; FEEE A2 09
        jsr     LC676                           ; FEF0 20 76 C6
        bcs     LFF01                           ; FEF3 B0 0C

        ; Appel à la routine n°X de la table LC69C (sortie de la routine avec C=1 si erreur)
        ldx     #$05                            ; FEF5 A2 05
        jsr     LC676                           ; FEF7 20 76 C6
        bcs     LFF01                           ; FEFA B0 05

        ; Ajoute le nombre d'octets de la procédure A-#$20 de la table LE490 à $C2
        ; Compile ACC,$FF en $0600,$C5 et incrémente $C5 (ACC est inchangé)
        lda     #$2F                            ; FEFC A9 2F
        jsr     LCA69                           ; FEFE 20 69 CA

LFF01:
        rts                                     ; FF01 60

; ----------------------------------------------------------------------------
MIDDLE$_lfa:
        .addr   NOT_lfa                         ; FF02 32 FF
; ----------------------------------------------------------------------------
MIDDLE$_pfa:
        .byte   $02,$06,$C0,$D4,$0E             ; FF04 02 06 C0 D4 0E
; ----------------------------------------------------------------------------
MIDDLE$:
        .byte   "MIDDLE$"                       ; FF09 4D 49 44 44 4C 45 24
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FF10 80 83
; ----------------------------------------------------------------------------
        jsr     LEB47                           ; FF12 20 47 EB
        sec                                     ; FF15 38
        lda     FACC1M+2                        ; FF16 A5 63
        sbc     FACC1E                          ; FF18 E5 60
        bcc     LFF2F                           ; FF1A 90 13
        lsr     a                               ; FF1C 4A
        pha                                     ; FF1D 48
        jsr     LCF5C                           ; FF1E 20 5C CF
        pla                                     ; FF21 68
        tay                                     ; FF22 A8
        clc                                     ; FF23 18
        adc     FACC1E                          ; FF24 65 60
        pha                                     ; FF26 48
        tya                                     ; FF27 98
        jsr     LE750                           ; FF28 20 50 E7
        pla                                     ; FF2B 68
        sta     FACC1E                          ; FF2C 85 60
        rts                                     ; FF2E 60

; ----------------------------------------------------------------------------
LFF2F:
        jmp     Error_BADVAL                    ; FF2F 4C FF F0

; ----------------------------------------------------------------------------
NOT_lfa:
        .addr   FILL_lfa                        ; FF32 48 FF
; ----------------------------------------------------------------------------
NOT_pfa:
        .byte   $02,$02,$C0,$D5,$0A             ; FF34 02 02 C0 D5 0A
; ----------------------------------------------------------------------------
NOT:
        .byte   "NOT"                           ; FF39 4E 4F 54
; ----------------------------------------------------------------------------
        .byte   $80,$83                         ; FF3C 80 83
; ----------------------------------------------------------------------------
        jsr     LD1F7                           ; FF3E 20 F7 D1
        lda     FACC1M                          ; FF41 A5 61
        eor     #$01                            ; FF43 49 01
        jmp     LE7FC                           ; FF45 4C FC E7

; ----------------------------------------------------------------------------
FILL_lfa:
        .addr   CHAR_lfa                        ; FF48 5E FF
; ----------------------------------------------------------------------------
FILL_pfa:
        .byte   $01,$00,$C0,$D6,$0B             ; FF4A 01 00 C0 D6 0B
; ----------------------------------------------------------------------------
FILL:
        .byte   "FILL"                          ; FF4F 46 49 4C 4C
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FF53 01 01 81 83
; ----------------------------------------------------------------------------
        lda     #$03                            ; FF57 A9 03
        ldy     #$96                            ; FF59 A0 96
        jmp     LF9E0                           ; FF5B 4C E0 F9

; ----------------------------------------------------------------------------
CHAR_lfa:
        .addr   SCHAR_lfa                       ; FF5E 74 FF
; ----------------------------------------------------------------------------
CHAR_pfa:
        .byte   $01,$00,$C0,$D7,$0B             ; FF60 01 00 C0 D7 0B
; ----------------------------------------------------------------------------
CHAR:
        .byte   "C"                             ; FF65 43
LFF66:
        .byte   "HAR"                           ; FF66 48 41 52
; ----------------------------------------------------------------------------
        .byte   $01,$01,$81,$83                 ; FF69 01 01 81 83
; ----------------------------------------------------------------------------
        lda     #$03                            ; FF6D A9 03
        ldy     #$97                            ; FF6F A0 97
        jmp     LF9C8                           ; FF71 4C C8 F9

; ----------------------------------------------------------------------------
SCHAR_lfa:
        .addr   CONT_lfa                        ; FF74 8B FF
; ----------------------------------------------------------------------------
SCHAR_pfa:
        .byte   $01,$00,$C0,$D8,$0C             ; FF76 01 00 C0 D8 0C
; ----------------------------------------------------------------------------
SCHAR:
        .byte   "SCHAR"                         ; FF7B 53 43 48 41 52
; ----------------------------------------------------------------------------
        .byte   $82,$83                         ; FF80 82 83
; ----------------------------------------------------------------------------
        ldx     FACC1E                          ; FF82 A6 60
        lda     FACC1M                          ; FF84 A5 61
        ldy     FACC1M+1                        ; FF86 A4 62
        XSCHAR                                  ; FF88 00 98
        rts                                     ; FF8A 60

; ----------------------------------------------------------------------------
CONT_lfa:
        .addr   L07FD                           ; FF8B FD 07
; ----------------------------------------------------------------------------
CONT_pfa:
        .byte   $01,$00,$C0,$D9,$0B             ; FF8D 01 00 C0 D9 0B
; ----------------------------------------------------------------------------
CONT:
        .byte   "CONT"                          ; FF92 43 4F 4E 54
; ----------------------------------------------------------------------------
        .byte   $80,$0C                         ; FF96 80 0C
; ----------------------------------------------------------------------------
        pla                                     ; FF98 68
        pla                                     ; FF99 68
        pla                                     ; FF9A 68
        sta     SP                              ; FF9B 8D 00 07
        pla                                     ; FF9E 68
        sta     $C2                             ; FF9F 85 C2
        jmp     (L07C0)                         ; FFA1 6C C0 07

; ----------------------------------------------------------------------------
; Affiche '44 Ko libres'
LFFA4:
        ldx     #$01                            ; FFA4 A2 01
        jsr     PrintErrMsg4                    ; FFA6 20 87 D5
        jmp     LC005                           ; FFA9 4C 05 C0

; ----------------------------------------------------------------------------
LFFAC:
        lda     FLGTEL                          ; FFAC AD 0D 02
        and     #$04                            ; FFAF 29 04
        bne     LFFE6                           ; FFB1 D0 33

        lda     #$00                            ; FFB3 A9 00
        ldy     #$C0                            ; FFB5 A0 C0
        ldx     #$05                            ; FFB7 A2 05
        sta     VEXBNK+1                        ; FFB9 8D 15 04
        sty     VEXBNK+2                        ; FFBC 8C 16 04
        stx     BNKCID                          ; FFBF 8E 17 04
        jmp     EXBNK                           ; FFC2 4C 0C 04

; ----------------------------------------------------------------------------

; ----------------------------------------------------------------------------
        XOP0                                    ; FFC5 00 00
        XOP0                                    ; FFC7 00 00
        XOP0                                    ; FFC9 00 00
        XOP0                                    ; FFCB 00 00
        XOP0                                    ; FFCD 00 00
        XOP0                                    ; FFCF 00 00
        XOP0                                    ; FFD1 00 00
        XOP0                                    ; FFD3 00 00
        XOP0                                    ; FFD5 00 00
        XOP0                                    ; FFD7 00 00
        XOP0                                    ; FFD9 00 00
        XOP0                                    ; FFDB 00 00
        XOP0                                    ; FFDD 00 00
        XOP0                                    ; FFDF 00 00
        XOP0                                    ; FFE1 00 00
        XOP0                                    ; FFE3 00 00
        .byte   $00                             ; FFE5 00

; ----------------------------------------------------------------------------
LFFE6:
        ; Affiche '44 Ko libres'
        jmp     LFFA4                           ; FFE6 4C A4 FF

; ----------------------------------------------------------------------------
        jmp     LC224                           ; FFE9 4C 24 C2

; ----------------------------------------------------------------------------
        jmp     LCAE8                           ; FFEC 4C E8 CA

; ----------------------------------------------------------------------------
        ; Mise à jour des liens (fin lorsque le poids fort d'un lien = 0)
        ; Adresse premier lien dans XA, déplacement dans TR3-TR4
        jmp     LC3C2                           ; FFEF 4C C2 C3

; ----------------------------------------------------------------------------
        jmp     LC4E7                           ; FFF2 4C E7 C4

; ----------------------------------------------------------------------------
        jmp     LC384                           ; FFF5 4C 84 C3

; ----------------------------------------------------------------------------
SIG_vector:
        .addr   hyperbas_signature              ; FFF8 6F D8

NMI_vector:
        .addr   LEF10                           ; FFFA 10 EF

RST_vector:
        .addr   LC000                           ; FFFC 00 C0

IRQ_vector:
        .addr   virq                            ; FFFE FA 02
