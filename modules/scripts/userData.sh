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
export S3_REGION="${S3_REGION}"

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
aws.s3.region=${S3_REGION}
server.port=8080
EOT
log "Database and S3 configurations saved successfully."

# Set correct permissions for application.properties
sudo chown csye6225:csye6225 /opt/csye6225/webapp/application.properties
sudo chmod 600 /opt/csye6225/webapp/application.properties

# Set up systemd service
sudo systemctl daemon-reload
sudo systemctl enable webapp.service

log "User Data Script completed successfully."