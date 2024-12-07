import pandas as pd
import json

# Function to read the content of a file
def read_file_content(file_path):
    encodings = ['utf-8', 'latin1']  # Add more encodings if needed
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as file:
                content = file.read()
            return content
        except Exception as e:
            print(f"Error reading file with encoding {encoding}: {e}")
    print("Unable to read file:", file_path)
    return None

# Function to read YouTube chapters from a JSON file
def read_chapters(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            chapter_data = json.load(file)
        return chapter_data.get('chapters', [])  # Return 'chapters' field if exists, else an empty list
    except Exception as e:
        print(f"Error reading chapters from file {file_path}: {e}")
    return []

# Define paths
excel_file_path = 'C:\\scripts\\Python\\ninjas\\Ninjas.xlsx'
output_file_path = 'C:\\scripts\\Python\\ninjas\\Ninjasexport.json'
titled_output_file_path = 'C:\\scripts\\Python\\ninjas\\Ninjasexporttitles.json'
sheet_name = 'sheet1'

# Read data from the Excel file into a DataFrame
data = pd.read_excel(excel_file_path, sheet_name=sheet_name)

# Create arrays to hold the entries
entries = []
titled_entries = []

# Loop through each row in the DataFrame
for index, row in data.iterrows():
    # Read transcript content
    transcript_content = read_file_content(row['transcripts'])

    # Read the YouTube chapters using the path directly from the Excel sheet
    chapters = read_chapters(row['chapters'])

    # Create an entry dictionary and populate it with data from the row
    entry = {
        'title': row['title'],
        'episode': row['episode'],
        'transcripts': transcript_content,
        'chapters': chapters  # Add chapters to the JSON entry
    }

    # Create a titled entry dictionary with only title and episode
    titled_entry = {
        'title': row['title'],
        'episode': row['episode']
    }

    # Add the entry dictionary to the arrays
    entries.append(entry)
    titled_entries.append(titled_entry)

# Convert the array of entries to JSON
json_data = json.dumps(entries, indent=4)
titled_json_data = json.dumps(titled_entries, indent=4)

# Save the JSON data to the text files
try:
    with open(output_file_path, 'w', encoding='utf-8') as file:
        file.write(json_data)
    print(f"JSON data successfully saved to {output_file_path}")
except Exception as e:
    print(f"Error saving JSON data to file: {e}")

try:
    with open(titled_output_file_path, 'w', encoding='utf-8') as file:
        file.write(titled_json_data)
    print(f"Titled JSON data successfully saved to {titled_output_file_path}")
except Exception as e:
    print(f"Error saving titled JSON data to file: {e}")
