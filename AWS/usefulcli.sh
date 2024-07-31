#!/bin/bash
# Get the instance ID + Name tage in a convenient format
aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output text

# Get the instance Name and public IP
aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value}"

# get a whole lot more information of the EC2 instances
aws ec2 describe-instances --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,ID:InstanceId,Type:InstanceType,AmiID:ImageId,SubnetID:SubnetId,Monitoring:Monitoring.State,AZ:Placement.AvailabilityZone,SG:SecurityGroups[0].GroupName,SourceDestCheck:SourceDestCheck,autorecovery:MaintenanceOptions.AutoRecovery,PMtag:Tags[?Key=='pacemaker']|[0].Value}" --output table

# get volume information, attached to which instance, size, iops, throughput, device name
aws ec2 describe-volumes --query "Volumes[].{ID:VolumeId,InstanceId:Attachments[0].InstanceId,device:Attachments[0].Device,Size:Size,IOPS:Iops,Throughput:Throughput}" --output table

# list running instances
aws ec2 describe-instances --filters Name=instance-state-name,Values=running --query "Reservations[*].Instances[*].InstanceId" --output text

# check a list of instances wether they have stop protection enabled
while read instance; do
	aws ec2 describe-instance-attribute --attribute disableApiStop --instance-id "${instance}" --query "{ID:InstanceId,stop:DisableApiStop.Value}" --output text >> instance_protection_state.txt
done < instances.txt

# turn off stop protection 
while read id; do
    aws ec2 modify-instance-attribute --instance-id "${id}" --no-disable-api-stop
    echo "$id stop protection turned off"
done < protected_instances.txt

# Run a command on linux instances from awscli via SSM
aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" \
--targets '[{"Key":"InstanceIds","Values":["i-1234567890abcde"]}]' \
--parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["echo "hello"]}' \
--timeout-seconds 600 --max-concurrency "50" --max-errors "0" --region eu-central-1

# get the latest Amazon linux AMI ID
aws ssm get-parameter --name /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameter.Value' --output text
# get the latest Ubuntu 22.04 AMI ID
aws ssm get-parameter --name /aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id  --query 'Parameter.Value' --output text

# get the list of latest windows images names in the current region
aws ssm get-parameters-by-path \
    --path /aws/service/ami-windows-latest \
    --query 'Parameters[].Name'

aws backup describe-protected-resource --resource-arn arn:aws:ec2:eu-central-1:123456789876:volume/vol-01231239cbafbfada --query LastBackupTime

# get the list of Critical severity findigs from security hub, grep for the Title and Description only 
aws securityhub get-findings --filters '{"SeverityLabel":[{"Value": "CRITICAL", "Comparison":"EQUALS"}]}' | grep -A1 Title

# get the list of Critical severity findings from security hub, + awscli query option for Title, Description and Resource ARN, better solution:
aws securityhub get-findings --filters '{"SeverityLabel":[{"Value": "CRITICAL", "Comparison":"EQUALS"}]}' --query "Findings[].{Title:Title,Description:Description,Resource:Resources[].Id}"

# refine the search and filter for active and new findings + reusability parameters
aws securityhub get-findings \
    --filters '{"SeverityLabel":[{"Value": "CRITICAL", "Comparison":"EQUALS"}],"RecordState":[{"Value": "ACTIVE", "Comparison":"EQUALS"}],"WorkflowStatus":[{"Value": "NEW", "Comparison":"EQUALS"}]}' \
    --query "Findings[].{Title:Title,Description:Description,Resource:Resources[].Id}" \
    --region eu-west-1 \
    --output json
