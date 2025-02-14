#!/bin/bash
keyword="Portugál"

next_date=$(curl -Ls https://aldi.hu/hu/ajanlatok.html | grep $keyword -A1 | sed -n 's/.*href="\([^"]*\)".*/\1/p' | sed -n 's/.*d\.\([0-9]*-[0-9]*-[0-9]*\)\.html/\1/p')

if [[ $next_date ]];
then
   /usr/local/bin/aws sns publish --topic-arn arn:aws:sns:eu-central-1:679454738607:Aldi-checker --message "$keyword napok: $next_date"
fi
