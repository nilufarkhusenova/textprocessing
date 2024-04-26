#!/bin/bash

# Function to count the number of lines in the file
count_lines() {
    line_count=$(wc -l < "$1")
    echo "Number of lines in the file: $line_count"
}

# Function to count the number of "Z" characters in the file
count_z_characters() {
    z_count=$(grep -o 'Z' "$1" | wc -l)
    echo "Number of 'Z' characters in the file: $z_count"
}

# Function to find on which line is a specific word (not case sensitive)
find_word() {
    word=$1
    line_number=$(grep -in "$word" "$2" | cut -d: -f1)
    echo "Line number of '$word': $line_number"
}

# Function to change "Junior" to "Senior" in the file
change_junior_to_senior() {
     sed 's/Junior/Senior/gI' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
    echo "Changed 'Junior' to 'Senior'."
}

# Main script
read -p "Enter the filename: " filename

if [ ! -f "$filename" ]; then
    echo "File does not exist."
    exit 1
fi

# Debug output to verify the filename
echo "Debug: Filename is '$filename'."

echo "Choose a task to perform:"
echo "1. Count the number of lines in the file"
echo "2. Count the number of 'Z' characters in the file"
echo "3. Find on which line is a specific word (not case sensitive)"
echo "4. Change 'Junior' to 'Senior' in the file"
read -p "Enter your choice (1/2/3/4): " choice

case $choice in
    1)
        count_lines "$filename"
        ;;
    2)
        count_z_characters "$filename"
        ;;
    3)
        read -p "Enter the word to find: " word
        find_word "$word" "$filename"
        ;;
    4)
        change_junior_to_senior "$filename"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
