#!/bin/bash
awk '$6 ~ /GET|POST/ {print $7}' access.log | sort | uniq -c | sort -nr
