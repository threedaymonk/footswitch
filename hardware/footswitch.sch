EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Switch:SW_Push SW1
U 1 1 6032A886
P 4700 2500
F 0 "SW1" H 4700 2785 50  0000 C CNN
F 1 "Record" H 4700 2694 50  0000 C CNN
F 2 "" H 4700 2700 50  0001 C CNN
F 3 "~" H 4700 2700 50  0001 C CNN
	1    4700 2500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 6032B654
P 4700 3000
F 0 "SW2" H 4700 3285 50  0000 C CNN
F 1 "Play Start" H 4700 3194 50  0000 C CNN
F 2 "" H 4700 3200 50  0001 C CNN
F 3 "~" H 4700 3200 50  0001 C CNN
	1    4700 3000
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 6032BE67
P 4700 3500
F 0 "SW3" H 4700 3785 50  0000 C CNN
F 1 "Stop" H 4700 3694 50  0000 C CNN
F 2 "" H 4700 3700 50  0001 C CNN
F 3 "~" H 4700 3700 50  0001 C CNN
	1    4700 3500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW4
U 1 1 6032C4DE
P 4700 4000
F 0 "SW4" H 4700 4285 50  0000 C CNN
F 1 "Play" H 4700 4194 50  0000 C CNN
F 2 "" H 4700 4200 50  0001 C CNN
F 3 "~" H 4700 4200 50  0001 C CNN
	1    4700 4000
	1    0    0    -1  
$EndComp
$Comp
L teensy:Teensy2.0_(Arduino) U1
U 1 1 60339172
P 6000 3150
F 0 "U1" H 6000 4187 60  0000 C CNN
F 1 "Teensy 2.0" H 6000 4081 60  0000 C CNN
F 2 "" H 6100 2100 60  0000 C CNN
F 3 "" H 6100 2100 60  0000 C CNN
	1    6000 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 4000 5200 4000
Wire Wire Line
	5200 4000 5200 2800
Wire Wire Line
	5200 2800 5300 2800
Wire Wire Line
	4900 3500 5100 3500
Wire Wire Line
	5100 3500 5100 2700
Wire Wire Line
	5100 2700 5300 2700
Wire Wire Line
	4900 3000 5000 3000
Wire Wire Line
	5000 3000 5000 2600
Wire Wire Line
	5000 2600 5300 2600
Wire Wire Line
	4900 2500 5300 2500
Wire Wire Line
	5300 2400 5300 2100
Wire Wire Line
	5300 2100 4400 2100
Wire Wire Line
	4400 2100 4400 2500
Wire Wire Line
	4400 4000 4500 4000
Wire Wire Line
	4400 3500 4500 3500
Connection ~ 4400 3500
Wire Wire Line
	4400 3500 4400 4000
Wire Wire Line
	4400 3000 4500 3000
Connection ~ 4400 3000
Wire Wire Line
	4400 3000 4400 3500
Wire Wire Line
	4400 2500 4500 2500
Connection ~ 4400 2500
Wire Wire Line
	4400 2500 4400 3000
$EndSCHEMATC
