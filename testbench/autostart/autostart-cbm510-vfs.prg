     * MAIN 0   CHECK IF DRIVE IS PRESENT \   1,8,0:  1:  (ST ¯ 128) ² 128 § E ² 1 {   "VICE AUTOSTART TEST":    "EXPECTING:"   
  "TDE:"; 0 ; µ   "VDRIVE:"; 0 ; Å   "VFS:"; 1 à   "AUTOSTART DISK:"; 0 ÷   "DISK IMAGE:"; 0 ý     E ² 1 §  90   1000 ,  "MSG:";PU$ 7  2000 H  "DIR:";DI$ \   "DISKID:";ID$ pZ  "NO DRIVE:";E {\  3000 ^  `  4000 ¼b  F ² 0 §  56063 , 0:  255, 5:  "ALL OK" ïd  F ³± 0 §  56063 , 255:  255, 2:  "FAILED" õf  è * GET POWERUP MESSAGE FROM DRIVE /ê 15,8,15,"UI" Aì15,A,PU$,C,D Jî  15 Pð rÐ * GET HEADER FROM DIRECTORY  Ò 1,8,0,"$":DI$²"": ID$²"":  ST ³± 0 §  ºÔ I ² 0 ¤ 7: ¡#1, A$: ÌÖ ST ³± 0 §  ÒØ ûÚ I ² 0 ¤ 15: ¡#1, A$: DI$²DI$ªA$:  Ü¡ #1,A$:¡ #1,A$ 7Þ I ² 0 ¤ 5: ¡#1, A$: ID$²ID$ªA$:  ?à  1 Eâ `¸ * CHECK WHAT IS WHAT º È(PU$, 7) ² "CBM DOS" § TD ² 1 :  TDE ENABLED Ó¼ È(PU$, 13) ² "VIRTUAL DRIVE" § VD ² 1 :  VIRTUAL DRIVE ¾ È(PU$, 7) ² "VICE FS" § FS ² 1 :  FILESYSTEM ^À È(DI$, 9) ² "AUTOSTART" ¯ ID$ ³± " #8:0" § AD ² 1 :  USING AUTOSTART DISK IMAGE  Â È(DI$, 8) ² "TESTDISK" § D ² 1 :  USING REGULAR DISK IMAGE ¦Ä ¹Æ "TDE:"; TD ; ÏÈ "VDRIVE:"; VD ; àÊ "VFS:"; FS üÌ "AUTOSTART DISK:"; AD Î "DISK IMAGE:"; D Ð 2  * CHECK FOR ERRORS <¢F ² 0 V¤ TD ³± 0 § F ² F ª 1 p¦ VD ³± 0 § F ² F ª 1 ¨ FS ³± 1 § F ² F ª 1 ¤ª AD ³± 0 § F ² F ª 1 ½¬ D ³± 0 § F ² F ª 1 Ñ® "ERRORS: "; F ×° ö² PRG AUTOSTART MODES ARE: ´ 0 : VIRTUAL FILESYSTEM E¶ 1 : INJECT TO RAM (THERE MIGHT BE NO DRIVE) [¸ 2 : COPY TO D64 º $90/144: KERNAL I/O STATUS WORD ST ¼ ¼¾ +-------+---------------------------------+ éÀ \ BIT 7 \ 1 = DEVICE NOT PRESENT (S) \ 	Â \ \ 1 = END OF TAPE (T) \ 1Ä \ BIT 6 \ 1 = END OF FILE (S+T) \ ZÆ \ BIT 5 \ 1 = CHECKSUM ERROR (T) \ È \ BIT 4 \ 1 = DIFFERENT ERROR (T) \ ­Ê \ BIT 3 \ 1 = TOO MANY BYTES (T) \ ÕÌ \ BIT 2 \ 1 = TOO FEW BYTES (T) \ üÎ \ BIT 1 \ 1 = TIMEOUT READ (S) \ $Ð \ BIT 0 \ 1 = TIMEOUT WRITE (S) \ VÒ +-------+---------------------------------+ \Ô Ö (S) = SERIAL BUS, (T) = TAPE   