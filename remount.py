# DEVELOPER FILE1
# purpose: remount the files to the game after a change

import os,shutil

os.chdir(os.path.dirname(os.path.abspath(__file__)))

# Define the source and destination folders
source_folder = 'scripts'
destination_folder = 'C:\\Users\\kyle\\Documents\\GitHub\\P2MM-Entanglement\\src\\.builtserver\\portal2\\scripts'

# Copy the source folder to the destination folder
shutil.copytree(source_folder, destination_folder, dirs_exist_ok=True)