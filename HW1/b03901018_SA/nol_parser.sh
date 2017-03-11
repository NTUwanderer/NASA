g=false
while getopts f:g o; do
	case "$o" in
		f)	file=${OPTARG};;
		g)	g=true;;
	esac
done
# shift $OPTIND-1

if [ -z "${file}" ]; then
	echo "Missing input file"
	exit
fi

IFS=$'\n'

if [ ! -f "$file" ]; then
	echo "Input file not found"
	exit
fi

for entry in $(sed -n 782,916p "$file"); do
	course_name=$(echo "$entry" \
				| cut -f12 -d '>' \
				| sed 's/<\/A//g')
	# echo "$course_name"
	prof_name=$(echo "$entry" \
				| cut -f24 -d '>' \
				| sed 's/<\/A//g' \
				| sed 's/<TD/N\/A/g')
	course_time=$(echo "$entry" \
				| awk -F"</TD>" '{print $12}' \
				| sed 's/<TD>//g' \
				| sed 's/ //g' \
				| sed 's/&nbsp;/N\/A/g' \
				| awk -F"<b>" '{print $1}' \
				| cut -d'(' -f1)
	printf "%-50s\t%-20s\t%-10s\n" "$course_name" "$prof_name" "$course_time"
done

