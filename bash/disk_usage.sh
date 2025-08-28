#!/usr/bin/env bash
# Lists all filesystems and flags the ones with 0% usage.

# -P = POSIX output (stable columns, no wrapping)
# Exclude common virtual filesystems if you only care about real disks: add
#   -x tmpfs -x devtmpfs -x overlay -x squashfs

df -P | awk 'NR>1 {
  use = ($5 + 0)       # "3%" -> 3, "0%" -> 0
  if (use == 0)
    printf "Found zero usage on %-20s mounted at %-20s (Use=%s, Used=%s)\n", $1, $6, $5, $3
  else
    printf "Not zero      on %-20s mounted at %-20s (Use=%s, Used=%s)\n", $1, $6, $5, $3
}'
