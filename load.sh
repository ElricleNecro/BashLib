#!/usr/bin/env bash

load () {
	while [ -n "$1" ]
	do
		if [ -f $1 ]
		then
			source $1
		elif [ -d $1 ]
		then
			load $1/*
		fi
		shift
	done
}

if [ -n "$BASH_LIB" ]
then
	load `echo $BASH_LIB | tr ':' ' '`
fi
