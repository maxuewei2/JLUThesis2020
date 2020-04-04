#!/bin/sh
# copied from https://tex.stackexchange.com/a/127869

GS=/usr/bin/gs

$GS -sDEVICE=ps2write        -dNOCACHE -sOutputFile=-        -q -dBATCH -dNOPAUSE "$1"       -c quit | ps2pdf - > "${1%%.*}-rst.pdf"
if [ $? -eq 0 ]; then
    echo "Output written to ${1%%.*}-rst.pdf"
else
    echo "There were errors. See the output."
fi