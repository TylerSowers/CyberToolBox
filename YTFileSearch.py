import os

# Enter the directory path where the files are located
directory_path = "C:\\Users\\tsowers\\OneDrive - UKTS\Documents\\vscode\\SweetBabyGang\\AllEpisodes900"

# Enter the text to search
search_text = "shopping cart"

# Loop through all the files in the directory
for filename in os.listdir(directory_path):
    # Check if the file is a text file
    if filename.endswith(".txt"):
        # Open the file and read the contents
        with open(os.path.join(directory_path, filename), "r") as file:
            contents = file.read()
            count = contents.count(search_text)
            # Check if the search text is present in the contents
            if search_text in contents.lower():
                print(f"{filename} contains the search text." + 'This was found: ' + str(count))