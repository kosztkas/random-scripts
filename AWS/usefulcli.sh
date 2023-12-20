# Get the instance ID + Name tage in a convenient format
aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value}" --output text

# get a whole lot more information of the EC2 instances
aws ec2 describe-instances --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,ID:InstanceId,Type:InstanceType,AmiID:ImageId,SubnetID:SubnetId,Monitoring:Monitoring.State,AZ:Placement.AvailabilityZone,SG:SecurityGroups[0].GroupName,SourceDestCheck:SourceDestCheck,autorecovery:MaintenanceOptions.AutoRecovery,PMtag:Tags[?Key=='pacemaker']|[0].Value}" --output table

# get volume information, attached to which instance, size, iops, throughput, device name
aws ec2 describe-volumes --query "Volumes[].{ID:VolumeId,InstanceId:Attachments[0].InstanceId,device:Attachments[0].Device,Size:Size,IOPS:Iops,Throughput:Throughput}" --output table

# check a list of instances wether they have stop protection enabled
while read instance; do
	aws ec2 describe-instance-attribute --attribute disableApiStop --instance-id $instance --query "{ID:InstanceId,stop:DisableApiStop.Value}" --output text
done < instancelist.txt

# Run a command on linux instances from awscli via SSM
aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" \
--targets '[{"Key":"InstanceIds","Values":["i-1234567890abcde"]}]' \
--parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["echo "hello"]}' \
--timeout-seconds 600 --max-concurrency "50" --max-errors "0" --region eu-central-1
