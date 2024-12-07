import pandas as pd
import json

# Define the path to the Excel file
excel_file_path = 'C:/tmp/1483-1492cancel.xlsx'

# Define the sheet name in the Excel file
sheet_name = 'Sheet1'

# Read data from the Excel file into a DataFrame
data = pd.read_excel(excel_file_path, sheet_name=sheet_name)

# Create arrays to hold the entries for both files
full_entries = []
partial_entries = []

# Loop through each row in the DataFrame
for index, row in data.iterrows():
    # Create an entry dictionary for the full data and populate it with data from the row
    full_entry = {
        'episode': row['episode'],
        'Category': row['Category'],
        'context': row['context'],
        'cancelled': row['cancelled']
    }
    # Add the full entry dictionary to the full_entries array
    full_entries.append(full_entry)
    
    # Create an entry dictionary for the partial data and populate it with selected data from the row
    partial_entry = {
        'episode': row['episode'],
        'Category': row['Category'],
        'cancelled': row['cancelled']
    }
    # Add the partial entry dictionary to the partial_entries array
    partial_entries.append(partial_entry)

# Define the paths to save the JSON data as text files
full_output_file_path = 'C:/tmp/1483-1492cancel.json'
partial_output_file_path = 'C:/tmp/1483-1492canceltitles.json'

# Convert the arrays of entries to JSON
full_json_data = json.dumps(full_entries, indent=4)
partial_json_data = json.dumps(partial_entries, indent=4)

# Save the full JSON data to the text file
try:
    with open(full_output_file_path, 'w') as file:
        file.write(full_json_data)
    print("Full JSON data successfully saved to", full_output_file_path)
except Exception as e:
    print("Error saving full JSON data to file:", e)

# Save the partial JSON data to the text file
try:
    with open(partial_output_file_path, 'w') as file:
        file.write(partial_json_data)
    print("Partial JSON data successfully saved to", partial_output_file_path)
except Exception as e:
    print("Error saving partial JSON data to file:", e)
