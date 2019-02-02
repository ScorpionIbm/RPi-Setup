#!/bin/bash
#############SETUP VARIABLES###############################################################################################
#TC
TC=/sbin/tc
#Connection Speed
CS=5000Kbit
CS_Ceil=5000Kbit
#User Speed
US=1000Kbit
US_Ceil=1500Kbit
#PC Speed
PS=1000Kbit
PS_Ceil=1000Kbit
#Mobile Speed
MS=500Kbit
MS_Ceil=1000Kbit
#Guest Speed
GS=1000Kbit
GS_Ceil=1000Kbit
#############SETUP VARIABLES###############################################################################################
#############SETUP BASE CONNECTION#########################################################################################
$TC qdisc add dev eth0 root handle 1: htb default 200
#############SETUP BASE CONNECTION#########################################################################################
#############SETUP CLASSES#################################################################################################
$TC class add dev eth0 parent 1: classid 1:200 htb rate $GS ceil $GS_Ceil
$TC class add dev eth0 parent 1: classid 1:1 htb rate $CS ceil $CS_Ceil
##############ISLAM##########################
$TC class add dev eth0 parent 1:1 classid 1:2 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:2 classid 1:20 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:2 classid 1:21 htb rate $MS ceil $MS_Ceil prio 1
##############HAMDY##########################
$TC class add dev eth0 parent 1:1 classid 1:3 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:3 classid 1:30 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:3 classid 1:31 htb rate $MS ceil $MS_Ceil prio 1
##############AHMED##########################
$TC class add dev eth0 parent 1:1 classid 1:4 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:4 classid 1:40 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:4 classid 1:41 htb rate $MS ceil $MS_Ceil prio 1
##############MARAM##########################
$TC class add dev eth0 parent 1:1 classid 1:5 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:5 classid 1:50 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:5 classid 1:51 htb rate $MS ceil $MS_Ceil prio 1
##############MAMA##########################
$TC class add dev eth0 parent 1:1 classid 1:6 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:6 classid 1:60 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:6 classid 1:61 htb rate $MS ceil $MS_Ceil prio 1
##############BABA##########################
$TC class add dev eth0 parent 1:1 classid 1:7 htb rate $US ceil $US_Ceil
	$TC class add dev eth0 parent 1:7 classid 1:70 htb rate $PS ceil $PS_Ceil prio 0
	$TC class add dev eth0 parent 1:7 classid 1:71 htb rate $MS ceil $MS_Ceil prio 1
##############OTHERS##########################
#############SETUP CLASSES#################################################################################################
#############SETUP ROUTING FILTERS#########################################################################################
##############ISLAM##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.20 flowid 1:20
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.21 flowid 1:21
##############HAMDY##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.30 flowid 1:30
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.31 flowid 1:31
##############AHMED##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.40 flowid 1:40
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.41 flowid 1:41
##############MARAM##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.50 flowid 1:50
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.51 flowid 1:51
##############MAMA##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.60 flowid 1:60
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.61 flowid 1:61
##############BABA##########################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.70 flowid 1:70
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.71 flowid 1:71
#############SETUP ROUTING FILTERS#########################################################################################