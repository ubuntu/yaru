#!/usr/bin/env python3

import os
import math
import subprocess
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG, format='%(levelname)s: %(message)s')

# Define the nominal size and a dictionary for cursor names and their hotspots (24x24)
nominal_size = 24
cursors = {
    "alias": (10, 10),#
    "all-resize": (11, 11),#
    "all-scroll": (11, 11),#
    "cell": (11, 11),#
    "col-resize": (11, 11),#
    "context-menu": (2, 1),#
    "copy": (2, 1),#
    "crosshair": (11, 11),#
    "default": (3, 3),#
    "e-resize": (11, 11),#
    "ew-resize": (11, 11),#
    "grab": (11, 2),#
    "grabbing": (11, 9),#
    "help": (11, 19),#
    "ne-resize": (11, 11),#
    "nesw-resize": (11, 11),#
    "no-drop": (2, 1),#
    "not-allowed": (11, 11),#
    "n-resize": (11, 11),#
    "ns-resize": (11, 11),#
    "nw-resize": (11, 11),#
    "nwse-resize": (11, 11),#
    "pointer": (8, 3),#
    "progress": {"hotspot": (2, 1), "frames": 60, "duration": 16},#
    "row-resize": (11, 11),#
    "se-resize": (11, 11),#
    "s-resize": (11, 11),#
    "sw-resize": (11, 11),#
    "text": (10, 11),#
    "vertical-text": (11, 10),#
    "text": (10, 11),#
    "wait": {"hotspot": (11, 11), "frames": 60, "duration": 16},#
    "w-resize": (11, 11),#
    "zoom-in": (10, 10),#
    "zoom-out": (10, 10),#
    "X_cursor": (11, 11)
}

# Define the sizes we want to scale to
sizes = [24, 30, 36, 48, 72, 96]

# Base directories
png_dir = './pngs'  # Updated to use "pngs"
output_dir = '../../Yaru/cursors/'

# Function to generate .in file content
def generate_in_file_content(cursor_name, cursor_info):
    in_content = []
    is_animated = isinstance(cursor_info, dict)

    frame_range = range(1, cursor_info["frames"] + 1) if is_animated else [1]
    hotspot = cursor_info["hotspot"] if is_animated else cursor_info

    for frame in frame_range:
        for size in sizes:
            file_name = f"{cursor_name}_{frame:04d}.png" if is_animated else f"{cursor_name}.png"
            png_file_relative = f"pngs/{size}x{size}/{file_name}"
            png_file = os.path.join(png_dir, f"{size}x{size}", file_name)

            if not os.path.exists(png_file):
                logging.error(f"PNG file not found: {png_file}")
                continue

            hotspot_x = math.floor(hotspot[0] * size / nominal_size)
            hotspot_y = math.floor(hotspot[1] * size / nominal_size)

            entry = f"{size} {hotspot_x} {hotspot_y} {png_file_relative}"
            if is_animated:
                entry += f" {cursor_info['duration']}"
            in_content.append(entry + "\n")

    return ''.join(in_content)

# Function to generate all .in files and call xcursorgen
def generate_cursors():
    for cursor_name, cursor_info in cursors.items():
        logging.info(f"Processing cursor: {cursor_name}")

        # Generate the full .in file content
        in_file_content = generate_in_file_content(cursor_name, cursor_info)
        in_file_path = os.path.join(png_dir, f'{cursor_name}.in')

        # Write the .in file in ./pngs/ directory
        try:
            with open(in_file_path, 'w') as in_file:
                in_file.write(in_file_content)
            logging.info(f"Generated .in file: {in_file_path}")
        except Exception as e:
            logging.error(f"Error writing .in file: {in_file_path} - {str(e)}")
            continue

        # Call xcursorgen to generate the cursor file
        cursor_output = os.path.join(output_dir, cursor_name)
        command = ['xcursorgen', in_file_path, cursor_output]
        logging.debug(f"Running command: {' '.join(command)}")
        try:
            subprocess.run(command, check=True)
            logging.info(f"Generated cursor: {cursor_output}")
        except subprocess.CalledProcessError as e:
            logging.error(f"xcursorgen failed for {cursor_name}: {str(e)}")

if __name__ == "__main__":
    # Ensure output directory exists
    if not os.path.exists(output_dir):
        logging.info(f"Creating output directory: {output_dir}")
        os.makedirs(output_dir)

    # Call the main function to generate cursors
    generate_cursors()

