#!/usr/bin/env bats

setup() {
  # Create a temporary directory for testing
  TMP_DIR=$(mktemp -d)
}

teardown() {
  # Remove the temporary directory after testing
  rm -rf "$TMP_DIR"
}

@test "check_and_create_dir shows usage when no arguments are given" {
  run bash "$BATS_TEST_DIRNAME/../check_and_create_dir.sh"
  [ "$status" -eq 1 ]
  [ "$output" = "Usage: $BATS_TEST_DIRNAME/../check_and_create_dir.sh <directory_name>" ]
}

@test "check_and_create_dir creates a new directory" {
  run bash "$BATS_TEST_DIRNAME/../check_and_create_dir.sh" "$TMP_DIR/new_dir"
  [ "$status" -eq 0 ]
  [ -d "$TMP_DIR/new_dir" ]
  [ "$output" = "Directory '$TMP_DIR/new_dir' created." ]
}

@test "check_and_create_dir does not create an existing directory" {
  mkdir -p "$TMP_DIR/existing_dir"
  run bash "$BATS_TEST_DIRNAME/../check_and_create_dir.sh" "$TMP_DIR/existing_dir"
  [ "$status" -eq 0 ]
  [ -d "$TMP_DIR/existing_dir" ]
  [ "$output" = "Directory '$TMP_DIR/existing_dir' already exists." ]
}
