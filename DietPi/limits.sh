#!/bin/bash
#############SETUP VARIABLES###############################################################################################
#IPTABLES
IPT=/sbin/iptables
#TC
TC=/sbin/tc
#Download
DL=5000Kbit
DL_Ceil=5000Kbit
#Upload
UL=900Kbit
UL_Ceil=900Kbit
UL_Prio=0
#FQ_CODEL
quantum=300
#User Speed
U_DL=1000Kbit
U_DL_Ceil=1500Kbit
#PC Speed
PC_DL=900Kbit
PC_DL_Ceil=1000Kbit
PC_DL_Prio=2
#Mobile Speed
M_DL=450Kbit
M_DL_Ceil=1000Kbit
M_DL_Prio=5
#Guest Speed
G_DL=500Kbit
G_DL_Ceil=500Kbit
G_DL_Prio=7
#############SETUP VARIABLES###############################################################################################
#############SETUP BASE CONNECTION#########################################################################################
$TC qdisc add dev eth0 root handle 1: htb default 200
#############SETUP BASE CONNECTION#########################################################################################
#############SETUP CLASSES#################################################################################################
#DOWNLOAD
$TC class add dev eth0 parent 1: classid 1:1 htb rate $DL ceil $DL_Ceil
#UPLOAD
$TC class add dev eth0 parent 1: classid 1:100 htb rate $UL ceil $UL_Ceil prio $UL_Prio
	$TC qdisc add dev eth0 parent 1:100 fq_codel quantum $quantum
#GUEST
$TC class add dev eth0 parent 1: classid 1:200 htb rate $G_DL ceil $G_DL_Ceil prio $G_DL_Prio
##############ISLAM##########################
	$TC class add dev eth0 parent 1:1 classid 1:2 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:2 classid 1:20 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:2 classid 1:21 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############HAMDY##########################
	$TC class add dev eth0 parent 1:1 classid 1:3 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:3 classid 1:30 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:3 classid 1:31 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############AHMED##########################
	$TC class add dev eth0 parent 1:1 classid 1:4 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:4 classid 1:40 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:4 classid 1:41 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############MARAM##########################
	$TC class add dev eth0 parent 1:1 classid 1:5 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:5 classid 1:50 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:5 classid 1:51 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############MAMA##########################
	$TC class add dev eth0 parent 1:1 classid 1:6 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:6 classid 1:60 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:6 classid 1:61 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############BABA##########################
	$TC class add dev eth0 parent 1:1 classid 1:7 htb rate $U_DL ceil $U_DL_Ceil
		$TC class add dev eth0 parent 1:7 classid 1:70 htb rate $PC_DL ceil $PC_DL_Ceil prio $PC_DL_Prio
		$TC class add dev eth0 parent 1:7 classid 1:71 htb rate $M_DL ceil $M_DL_Ceil prio $M_DL_Prio
##############OTHERS##########################
#############SETUP CLASSES#################################################################################################
#############SETUP ROUTING FILTERS#########################################################################################
##############UPLOAD#########################
#$IPT -t mangle -A PREROUTING -m iprange --src-range 192.168.1.20-192.168.1.254 -j MARK --set-mark 100
#$TC filter add dev eth0 protocol ip parent 1: handle 100 fw flowid 1:100
$TC filter add dev eth0 protocol ip parent 1: u32 match ip src 192.168.1.0/24 flowid 1:100
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
##############SERVERS#######################
$TC filter add dev eth0 protocol ip parent 1: u32 match ip src 192.168.1.10 flowid 1:1
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.10 flowid 1:1
$TC filter add dev eth0 protocol ip parent 1: u32 match ip src 192.168.1.5 flowid 1:1
$TC filter add dev eth0 protocol ip parent 1: u32 match ip dst 192.168.1.5 flowid 1:1
#############SETUP ROUTING FILTERS#########################################################################################