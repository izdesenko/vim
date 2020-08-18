#!/bin/bash

for I in $(seq 0 $1) ;
do
    HOST="node$I.server.com"
    TEST="$(ssh -o BatchMode=yes -t "$HOST" 'exit;' 2>&1)"

    if [[ $TEST == *"Permission denied"* ]]; then
        echo "$I"
    fi
done
    
