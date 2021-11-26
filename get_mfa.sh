#! /bin/bash

if [ "$1" != "" ]; then
    aws sts get-session-token --serial-number arn:aws:iam::123456789876:mfa/username --token-code $1 --profile profilename --output json
else
    echo "Please enter the MFA token code"
    echo "Usage: " $0 "[tokencode]"
fi
