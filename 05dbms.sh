#!/bin/bash

Record_Table="records"

echo "Student Database Menu"
echo "1. Create table"
echo "2. Add a new tuple"
echo "3. View all data"
echo "4. Update a tuple"
echo "5. Delete a tuple"
echo "6. Sort according to ID"
echo "7. Exit"

while true; do
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1)
            if [ -f $Record_Table ]; then
                echo "Table already exists."
            else
                touch $Record_Table
                echo "Table created successfully."
            fi
            ;;
        2)
            echo "Enter student details:"
            read -p "Roll Number: " roll_number
            read -p "Name: " name
            read -p "Age: " age
            read -p "Grade: " grade

            if grep -q "^$roll_number |" $Record_Table; then
                echo "Error: Roll number already exists. Cannot add duplicate entry."
            else
                echo "$roll_number | $name | $age | $grade" >> $Record_Table
                echo "Student record added successfully."
            fi
            ;;
        3)
            if [ -s $Record_Table ]; then
                echo "Student Records:"
                cat $Record_Table
            else
                echo "No records found."
            fi
            ;;
        4)
            echo "Enter student roll number to update:"
            read -p "Roll Number: " roll_number

            if grep -q "^$roll_number |" $Record_Table; then
                echo "Enter updated details:"
                read -p "Name: " new_name
                read -p "Age: " new_age
                read -p "Grade: " new_grade

                grep -v "^$roll_number |" $Record_Table > temp_file
                echo "$roll_number | $new_name | $new_age | $new_grade" >> temp_file
                mv temp_file $Record_Table
                echo "Student record updated successfully."
            else
                echo "Student record not found."
            fi
            ;;
        5)
            echo "Enter student roll number to delete:"
            read -p "Roll Number: " roll_number

            if grep -q "^$roll_number |" $Record_Table; then
                grep -v "^$roll_number |" $Record_Table > temp_file
                mv temp_file $Record_Table
                echo "Student record deleted successfully."
            else
                echo "Student record not found."
            fi
            ;;
        6)
            if [ -s $Record_Table ]; then
                sort $Record_Table > temp_file
                mv temp_file $Record_Table
                echo "Records sorted according to ID."
                echo "Sorted records:"
                cat $Record_Table
            else
                echo "No records found."
            fi
            ;;
        7)
            echo "Exiting program."
            exit 0
            ;;
        *)
            echo "Invalid choice. Enter your choice again."
            ;;
    esac
done