#!/bin/bash

# Define variables
COMPOSE_FILE_PATH="./compose.yml" # Path to your docker-compose file
# SERVICE_NAME="your_service_name" # Name of the service you want to restart
WORLD_FOLDER="./server-data/world" 
WORLD_COPY_DESTINATION="./backup/tmp-world" 
# Generate a timestamp for the filename
CURRENT_TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ZIP_WORLD_NAME="world-backup-$CURRENT_TIMESTAMP.zip" # Name of the resulting zip file with timestamp

# Navigate to the directory containing the docker-compose file
cd "$(dirname "$COMPOSE_FILE_PATH")" || exit

# Take down the specified Docker Compose container
echo "Taking down the Docker Compose container..."
# "$SERVICE_NAME"
docker-compose down 

# Copy the folder
echo "Copying the folder..."
cp -r "$WORLD_FOLDER" "$WORLD_COPY_DESTINATION"

# Zip the copied folder
echo "Zipping the copied folder..."
cd "$WORLD_COPY_DESTINATION" || exit
zip -r "$ZIP_FILE_NAME" "$(basename "$WORLD_FOLDER")"

rm -r "$WORLD_COPY_DESTINATION"

# Restart the Docker Compose container
echo "Restarting the Docker Compose container..."
# $SERVICE_NAME
docker-compose up -d 
