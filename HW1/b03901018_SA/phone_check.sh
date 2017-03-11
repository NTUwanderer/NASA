#!/usr/bin/env bash

if [[ $1 =~ ^09[0-9]{8}$ ]] ||                       # first regular expression
	[[ $1 =~ ^09[0-9]{2}-[0-9]{6}$ ]] ||             # second regular expression
	[[ $1 =~ ^09[0-9]{2}-[0-9]{3}-[0-9]{3}$ ]]; then # third regular expression
	echo "$1"
fi
