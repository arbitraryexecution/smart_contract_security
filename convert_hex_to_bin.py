import binascii
import os
import sys

# Make sure there are 3 arguments
if len(sys.argv) != 3:
    sys.exit(f"Usage: ./{sys.argv[0]} <input file> <output_file>")

# Make sure the first arg is the file and ensure it exists
input_fpath = sys.argv[1]
output_fpath = sys.argv[2]

if not os.path.isfile(input_fpath):
    sys.exit(f"ERROR: {input_fpath} is not a valid file!")

with open(input_fpath, "r") as f:
    data = f.read()

# The data may be prefixed with 0x, strip it off if present
if data[:2] == "0x":
    data = data[2:]

# Strip off any whitespace that may be at the end of the file
data = data.rstrip()
data_bytes = binascii.a2b_hex(data)

with open(output_fpath, "wb") as f:
    f.write(data_bytes)

print(f"Finished creating file: {output_fpath}")
