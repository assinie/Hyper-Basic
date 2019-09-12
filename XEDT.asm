XEDT_ROUTINE
edit_line_in_bufedt
        STA $67
        TXA
        PHA
        TYA
        BPL Le446
        JSR LE301
        LDX ACC1E
        LDY $61
        JSR Le62a
Le446
        LDA #$0D
        JSR Le648
        JSR XECRPR_ROUTINE
        PLA
        TAX
        BEQ Le45a
Le452
        LDA #$09
        JSR Le648
        DEX
        BNE Le452
Le45a
        LDX $28
        LDA $0248,X
        BMI Le466
        LDA #$11
        JSR Le648
Le466
        JSR test_if_all_buffers_are_empty
        JSR XRD0_ROUTINE
        BCS Le466
        PHA
        LDA #$11
        JSR Le648
        PLA
        CMP #$0D
        BNE Le4bc
Le479
        PHA
        JSR LE34F
        PLA
        PHA
        CMP #$0B
        BEQ Le494
        LDX $62
        LDY $63
        JSR Le62a
        LDA #$0D
        JSR Le648
        LDA #$0A
        JSR Le648
Le494
        LDX #$FF
Le496
        INX
        LDA BUFEDT,X
        CMP #$20
        BEQ Le496
        TXA
        PHA
        LDY #$00
        .byt $2c
Le4a3
        inx
        iny

        LDA BUFEDT,X
        STA BUFEDT,Y
        BNE Le4a3
        LDA #$90
        LDY #$05
        JSR XDECAY_ROUTINE
        STA RES
        STY RES+1
        PLA
        TAY
        PLA
        RTS


