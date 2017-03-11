#!/usr/bin/env bash

# Tell bash to loop by line, instead of by space
IFS=$'\n'

# Loop through each line
for entry in $(cat raw-ip-list.txt); do
    
	# Extract IP, we use 'grep' to validate the field
    ip=$(echo "$entry" \
        | cut -f4 -d'"' \
        | grep '[-0-9]\+\.[-0-9]\+\.[-0-9]\+\.[-0-9]')
    
    # Extract coordinates, we use 'grep' to validate the field
    location=$(echo "$entry" \
        | cut -f24 -d'"' \
        | grep '[-0-9\.]\+,[-0-9\.]\+')

	echo "$ip"

	echo "$location"
done

