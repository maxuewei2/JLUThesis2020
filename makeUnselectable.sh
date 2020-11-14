#!/bin/sh
# copied from https://tex.stackexchange.com/a/127869

GS=gs

$GS -sDEVICE=ps2write        -dNOCACHE -sOutputFile="${1%%.*}-rst.ps"        -q -dBATCH -dNOPAUSE "$1"       -c quit 
ps2pdf "${1%%.*}-rst.ps" "${1%%.*}-rst.pdf"
if [ $? -eq 0 ]; then
    echo "Output written to ${1%%.*}-rst.pdf"
else
    echo "There were errors. See the output."
fi