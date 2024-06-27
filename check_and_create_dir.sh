#!/bin/bash

# Function to check if a directory exists and create it if it doesn't
check_and_create_dir() {
  local dir=$1
  local file_content=$2
  if [ -d "$dir" ]; then
    echo "Directory '$dir' already exists."
  else
    mkdir -p "$dir"
    echo "Directory '$dir' created."
    if [ -n "$file_content" ]; then
      echo "$file_content" > "$dir/info.txt"
      echo "File 'info.txt' created in '$dir' with content: $file_content"
    fi
  fi
}

# Check if at least one directory name was provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <directory_name> [<directory_name> ...] [--file-content \"<content>\"]"
  exit 1
fi

# Initialize variables
dirs=()
file_content=""

# Parse arguments
while [[ "$1" != "" ]]; do
  case $1 in
    --file-content )
      shift
      file_content=$1
      ;;
    * )
      dirs+=("$1")
      ;;
  esac
  shift
done

# Create directories
for dir in "${dirs[@]}"; do
  check_and_create_dir "$dir" "$file_content"
done
