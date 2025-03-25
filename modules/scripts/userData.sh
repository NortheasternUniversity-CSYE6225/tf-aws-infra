#!/bin/bash

# Exit immediately if a command fails
set -e  

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log "Initializing User Data Script..."

# Load environment variables from Terraform
export DB_HOST="${DB_HOST}"
export DB_PORT="${DB_PORT}"
export DB_NAME="${DB_NAME}"
export DB_USERNAME="${DB_USERNAME}"
export DB_PASSWORD="${DB_PASSWORD}"
export S3_BUCKET_NAME="${S3_BUCKET_NAME}"
export REGION="${REGION}"

# Ensure application directory exists
sudo mkdir -p /opt/csye6225/webapp

# Create application.properties file with environment variables
log "Creating application.properties..."
sudo tee /opt/csye6225/webapp/application.properties > /dev/null <<EOT
# Application Configuration
spring.datasource.url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.hibernate.ddl-auto=update
aws.s3.bucket-name=${S3_BUCKET_NAME}
aws.s3.region=${REGION}
server.port=8080

# Logging
logging.file.name=/var/log/csye6225/webapp.log
logging.level.root=INFO
logging.level.io.micrometer.cloudwatch2=DEBUG

# Enable CloudWatch Metrics
management.metrics.export.cloudwatch.enabled=true
management.metrics.export.cloudwatch.batch-size=10
management.metrics.export.cloudwatch.region=${REGION}
management.metrics.tags.application=webapp
EOT
log "Database and S3 configurations saved successfully."

# Set correct permissions for application.properties
sudo chown csye6225:csye6225 /opt/csye6225/webapp/application.properties
sudo chmod 600 /opt/csye6225/webapp/application.properties

# Ensure log directory
log "Ensuring log directory exists..."
sudo mkdir -p /var/log/csye6225
sudo chown -R csye6225:csye6225 /var/log/csye6225
sudo chmod -R 700 /var/log/csye6225

# Start SystemD service
sudo systemctl daemon-reload
sudo systemctl daemon-reexec
sudo systemctl enable webapp.service
sudo systemctl start webapp.service

# Start CloudWatch Agent
log "Starting CloudWatch Agent..."
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/csye6225/webapp/aws/amazon-cloudwatch-agent/cloudwatch-config.json \
  -s
log "CloudWatch Agent started successfully."

log "User Data Script completed successfully."