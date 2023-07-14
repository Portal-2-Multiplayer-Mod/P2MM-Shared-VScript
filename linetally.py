import os
import re

def count_lines(filepath):
    with open(filepath, 'r') as file:
        lines = file.readlines()
        line_count = 0
        char_count = 0
        in_comment = False

        for line in lines:
            line = line.strip()

            # Skip empty lines
            if not line:
                continue

            # Skip single-line comments starting with //
            if line.startswith('//'):
                continue

            # Skip multi-line comments starting with /* and ending with */
            if in_comment:
                if '*/' in line:
                    in_comment = False
                continue
            elif '/*' in line:
                in_comment = True
                continue

            # Exclude inline comments starting with //
            line = re.sub(r'//.*', '', line)

            line_count += 1
            char_count += len(line)
        
        return line_count, char_count


def tally_code_lines(directory):
    total_lines = 0
    total_chars = 0

    for root, _, files in os.walk(directory):
        for file in files:
                filepath = os.path.join(root, file)
                lines, chars = count_lines(filepath)
                total_lines += lines
                total_chars += chars
    
    return total_lines, total_chars


# Specify the directory name where the scripts are located
folder_tree = 'scripts'

# Call the function to tally the lines of code and average characters per line
lines_of_code, total_chars = tally_code_lines(folder_tree)
average_chars_per_line = total_chars / lines_of_code if lines_of_code > 0 else 0

print(f"Total lines of code (excluding comments): {lines_of_code}")
print(f"Total chars: {total_chars:.2f}")
print(f"Average characters per line: {average_chars_per_line:.2f}")
