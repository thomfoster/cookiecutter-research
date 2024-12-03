#!/bin/bash

# Usage: source load_env.sh

# Check if a .env file exists
if [[ ! -f .env ]]; then
  echo "Error: .env file not found in the current directory."
  exit 1
fi

# Export each line in the .env file as an environment variable
while IFS='=' read -r key value; do
  # Skip lines that are comments or empty
  if [[ $key =~ ^#.*$ ]] || [[ -z $key ]]; then
    continue
  fi

  # Remove surrounding quotes from the value, if any
  value=$(echo "$value" | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")

  # Export the environment variable
  export "$key=$value"
done < .env

echo "Environment variables successfully exported"