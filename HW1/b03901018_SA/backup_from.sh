#!/usr/bin/env bash

output=$(last -i \
		| grep -o '[-0-9]\+\.[-0-9]\+\.[-0-9]\+\.[-0-9]' \
		| grep -v '0\.0\.0\.0' \
		| sort -n \
		| uniq -c \
		| sort -n)

IFS=$'\n'

count=1

for line in $output; do
	num=$(echo "$line" \
		| awk '{print $1}')
	ip=$(echo "$line" \
		| awk '{print $2}')

	loc=$(geoiplookup "$ip" \
		| cut -f4,5 -d ' ')

	found=false

	for (( i=1; i<count; i++ )); do
		if [ "${locations[$i]}" = "$loc" ]; then
			counters[$i]=$((${counters[$i]} + $num))
			found=true
			break
		fi
	done

	if [ $found == false ]; then
		locations[$count]=$loc
		counters[$count]=$num
		count=$(($count + 1))
		
	fi
done

for (( i=1; i<count; i++ )); do
	printf "%-8s %-8s\n" "${counters[$i]}" "${locations[$i]}"
done

# echo "$output"
