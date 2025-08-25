#!/usr/bin/env bash
# simple-interest.sh
# Usage:
#   ./simple-interest.sh PRINCIPAL TIME_YEARS RATE_PERCENT
# or run without args for interactive mode.

set -euo pipefail

is_number() {
  [[ "$1" =~ ^[0-9]+([.][0-9]+)?$ ]]
}

read_inputs_interactive() {
  read -rp "Enter principal (e.g., 1000): " P
  read -rp "Enter time in years (e.g., 2): " T
  read -rp "Enter rate in percent (e.g., 5): " R
}

if [[ $# -eq 3 ]]; then
  P="$1"; T="$2"; R="$3"
else
  read_inputs_interactive
fi

# Validate
if ! is_number "$P" || ! is_number "$T" || ! is_number "$R"; then
  echo "Error: All inputs must be numeric." >&2
  echo "Usage: $0 PRINCIPAL TIME_YEARS RATE_PERCENT" >&2
  exit 1
fi

# Simple Interest = (P * T * R) / 100
SI=$(awk -v p="$P" -v t="$T" -v r="$R" 'BEGIN { printf "%.2f", (p*t*r)/100 }')

echo "Principal : $P"
echo "Time (yr) : $T"
echo "Rate  (%) : $R"
echo "---------------------"
echo "Simple Interest = $SI"
