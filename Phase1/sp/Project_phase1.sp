Project:phase1
*M.Amin.H.Khodaverdian
*97101518


**********************Transistors Model*********************************************
.model Bc107n npn bf=200 rb=100  va=100 ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns
.model Bc107p pnp bf=50  rb=100  va=70  ccs=2pf cje=3pf cjc=2pf tf=0.3ns tr=6ns
************************************************************************************



*********Sources********************
Vcc		  Vcc		0		5
Vee		  Vee		0		0
Vin1	 	  Vi1		10		sin(2.5 1u 1k 0 0 0) 
Vin2	  	  Vi2		0		sin(2.5 -1u 1k 0 0 0)
Vb		  10		11		dc=0 
************************************




********************* stage 1 **************************


*********Resistors***********
R1		Vcc		Vc3		12.5k
R2		Vcc    		Vc4		12.5k
R3		Vcc		Vb5		21.5k
*****************************

**********Transistors********************
q1		Vcc		Vi1		Vb3		Bc107n
q2		Vcc		Vi2		Vb4		Bc107n
q3		Vc3		Vb3		Ve3		Bc107n
q4		Vc4		Vb4		Ve3		Bc107n
q5		Ve3		Vb5		Vee		Bc107n
q6		Vb5		Vb5		Vee		Bc107n
*****************************************


********************************************************



********************* stage 2 **************************



*********Resistors***********
R5		Vcc		Vb7		10.75k
*****************************


**********Transistors********************
q7		Ve8		Vb7		Vee		Bc107n
q8		Vc8		Vc4		Ve8		Bc107n
q9		Vc9		Vc3		Ve8		Bc107n
q10		Vc8		Vc8		Vcc		Bc107p
q11		Vc9		Vc8		Vcc		Bc107p
q17		Vb7		Vb7		Vee		Bc107n
*****************************************


********************************************************


********************* stage 3 **************************


*********Resistors**************
R6		Vcc		Vb15		4.3k
********************************


**********Transistors***********************
q14		Vc14		Vc9		Vcc		Bc107p
q15		Vc14		Vb15	Vee		Bc107n
q16		Vb15		Vb15	Vee		Bc107n
********************************************



********************************************************


********************DC Feedback*************************
E3		101		0		Vc14		103		1
Vref		103		0		2.5
Rx		101		102		100x
Cx		102		0		1
E4		11		0		102		0		1
********************************************************


************************************
.options accurate = 1 gmin = 1e-9
.op
.tran 	0.1m 2m
************************************

.end