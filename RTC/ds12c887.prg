d � &e � THIS IS EXAMPLE OF USING @f � DS12C887 FROM BASIC Fg � Rh � A$(7) ji � A�1�7:� A$(A):� A pm : �n BASE�54528:� BASE ADDRESS OF CHIP (D500) �x � BASE=54784:REM BASE ADDRESS OF CHIP (D600) �� � "�" �� � "" �� � GET TIME FROM RTC 	� � BASE,6:DW��(BASE�1) -	� � BASE,4:H��(BASE�1) G	� � BASE,2:MI��(BASE�1) `	� � BASE,0:S��(BASE�1) y	� � BASE,7:D��(BASE�1) �	� � BASE,8:M��(BASE�1) �	� � BASE,9:Y��(BASE�1) �	� V�H:� 1100:� V;"� :"; �	� V�MI:� 1100:� V;"� :"; �	V�S:� 1100:� V;"�  "; 
V�M:� 1100:� V;"� /"; .
V�D:� 1100:� V;"� /"; H
V�Y:� 1100:� V;"�  "; `
� A$(DW);"        " {
	� SETUP CIA1 TOD CLOCK �

: �
PM�0:V�H:� 1100:�V�13� 280 �
V�V�12:� 1000:H�V �
� 56329,S �
� 56328,0 �
": �
#� THAT'S ALL FOLKS �
': �
�� 200 #�� CONVERT V TO BCD, RETURN IN V C�V��(V�10)�16�(V�10��(V�10)) I�� oL� CONVERT V FROM BCD, RETURN IN V �VV��(V�16)�10�(V�16��(V�16)) �`� �j� SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY   