#!/bin/bash

# Usage: source load_env.sh

# Check if a .env file exists
if [[ ! -f .env ]]; then
  echo "Error: .env file not found in the current directory."
  exit 1
fi

echo "Exported the following env variables from .env file:"

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

  # Print the name of the variable if it is not an empty string
  if [[ -n $value ]]; then
    echo "Exported: $key"
  fi
done < .env