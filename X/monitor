#!/bin/bash

monitor() {
	PERIPH=${1:-VGA-0}
	OPT=${2:---left-of}
	xrandr -q | grep $PERIPH | grep disconnected 1>&2 2>/dev/null
	retval=$?
	if [ "$retval" = 1 ]
	then
		echo -n "Setting monitor ${PERIPH}..."
		xrandr --output LVDS --primary --auto --output ${PERIPH} --auto $OPT LVDS
		echo " done"
	fi
}

unmonitor() {
	PERIPH=${1:-VGA-0}
	#xrandr -q | grep $PERIPH | grep disconnected 1>&2 2>/dev/null
	#retval=$?
	#if [ "$retval" = 1 ]
	#then
	echo -n "Setting monitor ${PERIPH}..."
	xrandr --output $PERIPH --off
	echo " done"
	#fi
}
