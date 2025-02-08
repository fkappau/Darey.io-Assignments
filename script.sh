#!/bin/bash

echo "Hello, welcome to my Multiplication Table"

#!/bin/bash
# This script creates a multiplication table for a number you choose.
# You can choose a full table (from 1 to 10) or a partial table (a custom range).
# It also gives you a choice of three display styles.

# -------------------------------
# Function: generate_table
# This function prints the multiplication table.
# Parameters:
#   $1 - The number to multiply.
#   $2 - The starting multiplier.
#   $3 - The ending multiplier.
#   $4 - The display style (1, 2, or 3).
# -------------------------------
generate_table() {
  local num=$1      # the number for which we generate the table
  local start=$2    # starting value of the multiplication range
  local end=$3      # ending value of the multiplication range
  local style=$4    # display style chosen by the user

  echo "Multiplication Table for $num (from $start to $end)"
  echo "-----------------------------------"

  # Loop from the start value to the end value
  for (( i = start; i <= end; i++ )); do
    # Check which style the user chose
    if [ "$style" == "1" ]; then
      # Basic display style: 5 x 3 = 15
      echo "$num x $i = $(( num * i ))"
    elif [ "$style" == "2" ]; then
      # Table format: |  5 |  3 | 15 |
      printf "| %2d | %2d | %3d |\n" "$num" "$i" "$(( num * i ))"
    elif [ "$style" == "3" ]; then
      # Aligned format: 5 * 3 = 15 (with aligned columns)
      printf "%-3d * %-3d = %-5d\n" "$num" "$i" "$(( num * i ))"
    else
      # Default style (in case of an unexpected value)
      echo "$num x $i = $(( num * i ))"
    fi
  done

  echo "-----------------------------------"
}

# -------------------------------
# Main Program Loop
# This loop lets the user generate tables repeatedly.
# -------------------------------
while true; do
  # Ask the user for a number.
  read -p "Enter a number for the multiplication table: " number

  # Check that the input is a valid positive number.
  while ! [[ "$number" =~ ^[0-9]+$ ]]; do
    echo "Invalid input. Please enter a valid number."
    read -p "Enter a number for the multiplication table: " number
  done

  # Ask if the user wants a full table (1 to 10) or a partial table.
  read -p "Do you want a full table (1 to 10) or a partial table? (F/P): " choice

  if [[ "$choice" == "P" || "$choice" == "p" ]]; then
    # If partial, ask for the range start and end.
    read -p "Enter the start of the range: " start
    read -p "Enter the end of the range: " end

    # Validate that both start and end are numbers and start is not greater than end.
    while ! [[ "$start" =~ ^[0-9]+$ && "$end" =~ ^[0-9]+$ && "$start" -le "$end" ]]; do
      echo "Invalid range. Make sure both are numbers and the start is less than or equal to the end."
      read -p "Enter the start of the range: " start
      read -p "Enter the end of the range: " end
    done
  else
    # If not partial, use the full range of 1 to 10.
    start=1
    end=10
  fi

  # Ask the user to choose a display style.
  echo "Choose a display style:"
  echo "1) Basic (e.g., 5 x 3 = 15)"
  echo "2) Table Format (e.g., |  5 |  3 | 15 |)"
  echo "3) Aligned Format (e.g., 5 * 3 = 15 with aligned columns)"
  read -p "Enter the display style (1, 2, or 3): " style

  # Call the function to print the multiplication table.
  generate_table "$number" "$start" "$end" "$style"

  # Ask the user if they want to generate another table.
  read -p "Do you want to generate another table? (Y/N): " again
  if [[ ! "$again" =~ ^[Yy]$ ]]; then
    echo "Goodbye!"
    break  # Exit the loop and end the script.
  fi

done
