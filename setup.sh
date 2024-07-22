#!/bin/bash
update -y
upgrade -y
apt install htop -y
curl -fsSL https://ollama.com/install.sh | sh

# Define the service file path
SERVICE_FILE="/etc/systemd/system/ollama.service"

# Check if the service file exists
if [ ! -f "$SERVICE_FILE" ]; then
  echo "Error: $SERVICE_FILE does not exist."
  exit 1
fi

# Get the number of CPUs available
num_cpus=$(nproc)

# Subtract 4 from the number of CPUs
num_threads=$((num_cpus - 4))

# Check if OLLAMA_NUM_THREADS is already set
if [ -z "${OLLAMA_NUM_THREADS}" ]; then
    # If OLLAMA_NUM_THREADS is not set, set it to num_threads
    export OLLAMA_NUM_THREADS=$num_threads
    echo "OLLAMA_NUM_THREADS was not set. It is now set to $OLLAMA_NUM_THREADS."
else
    echo "OLLAMA_NUM_THREADS is already set to $OLLAMA_NUM_THREADS. No changes were made."
fi

# Check if the environment variable is already set
if grep -q "Environment=\"OLLAMA_HOST=0.0.0.0\"" "$SERVICE_FILE"; then
  echo "OLLAMA_HOST is already set to 0.0.0.0. No changes were made."
else
  # Add the environment variable to the service file
  sed -i '/\[Service\]/a Environment="OLLAMA_HOST=0.0.0.0"' "$SERVICE_FILE"

  # Reload the systemd daemon to apply the changes
  systemctl daemon-reload

  # Restart the Ollama service
  systemctl restart ollama
fi






loadmodel() {
 echo "Running model: $1"
 ollama pull $1
}

      loadmodel  "phi3" 
      loadmodel "llama3" 
      loadmodel "llama3:70b" 
      loadmodel "codellama" 
      loadmodel "mixtral" 

# Wait for 
