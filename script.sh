# #!/bin/bash

# # Installation for jenkins Server
# echo "Installation is Starting"

# sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
#     https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
#     https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#     /etc/apt/sources.list.d/jenkins.list >/dev/null

# sudo apt-get update
# sudo apt-get install fontconfig openjdk-17-jre -y
# sudo apt-get install jenkins -y

# sudo apt install maven -y

# export MAVEN_HOME=/usr/share/maven
# export PATH=$MAVEN_HOME/bin:$PATH

# aws ec2 run-instances --image-id "ami-0866a3c8686eaeeba" --instance-type "t2.micro" --key-name "Jenkins-key" --block-device-mappings '{"DeviceName":"/dev/sda1","Ebs":{"Encrypted":false,"DeleteOnTermination":true,"Iops":3000,"SnapshotId":"snap-021176b1e05cb6895","VolumeSize":40,"VolumeType":"gp3","Throughput":125}}' --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0167e80afe33395db"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Jenkins-Server"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1" 


# aws ec2 create-key-pair --key-name "Jenkins-key" --key-type "rsa" --key-format "ppk" 
# aws ec2 create-security-group --group-name "launch-wizard-1" --description "launch-wizard-1 created 2024-11-24T02:52:25.490Z" --vpc-id "vpc-0733fda56a9b0dc42" 
# aws ec2 authorize-security-group-ingress --group-id "sg-0167e80afe33395db" --ip-permissions '{"IpProtocol":"tcp","FromPort":22,"ToPort":22,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' '{"IpProtocol":"tcp","FromPort":443,"ToPort":443,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' '{"IpProtocol":"tcp","FromPort":80,"ToPort":80,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' 
# aws ec2 run-instances --image-id "ami-0866a3c8686eaeeba" --instance-type "t2.micro" --key-name "Jenkins-key" --block-device-mappings '{"DeviceName":"/dev/sda1","Ebs":{"Encrypted":false,"DeleteOnTermination":true,"Iops":3000,"SnapshotId":"snap-021176b1e05cb6895","VolumeSize":40,"VolumeType":"gp3","Throughput":125}}' --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0167e80afe33395db"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Jenkins-Server"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1" 