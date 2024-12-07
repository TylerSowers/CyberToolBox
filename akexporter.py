import pandas as pd
import json

# Function to read the content of the file
def read_file_content(file_path):
    encodings = ['utf-8', 'latin1']  # Add more encodings if needed
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as file:
                content = file.read()
            return content
        except Exception as e:
            print("Error reading file with encoding {}: {}".format(encoding, e))
    print("Unable to read file:", file_path)
    return None

# Define the path to the Excel file
excel_file_path = 'C:\\tmp\\ak1208.xlsx'

# Define the sheet name in the Excel file
sheet_name = 'Sheet1'

# Read data from the Excel file into a DataFrame
data = pd.read_excel(excel_file_path, sheet_name=sheet_name)

# Create an array to hold the entries
entries = []
titled_entries = []

# Loop through each row in the DataFrame
for index, row in data.iterrows():
    # Read the content of the file
    transcript_content = read_file_content(row['transcript'])
    
    # Create an entry dictionary and populate it with data from the row
    entry = {
        'title': row['title'],
        'transcript': transcript_content,
        'episode': row['episode']
    }
    
    # Create a titled entry dictionary with only title and episode
    titled_entry = {
        'title': row['title'],
        'episode': row['episode']
    }

    # Add the entry dictionary to the array
    entries.append(entry)
    titled_entries.append(titled_entry)

# Define the path to save the JSON data as a text file
output_file_path = 'C:\\tmp\\ak1208.json'
titled_output_file_path = 'C:\\tmp\\ak1208titles.json'

# Convert the array of entries to JSON
json_data = json.dumps(entries)
titled_json_data = json.dumps(titled_entries)

# Save the JSON data to the text files
try:
    with open(output_file_path, 'w') as file:
        file.write(json_data)
    print("JSON data successfully saved to", output_file_path)
except Exception as e:
    print("Error saving JSON data to file:", e)

try:
    with open(titled_output_file_path, 'w') as file:
        file.write(titled_json_data)
    print("Titled JSON data successfully saved to", titled_output_file_path)
except Exception as e:
    print("Error saving titled JSON data to file:", e)
