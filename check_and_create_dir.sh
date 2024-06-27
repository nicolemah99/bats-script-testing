#!/bin/bash

# Function to check if a directory exists and create it if it doesn't
check_and_create_dir() {
  local dir=$1
  if [ -d "$dir" ]; then
    echo "Directory '$dir' already exists."
  else
    mkdir -p "$dir"
    echo "Directory '$dir' created."
  fi
}

# Check if a directory name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 <directory_name>"
  exit 1
fi

# Call the function with the provided directory name
check_and_create_dir "$1"
