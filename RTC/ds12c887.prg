d � &e � THIS IS EXAMPLE OF USING @f � DS12C887 FROM BASIC Fg � Rh � A$(7) ji � A�1�7:� A$(A):� A pm : �n BASE�54528:� BASE ADDRESS OF CHIP (D500) �s � BASE=54784:REM BASE ADDRESS OF CHIP (D600) �x � BASE=56832:REM BASE ADDRESS OF CHIP (DE00) 0	} � BASE=57088:REM BASE ADDRESS OF CHIP (DF00) :	� � "�" D	� � "" \	� � GET TIME FROM RTC v	� � BASE,6:DW��(BASE�1) �	� � BASE,4:H��(BASE�1) �	� � BASE,2:MI��(BASE�1) �	� � BASE,0:S��(BASE�1) �	� � BASE,7:D��(BASE�1) �	� � BASE,8:M��(BASE�1) 
� � BASE,9:Y��(BASE�1) '
� V�H:� 1100:� V;"� :"; B
� V�MI:� 1100:� V;"� :"; \
V�S:� 1100:� V;"�  "; v
V�M:� 1100:� V;"� /"; �
V�D:� 1100:� V;"� /"; �
V�Y:� 1100:� V;"�  "; �
� A$(DW);"        " �
	� SETUP CIA1 TOD CLOCK �

: PM�0:V�H:� 1100:�V�13� 280 V�V�12:� 1000:H�V &� 56329,S 4� 56328,0 :": Q#� THAT'S ALL FOLKS W': a�� 200 ��� CONVERT V TO BCD, RETURN IN V ��V��(V�10)�16�(V�10��(V�10)) ��� �L� CONVERT V FROM BCD, RETURN IN V �VV��(V�16)�10�(V�16��(V�16)) �`� 6j� SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY   