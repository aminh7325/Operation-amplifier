Project:phase2
*M.Amin.H.Khodaverdian
*97101518



********************************************************************Regulator*************************************************************
* connections:   non-inverting input
*                |  inverting input
*                |  |  positive power supply
*                |  |  |  negative power supply
*                |  |  |  |  output
*                |  |  |  |  |
.subckt uA741    1  2  3  4  5
*
  c1   11 12 8.661E-12
  c2    6  7 30.00E-12
  dc    5 53 dx
  de   54  5 dx
  dlp  90 91 dx
  dln  92 90 dx
  dp    4  3 dx
  egnd 99  0 poly(2) (3,0) (4,0) 0 .5 .5
  fb    7 99 poly(5) vb vc ve vlp vln 0 10.61E6 -10E6 10E6 10E6 -10E6
  ga    6  0 11 12 188.5E-6
  gcm   0  6 10 99 5.961E-9
  iee  10  4 dc 15.16E-6
  hlim 90  0 vlim 1K
  q1   11  2 13 qx
  q2   12  1 14 qx
  r2    6  9 100.0E3
  rc1   3 11 5.305E3
  rc2   3 12 5.305E3
  re1  13 10 1.836E3
  re2  14 10 1.836E3
  ree  10 99 13.19E6
  ro1   8  5 50
  ro2   7 99 100
  rp    3  4 18.16E3
  vb    9  0 dc 0
  vc    3 53 dc 1
  ve   54  4 dc 1
  vlim  7  8 dc 0
  vlp  91  0 dc 40
  vln   0 92 dc 40
.model dx D(Is=800.0E-18 Rs=1)
.model qx NPN(Is=800.0E-18 Bf=93.75)
.ends
.model DZener D Is=1e-14 vj=0.6 rs=10 vb=3
.MODEL QBD135P NPN( IS = 4.815E-14  NF = 0.9897 ISE = 1.389E-14  NE = 1.6   BF = 124.2  IKF = 1.6  VAF = 222  NR = 0.9895  ISC = 1.295E-13  NC = 1.183   BR = 13.26   IKR = 0.29   VAR = 81.4   RB = 0.5  IRB = 1E-06    RBM = 0.5  RE = 0.165  RC = 0.096   XTB = 0  EG = 1.11  XTI = 3 CJE = 1.243E-10 VJE = 0.7313 
+     MJE = 0.3476 
+     TF = 6.478E-10 
+     XTF = 29 
+     VTF = 2.648 
+     ITF = 3.35 
+     PTF = 0 
+     CJC = 3.04E-11 
+     VJC = 0.5642 
+     MJC = 0.4371 
+     XCJC = 0.15
+     TR = 1E-32 
+     CJS = 0 
+     VJS = 0.75 
+     MJS = 0.333 
+     FC = 0.9359 )

Vin 		Vin			0			sin(8	 0.1  50	0	0	0)
c1			Vin			0			100u
DZ			0			ref			DZener
X_opamp		ref			Vf			Vin			0			Vo			uA741
Cout		VCC			0			100u
R11			Vin			ref			6k
R22			VCC			Vf			10
R33			Vf			0			10
qc			Vin			Vo			VCC			QBD135P
******************************************************************************************************************************************************



********************************************************** designed Opamp*****************************************************************************
Project:phase1
*M.Amin.H.Khodaverdian
*97101518


**********************Transistors Model*********************************************
.model Bc107n npn bf=200 rb=100  va=100 ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns
.model Bc107p pnp bf=50  rb=100  va=70  ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns
************************************************************************************



*********Sources********************
Vee		  		Vee			0			0
Vin1			Vi1			10			sin(2.5 9.5u 1k 0 0 0) 
Vin2	  	  	Vi2			0			sin(2.5 -9.5u 1k 0 0 0)
Vb		  		10			11			dc=0 
************************************




********************* stage 1 **************************


*********Resistors***********
R1			VCC			Vc3			15k
R2			VCC    		Vc4			15k
R3			VCC			Vb5			26.5k
*****************************

**********Transistors********************
q1		VCC		Vi1		Vb3		Bc107n
q2		VCC		Vi2		Vb4		Bc107n
q3		Vc3		Vb3		Ve3		Bc107n
q4		Vc4		Vb4		Ve3		Bc107n
q5		Ve3		Vb5		Vee		Bc107n
q6		Vb5		Vb5		Vee		Bc107n
*****************************************


********************************************************



********************* stage 2 **************************



*********Resistors***********
R5		VCC		Vb7		13.25k
*****************************


**********Transistors********************
q7		Ve8		Vb7		Vee		Bc107n
q8		Vc8		Vc4		Ve8		Bc107n
q9		Vc9		Vc3		Ve8		Bc107n
q10		Vc8		Vc8		VCC		Bc107p
q11		Vc9		Vc8		VCC		Bc107p
q17		Vb7		Vb7		Vee		Bc107n
*****************************************


********************************************************


********************* stage 3 **************************


*********Resistors**************
R6		VCC		Vb15		5.3k
********************************


**********Transistors***********************
q14		Vc14		Vc9		VCC		Bc107p
q15		Vc14		Vb15	Vee		Bc107n
q16		Vb15		Vb15	Vee		Bc107n
********************************************



********************************************************


********************DC Feedback*************************
E3			101		0			Vc14		103		1
Vref		103		0			3.3
Rx			101		102			100x
Cx			102		0			1
E4			11		0			102			0		1
********************************************************
*********************************************************************************************************



*************************************************PA******************************************************
.MODEL QN NPN( IS = 4.815E-14  NF = 0.9897 ISE = 1.389E-14  NE = 1.6   BF = 124.2  IKF = 1.6  VAF = 222  NR = 0.9895  ISC = 1.295E-13  NC = 1.183   BR = 13.26   IKR = 0.29   VAR = 81.4   RB = 0.5  IRB = 1E-06    RBM = 0.5  RE = 0.165  RC = 0.096   XTB = 0  EG = 1.11  XTI = 3 CJE = 1.243E-10 VJE = 0.7313 
+     MJE = 0.3476 
+     TF = 6.478E-10 
+     XTF = 29 
+     VTF = 2.648 
+     ITF = 3.35 
+     PTF = 0 
+     CJC = 3.04E-11 
+     VJC = 0.5642 
+     MJC = 0.4371 
+     XCJC = 0.15
+     TR = 1E-32 
+     CJS = 0 
+     VJS = 0.75 
+     MJS = 0.333 
+     FC = 0.9359 )

.MODEL QP PNP( IS = 4.815E-14  NF = 0.9897 ISE = 1.389E-14  NE = 1.6   BF = 124.2  IKF = 1.6  VAF = 222  NR = 0.9895  ISC = 1.295E-13  NC = 1.183   BR = 13.26   IKR = 0.29   VAR = 81.4   RB = 0.5  IRB = 1E-06    RBM = 0.5  RE = 0.165  RC = 0.096   XTB = 0  EG = 1.11  XTI = 3 CJE = 1.243E-10 VJE = 0.7313 
+     MJE = 0.3476 
+     TF = 6.478E-10 
+     XTF = 29 
+     VTF = 2.648 
+     ITF = 3.35 
+     PTF = 0 
+     CJC = 3.04E-11 
+     VJC = 0.5642 
+     MJC = 0.4371 
+     XCJC = 0.15
+     TR = 1E-32 
+     CJS = 0 
+     VJS = 0.75 
+     MJS = 0.333 
+     FC = 0.9359 )

.model D1N4148 D(Is=5.84n N=1.94 Rs=.7017 Ikf=44.17m Xti=3 Eg=1.11 Cjo=.95p M=.55 Vj=.75 Fc=.5 Isr=11.07n Nr=2.088 Bv=100 Ibv=100u Tt=11.07n)
.model Bc108n npn bf=200 rb=100  va=100 ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns
.model Bc108p pnp bf=100  rb=100  va=70  ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns


*******************current source 1*************************
qiref1		Vbpan		Vx			VCC			Bc108p
qiref2		Vx			Vx			VCC			Bc108p
Rref1		Vx			0			1k
************************************************************

******************buffer************************************
qbuff		VCC			Vc14		Vbuff		Bc108n
rbuff		Vbuff		0			200
**********************************************************

*****************current source2****************************
qiref3		Vbuff		Vy			0			Bc108n
qiref4		Vy			Vy			0			Bc108n
Rref2		VCC			Vy			500
***********************************************************

*******************PA****************************************
qpan		VCC			Vbpan		Vepa		QN
qpap		0			Vbuff		Vepa		QP
d1			Vbpan		Vd			D1N4148
d2			Vd			Vbuff		D1N4148
RL			Vout		0			8
Cpa			Vepa		Vout		100u
*************************************************************

************************************
.options accurate = 1 gmin = 1e-9
.op
.tran 	0.1m 2m
*.tran	0.001	0.04
************************************

.end	