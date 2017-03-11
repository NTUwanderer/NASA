#!/usr/bin/env bash

# use /etc/localtime instead of /etc/local
current_time=$(zdump /etc/localtime \
				| cut -f6 -d ' ' \
				| grep '[-0-9]\{2\}:[-0-9]\{2\}:[-0-9]\{2\}') # regular expression

# get total wake seconds to compute
wake_seconds=$(cat /proc/uptime \
				| cut -f1 -d '.')
days=" "

# show day(s) if wake seconds is greater or equal to a day
if test $wake_seconds -ge 86400; then
	num=$((wake_seconds/86400))
	if test $num -ge 2; then
		days=" $num days, "
	else
		days=" $num day, "
	fi
fi

# compute the remainder of seconds
wake_seconds=$((wake_seconds%86400))

if test $wake_seconds -ge 3600; then
	hour=$((wake_seconds/3600))
	min=$(((wake_seconds/60)%60))

	if test $min -lt 10; then
		min="0$min"
	fi

	
	if test $hour -ge 10; then
		wake_period="$hour:$min"
	else
		wake_period=" $hour:$min"
	fi
else
	min=$((wake_seconds/60))

	if test $min -ge 10; then
		wake_period="$min min"
	else
		wake_period=" $min min"
	fi
fi

wake_period="$days$wake_period,"

if [ "$days" = " " ]; then
	wake_period="$wake_period "
fi

num_of_users=$(who | wc -l)

# show the users(s)
if test $num_of_users -ge 2; then
	users="$num_of_users users"
else
	users="1 user"
fi

# show the load average
loading=$(cat /proc/loadavg \
			| cut -d " " -f1,2,3 \
			| sed -e 's/ /, /g') # add a comma before spaces

echo " $current_time up$wake_period $users,  load average: $loading"

