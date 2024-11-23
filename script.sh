#!/bin/bash

# Step 1: Set Variables

INSTANCE_TYPE="t2.micro"         # EC2 Instance Type
KEY_NAME="instace.ppk"           # Your EC2 Key Pair for SSH Access
REGION="us-east-1"               # AWS Region (Change based on your region)
AMI_ID="ami-0866a3c8686eaeeba"   # Ubuntu 20.04 LTS AMI ID (adjust based on region)
INSTANCE_NAME="Jenkins-Instance" # Name for the EC2 Instance

# Jenkins installation script to be used in UserData
USER_DATA_SCRIPT=$(
    cat <<'EOF'
#!/bin/bash

# Update and install dependencies
sudo apt update -y
sudo apt upgrade -y

# Install Java (Jenkins requires Java)
sudo apt install openjdk-11-jdk -y

# Add Jenkins repository and key
wget -q -O - https://pkg.jenkins.io/jenkins.io.key | sudo tee /etc/apt/trusted.gpg.d/jenkins.asc
sudo sh -c 'wget -q -O /etc/apt/sources.list.d/jenkins.list https://pkg.jenkins.io/debian/jenkins.io.repo'

# Install Jenkins
sudo apt update -y
sudo apt install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Open Jenkins port in firewall (if UFW is enabled)
sudo ufw allow 8080
sudo ufw reload

# Output Jenkins Unlock Key
echo "Jenkins is installed and running."
echo "Access Jenkins at http://$INSTANCE_IP:8080"
echo "Unlock Jenkins with the key:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
EOF
)

# Step 2: Create EC2 Instance
echo "Creating EC2 instance..."

INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $(aws ec2 describe-security-groups --query 'SecurityGroups[?GroupName==`default`].GroupId' --output text) \
    --subnet-id $(aws ec2 describe-subnets --query 'Subnets[0].SubnetId' --output text) \
    --region $REGION \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
    --user-data "$USER_DATA_SCRIPT" \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "EC2 Instance $INSTANCE_ID is being created."

# Step 3: Wait for the EC2 instance to be running
echo "Waiting for the instance to be running..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Step 4: Fetch the Public IP of the EC2 Instance
INSTANCE_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "Instance is running. Public IP: $INSTANCE_IP"

echo "Jenkins installation complete. Visit http://$INSTANCE_IP:8080 to set up Jenkins."
