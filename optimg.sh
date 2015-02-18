#! /bin/sh

if [ -z "$1" ]; then
    echo "Usage: optimize-image.sh filename"
    exit 1;
fi

if [ ! -f "$1" ]; then
    echo "$1 is not a file"
    exit 1;
fi

TYPE=`identify "$1" | grep -E -o 'JPEG|GIF|PNG'`
OLD=`stat -c %s "$1"`

case "$TYPE" in
    JPEG)
        jpegtran -copy none -optimize -perfect -progressive -outfile "$1.tmp" "$1"
        jpegtran -copy none -optimize -perfect -outfile "$1.tmq" "$1"
        if [ -f "$1.tmp" -a -f "$1.tmq" ]; then
            S_PROG=`stat -c %s "$1.tmp"`
            S_NORM=`stat -c %s "$1.tmq"`
            if [ $S_PROG -ge $S_NORM ]; then
                mv -f "$1.tmq" "$1"
                rm -f "$1.tmp"
            else
                mv -f "$1.tmp" "$1"
                rm -f "$1.tmq"
            fi;
        fi
    ;;

    GIF)
        gifsicle -O2 -b "$1"
    ;;

    PNG)
        pngcrush -q -rem alla -fix "$1" "$1.tmp"
        if [ -f "$1.tmp" ]; then
            mv -f "$1.tmp" "$1"
        fi;
        optipng -zc6-9 -zm1-9 -zs0-3 -f0-5 -q -fix "$1"
        advpng -z -4 -q "$1"
    ;;
esac

NEW=`stat -c %s "$1"`
echo "$1, old size: $OLD, new size: $NEW"

