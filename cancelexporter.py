import pandas as pd
import json

# Define the path to the Excel file
excel_file_path = 'C:/tmp/1367-1370cancel.xlsx'

# Define the sheet name in the Excel file
sheet_name = 'Sheet1'

# Read data from the Excel file into a DataFrame
data = pd.read_excel(excel_file_path, sheet_name=sheet_name)

# Create an array to hold the entries
entries = []

# Loop through each row in the DataFrame
for index, row in data.iterrows():
    # Create an entry dictionary and populate it with data from the row
    entry = {
        'episode': row['episode'],
        'Category': row['Category'],
        'context': row['context'],
        'cancelled': row['cancelled']
       
           
    }

    # Add the entry dictionary to the array
    entries.append(entry)

# Define the path to save the JSON data as a text file
output_file_path = 'C:/tmp/1367-1370cancel.json'

# Convert the array of entries to JSON
json_data = json.dumps(entries)

# Save the JSON data to the text file
try:
    with open(output_file_path, 'w') as file:
        file.write(json_data)
    print("JSON data successfully saved to", output_file_path)
except Exception as e:
    print("Error saving JSON data to file:", e)
