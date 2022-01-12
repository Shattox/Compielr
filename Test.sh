#!/bin/bash

for name in $(find Jeux_Test/Bad_Test/*.tpc)
do
    echo "Fichier $(basename "$name")"
    ./as < $name
    if [ $? == 0 ]
    then
        echo "0"
    fi
done

for name in $(find Jeux_Test/Good_Test/*.tpc)
do
    echo "Fichier $(basename "$name")"
    ./as < $name
    if [ $? == 0 ]
    then
        echo "0"
    fi
done
