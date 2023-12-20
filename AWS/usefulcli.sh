# Get the instance ID + Name tage in a convenient format
aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output text

# Run a command on linux instances from awscli via SSM
aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" \
--targets '[{"Key":"InstanceIds","Values":["i-1234567890abcde"]}]' \
--parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["echo "hello"]}' \
--timeout-seconds 600 --max-concurrency "50" --max-errors "0" --region eu-central-1
