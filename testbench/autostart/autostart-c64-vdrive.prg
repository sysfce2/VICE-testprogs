  � * MAIN . � CHECK IF DRIVE IS PRESENT Z � 1,8,0:� 1: � (ST � 128) � 128 � E � 1 z � "�VICE AUTOSTART TEST":� � � "EXPECTING:" �
 � "TDE:"; 0 ; � � "VDRIVE:"; 1 ; � � "VFS:"; 0 � � "AUTOSTART DISK:"; 0 � � "DISK IMAGE:"; 0 � � 	 � E � 1 � � 90 	 � 1000 +	 � "MSG:";PU$ 6	 � 2000 G	 � "DIR:";DI$ [	Z � "NO DRIVE:";E f	\ � 3000 l	^ � w	` � 4000 �	b � F � 0 � � 55295 , 0: � 53280, 5: � "ALL OK" �	d � F �� 0 � � 55295 , 255: � 53280, 2: � "FAILED" �	f � 
�� * GET POWERUP MESSAGE FROM DRIVE 
�� 15,8,15,"UI" 0
��15,A,PU$,C,D 9
�� 15 ?
�� a
�� * GET HEADER FROM DIRECTORY �
�� 1,8,0,"$":DI$�"": � ST �� 0 � � �
�� I � 0 � 7: �#1, A$: �
�� ST �� 0 � � �
�� �
�� I � 0 � 15: �#1, A$: DI$�DI$�A$: � �
�� 1 �
�� �� * CHECK WHAT IS WHAT @�� �(PU$, 7) � "CBM DOS" � TD � 1 : � TDE ENABLED ~�� �(PU$, 13) � "VIRTUAL DRIVE" � VD � 1 : � VIRTUAL DRIVE ��� �(PU$, 7) � "VICE FS" � FS � 1 : � FILESYSTEM ��� �(DI$, 9) � "AUTOSTART" � AD � 1 : � USING AUTOSTART DISK IMAGE :�� �(DI$, 8) � "TESTDISK" � D � 1 : � USING REGULAR DISK IMAGE @�� S�� "TDE:"; TD ; i�� "VDRIVE:"; VD ; z�� "VFS:"; FS ��� "AUTOSTART DISK:"; AD ��� "DISK IMAGE:"; AD ��� ��� * CHECK FOR ERRORS ��F � 0 ��� TD �� 0 � F � F � 1 �� VD �� 1 � F � F � 1 %�� FS �� 0 � F � F � 1 ?�� AD �� 0 � F � F � 1 X�� D �� 0 � F � F � 1 l�� "ERRORS: "; F r�� ��� PRG AUTOSTART MODES ARE: ��� 0 : VIRTUAL FILESYSTEM ��� 1 : INJECT TO RAM (THERE MIGHT BE NO DRIVE) ��� 2 : COPY TO D64 �� $90/144: �ERNAL �/� �TATUS �ORD �� %�� W�� +-------+---------------------------------+ ��� \ �IT 7 \ 1 = �EVICE NOT PRESENT (�) \ ��� \ \ 1 = �ND OF �APE (�) \ ��� \ �IT 6 \ 1 = �ND OF �ILE (�+�) \ ��� \ �IT 5 \ 1 = �HECKSUM ERROR (�) \ �� \ �IT 4 \ 1 = �IFFERENT ERROR (�) \ H�� \ �IT 3 \ 1 = �OO MANY BYTES (�) \ p�� \ �IT 2 \ 1 = �OO FEW BYTES (�) \ ��� \ �IT 1 \ 1 = �IMEOUT �EAD (�) \ ��� \ �IT 0 \ 1 = �IMEOUT �RITE (�) \ ��� +-------+---------------------------------+ ��� �� (�) = �ERIAL BUS, (�) = �APE   