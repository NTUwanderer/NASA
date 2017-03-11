#!/usr/bin/env bash

output=$(last -i \
		| grep -o '[-0-9]\+\.[-0-9]\+\.[-0-9]\+\.[-0-9]' \
#		| grep -v '0\.0\.0\.0' \
		| uniq -c \
		| sort -n)

IFS=$'\n'

for line in 

echo "$output"
