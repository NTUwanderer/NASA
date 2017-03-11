#!/usr/bin/env bash

output=$(last -i \
		| grep -o '[-0-9]\+\.[-0-9]\+\.[-0-9]\+\.[-0-9]' \
		| grep -v '0\.0\.0\.0') # regular expression & exclude 0.0.0.0

IFS=$'\n'

count=0
# replace ip address with geographic location
for line in $output; do
	ip=$(echo "$line" \
		| awk '{print $1}')

	loc=$(geoiplookup "$ip" \
		| cut -f4,5 -d ' ')
	locs[count]=$loc

	count=$(($count+1))
done

# format the output
# sort to let same locations to be arranged together
# count
# sort with numbers of occurrence
sorted=$(echo "${locs[*]}" \
		| sort -n \
		| uniq -c \
		| sort -n)

echo "$sorted"
