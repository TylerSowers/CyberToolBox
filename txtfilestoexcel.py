#This Script looks at all the files inside a directory that ends with .txt then reads all the contents and then outputs it to an excel sheet with the file name and the contents of the file 
import os
import pandas as pd

# Folder path containing the text files
folder_path = ''

# Get a list of text files in the folder
file_list = [file for file in os.listdir(folder_path) if file.endswith('.txt')]

# Create an empty list to hold the file name and contents
data = []

# Loop through each text file
for file in file_list:
    file_path = os.path.join(folder_path, file)
    
    # Read the contents of the text file
    with open(file_path, 'r') as f:
        contents = f.read()
    
    # Add the file name and contents as a dictionary to the list
    data.append({'File Name': file, 'Contents': contents})

# Create a DataFrame from the list of dictionaries
df = pd.DataFrame(data)

# Define the path for the output Excel file
excel_file_path = 'c:/tmp/output.xlsx'

# Save the DataFrame to an Excel file
df.to_excel(excel_file_path, index=False)

print('Excel file created successfully!')




