# resize img.jpg 500x500 media
thumb(){
	EXT="${1##*.}"
	FN="${1%.*}"
	SIZES="$2"
	SUF="$3"
	
	if [ -z "$SUF" ]
	then
		SUF="thumb"
	fi
	
	convert $1 -resize $SIZES "${FN}_$SUF.$EXT"
}

