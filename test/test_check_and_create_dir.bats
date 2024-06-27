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
  [ "$output" = "Usage: $BATS_TEST_DIRNAME/../check_and_create_dir.sh <directory_name> [<directory_name> ...] [--file-content \"<content>\"]" ]
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

@test "check_and_create_dir creates multiple directories" {
  run bash "$BATS_TEST_DIRNAME/../check_and_create_dir.sh" "$TMP_DIR/dir1" "$TMP_DIR/dir2"
  [ "$status" -eq 0 ]
  [ -d "$TMP_DIR/dir1" ]
  [ -d "$TMP_DIR/dir2" ]
  [[ "$output" =~ "Directory '$TMP_DIR/dir1' created." ]]
  [[ "$output" =~ "Directory '$TMP_DIR/dir2' created." ]]
}

@test "check_and_create_dir creates a file with content" {
  run bash "$BATS_TEST_DIRNAME/../check_and_create_dir.sh" "$TMP_DIR/dir_with_file" --file-content "Test content"
  [ "$status" -eq 0 ]
  [ -d "$TMP_DIR/dir_with_file" ]
  [ -f "$TMP_DIR/dir_with_file/info.txt" ]
  [ "$(cat $TMP_DIR/dir_with_file/info.txt)" = "Test content" ]
  [[ "$output" =~ "File 'info.txt' created in '$TMP_DIR/dir_with_file' with content: Test content" ]]
}
