   * MAIN .  CHECK IF DRIVE IS PRESENT Z  1,8,0:  1:  (ST ¯ 128) ² 128 § E ² 1 y  "VICE AUTOSTART TEST":   "EXPECTING:" 
  "TDE:"; 0 ; ³  "VDRIVE:"; 1 ; Ã  "VFS:"; 0 Þ  "AUTOSTART DISK:"; 0 õ  "DISK IMAGE:"; 0 û    E ² 1 §  90   1000 *  "MSG:";PU$ 5  2000 F  "DIR:";DI$ Z   "DISKID:";ID$ nZ  "NO DRIVE:";E y\  3000 ^  `  4000 ºb  F ² 0 §  35839 , 0:  255, 5:  "ALL OK" íd  F ³± 0 §  35839 , 255:  255, 2:  "FAILED" óf  è * GET POWERUP MESSAGE FROM DRIVE -ê 15,8,15,"UI" ?ì15,A,PU$,C,D Hî  15 Nð pÐ * GET HEADER FROM DIRECTORY Ò 1,8,0,"$":DI$²"": ID$²"":  ST ³± 0 §  ¸Ô I ² 0 ¤ 7: ¡#1, A$: ÊÖ ST ³± 0 §  ÐØ ùÚ I ² 0 ¤ 15: ¡#1, A$: DI$²DI$ªA$:  Ü¡ #1,A$:¡ #1,A$ 5Þ I ² 0 ¤ 5: ¡#1, A$: ID$²ID$ªA$:  =à  1 Câ ^¸ * CHECK WHAT IS WHAT º È(PU$, 7) ² "CBM DOS" § TD ² 1 :  TDE ENABLED Ñ¼ È(PU$, 13) ² "VIRTUAL DRIVE" § VD ² 1 :  VIRTUAL DRIVE ¾ È(PU$, 7) ² "VICE FS" § FS ² 1 :  FILESYSTEM \À È(DI$, 9) ² "AUTOSTART" ¯ ID$ ³± " #8:0" § AD ² 1 :  USING AUTOSTART DISK IMAGE Â È(DI$, 8) ² "TESTDISK" § D ² 1 :  USING REGULAR DISK IMAGE ¤Ä ·Æ "TDE:"; TD ; ÍÈ "VDRIVE:"; VD ; ÞÊ "VFS:"; FS úÌ "AUTOSTART DISK:"; AD 	Î "DISK IMAGE:"; D 	Ð 0	  * CHECK FOR ERRORS :	¢F ² 0 T	¤ TD ³± 0 § F ² F ª 1 n	¦ VD ³± 1 § F ² F ª 1 	¨ FS ³± 0 § F ² F ª 1 ¢	ª AD ³± 0 § F ² F ª 1 »	¬ D ³± 0 § F ² F ª 1 Ï	® "ERRORS: "; F Õ	° ô	² PRG AUTOSTART MODES ARE: 
´ 0 : VIRTUAL FILESYSTEM C
¶ 1 : INJECT TO RAM (THERE MIGHT BE NO DRIVE) Y
¸ 2 : COPY TO D64 
º $90/144: KERNAL I/O STATUS WORD ST 
¼ º
¾ +-------+---------------------------------+ ç
À \ BIT 7 \ 1 = DEVICE NOT PRESENT (S) \ Â \ \ 1 = END OF TAPE (T) \ /Ä \ BIT 6 \ 1 = END OF FILE (S+T) \ XÆ \ BIT 5 \ 1 = CHECKSUM ERROR (T) \ È \ BIT 4 \ 1 = DIFFERENT ERROR (T) \ «Ê \ BIT 3 \ 1 = TOO MANY BYTES (T) \ ÓÌ \ BIT 2 \ 1 = TOO FEW BYTES (T) \ úÎ \ BIT 1 \ 1 = TIMEOUT READ (S) \ "Ð \ BIT 0 \ 1 = TIMEOUT WRITE (S) \ TÒ +-------+---------------------------------+ ZÔ }Ö (S) = SERIAL BUS, (T) = TAPE   