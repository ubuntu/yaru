#!/usr/bin/python3
# coding: utf-8
#
# Legal Stuff:
#
# This file is part of the Moka Icon Theme and is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is part of the Moka Icon Theme and is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/lgpl-3.0.txt>
#
#
# Thanks to the GNOME icon developers for the original version of this script
import os
import sys
import xml.sax
import subprocess
import argparse

INKSCAPE = '/usr/bin/inkscape'
OPTIPNG = '/usr/bin/optipng'
MAINDIR = '../usr/share/icons/Mint-Y'
SOURCES = ['apps', 'categories']

# assert ('linux' in sys.platform), "This code runs on Linux only."
assert (os.path.isfile(INKSCAPE)), "Expected to find Inkscape at /usr/bin/inkscape, but file does not exist."
assert (os.path.isfile(OPTIPNG)), "Expected to find OptiPNG at /usr/bin/optipng, but file does not exist."
assert (os.path.isdir(MAINDIR)), "Expected to find Mint-Y at ../usr/share/icons/Mint-Y, but directory does not exist."

# the resolution that non-hi-dpi icons are rendered at (may be 90 or 96 depending on your inkscape build)
inkscape_version = str(subprocess.check_output(['inkscape', '-V'])).split(' ')[1].split('.')
inkscape_version = float(inkscape_version[0] + '.' + inkscape_version[1])
assert (inkscape_version < 1.0), "Expected Inkscape version lower than 1.0. This script doesn't work with Inkscape version 1.0 or higher. This will be changed in the future." 
if inkscape_version < 0.92: # inkscape version 0.92 changed the default dpi from 90 to 96
    DPI_1_TO_1 = 90
else:
    DPI_1_TO_1 = 96
# DPI multipliers to render at
DPIS = [1, 2] # for hidpi icons change to [1, 2] (not yet supported in Mint-Y)

inkscape_process = None

def main(args, SRC):

    def optimize_png(png_file):
        if os.path.exists(OPTIPNG):
            process = subprocess.Popen([OPTIPNG, '-quiet', '-o7', png_file])
            process.wait()

    def wait_for_prompt(process, command=None):
        if command is not None:
            process.stdin.write((command+'\n').encode('utf-8'))

        # This is kinda ugly ...
        # Wait for just a '>', or '\n>' if some other char appearead first
        output = process.stdout.read(1)
        if output == b'>':
            return

        output += process.stdout.read(1)
        while output != b'\n>':
            output += process.stdout.read(1)
            output = output[1:]

    def start_inkscape():
        process = subprocess.Popen([INKSCAPE, '--shell'], bufsize=0, stdin=subprocess.PIPE, stdout=subprocess.PIPE)
        wait_for_prompt(process)
        return process

    def inkscape_render_rect(icon_file, rect, dpi, output_file):
        global inkscape_process
        if inkscape_process is None:
            inkscape_process = start_inkscape()

        cmd = [icon_file,
               '--export-dpi', str(dpi),
               '-i', rect,
               '-e', output_file]
        wait_for_prompt(inkscape_process, ' '.join(cmd))
        optimize_png(output_file)

    class ContentHandler(xml.sax.ContentHandler):
        ROOT = 0
        SVG = 1
        LAYER = 2
        OTHER = 3
        TEXT = 4
        def __init__(self, path, force=False, filter=None):
            self.stack = [self.ROOT]
            self.inside = [self.ROOT]
            self.path = path
            self.rects = []
            self.state = self.ROOT
            self.chars = ""
            self.force = force
            self.filter = filter

        def endDocument(self):
            pass

        def startElement(self, name, attrs):
            if self.inside[-1] == self.ROOT:
                if name == "svg":
                    self.stack.append(self.SVG)
                    self.inside.append(self.SVG)
                    return
            elif self.inside[-1] == self.SVG:
                for attr in attrs.values():
                    if attr == 'Baseplate':
                        self.stack.append(self.LAYER)
                        self.inside.append(self.LAYER)
                        self.context = None
                        self.icon_name = None
                        self.rects = []
                        return
            elif self.inside[-1] == self.LAYER:
                for attr in attrs.values():
                    if attr == "context":
                        self.stack.append(self.TEXT)
                        self.inside.append(self.TEXT)
                        self.text='context'
                        self.chars = ""
                        return
                    if attr == "icon-name":
                        self.stack.append(self.TEXT)
                        self.inside.append(self.TEXT)
                        self.text='icon-name'
                        self.chars = ""
                        return
                    if name == "rect":
                        self.rects.append(attrs)

            self.stack.append(self.OTHER)


        def endElement(self, name):
            stacked = self.stack.pop()
            if self.inside[-1] == stacked:
                self.inside.pop()

            if stacked == self.TEXT and self.text is not None:
                assert self.text in ['context', 'icon-name']
                if self.text == 'context':
                    self.context = self.chars
                elif self.text == 'icon-name':
                    self.icon_name = self.chars
                self.text = None
            elif stacked == self.LAYER:
                assert self.icon_name
                assert self.context

                if self.filter is not None and not self.icon_name in self.filter:
                    return


                new_renders = 0
                updated_renders = 0
                skipped_renders = 0

                # Each rect represents an icon size to export
                for rect in self.rects:
                    for dpi_factor in DPIS:
                        width = rect['width']
                        # height = rect['height']
                        id = rect['id']
                        dpi = DPI_1_TO_1 * dpi_factor

                        size_str = "%s" % (width)
                        if dpi_factor != 1:
                            size_str += "@%sx" % dpi_factor

                        dir = os.path.join(MAINDIR, self.context, size_str)
                        outfile = os.path.join(dir, self.icon_name+'.png')
                        if not os.path.exists(dir):
                            os.makedirs(dir)

                        # If PNG does not exist, create it new
                        if self.force or not os.path.exists(outfile):
                            inkscape_render_rect(self.path, id, dpi, outfile)
                            if args.verbose:
                                print("├─ Rendered new \"".decode('utf-8') + outfile + "\"")
                            new_renders += 1

                        # If PNG exists, compare modify time to that of SVG
                        else:
                            stat_in = os.stat(self.path)
                            stat_out = os.stat(outfile)

                            # If SVG is newer than PNG, replace PNG with updated version
                            if stat_in.st_mtime > stat_out.st_mtime:
                                inkscape_render_rect(self.path, id, dpi, outfile)
                                if args.verbose:
                                    print("├─ Rendered updated \"".decode('utf-8') + outfile + "\"")
                                # print("Rendered updated " + outfile)
                                updated_renders += 1

                            # If PNG is newer than SVG, leave PNG as is
                            else:
                                if args.verbose:
                                    print("├─ \"".decode('utf-8') + outfile + "\" is newer than SVG")
                                skipped_renders += 1
                if args.verbose:
                    print("├────────────────────────────────┤".decode('utf-8'))
                if args.svg is None:
                    print("")
                    print("┌────────────────────────────────┐".decode('utf-8'))
                    print("│ Directory: ".decode('utf-8') + self.context)
                    print("│ Icon Name: ".decode('utf-8') + self.icon_name)
                    print("├────────────────────────────────┤".decode('utf-8'))
                    print("├─ Rendered %d new PNGs".decode('utf-8') % new_renders)
                    print("├─ Rendered %d updated PNGs".decode('utf-8') % updated_renders)
                    print("├─ Skipped %d up-to-date PNGs".decode('utf-8') % skipped_renders)
                    print("└────────────────────────────────┘".decode('utf-8'))
                    print("")

        def characters(self, chars):
            self.chars += chars.strip()

    # If invocation includes a file name, try to process it
    if args.svg:
        file = os.path.join(SRC, args.svg + '.svg')

        if os.path.exists(os.path.join(file)):
            print("├─ Rendering from \"".decode('utf-8') + os.path.join(file) + "\"")
            handler = ContentHandler(file, True, filter=args.filter)
            xml.sax.parse(open(file), handler)
            return True
        else:
            # icon not in this directory, try the next one
            print("├─ Input file \"".decode('utf-8') + file + "\" does not exist.")
            return False

    # If invocation does not include a file name, process all SVGs in listed sources
    else:
        print("Rendering from path \"".decode('utf-8') + SRC + "\"")
        if not os.path.exists(MAINDIR):
            os.mkdir(MAINDIR)

        for file in os.listdir(SRC):
            if file[-4:] == '.svg':
                file = os.path.join(SRC, file)
                handler = ContentHandler(file)
                xml.sax.parse(open(file), handler)
        
        return True

    

parser = argparse.ArgumentParser(description='Render icons from SVG to PNG')

parser.add_argument('svg', type=str, nargs='?', metavar='SVG',
                    help="Optional SVG names (without extensions) to render. If not given, render all icons")
parser.add_argument('filter', type=str, nargs='?', metavar='FILTER',
                    help="Optional filter for the SVG file")
parser.add_argument('--verbose', action='store_true',
                    help="Print verbose output to the terminal")

args = parser.parse_args()

if args.svg is None:
    print("\nNo arguments provided; processing listed sources:\n")
    for source in SOURCES:
        print("-- \"" + os.path.join('.', source) + "\"")
    print("")
else:
    print("┌────────────────────────────────┐".decode('utf-8'))
    print("│ Rendering from command-line argument \"".decode('utf-8') + args.svg + "\"")
    print("├────────────────────────────────┤".decode('utf-8'))

success_directory = ""

for source in SOURCES:
    if os.path.exists(os.path.join('.', source)):
        SRC = os.path.join('.', source)
        if main(args, SRC):
            success_directory = source
    else:
        print("Source path \"" + os.path.join('.', source) + "\" does not exist.")
if args.svg is not None:
    print("└────────────────────────────────┘".decode('utf-8'))

if success_directory != "" and args.svg is not None:
    print("\nSuccessfully processed \"" + args.svg + "\" in \"" + success_directory + "\".\n")
elif success_directory == "" and args.svg is not None:
    print("\nFailed to process \"" + args.svg + "\" in " + success_directory + ".\n")
elif success_directory != "":
    print("Successfully processed listed sources.\n")
elif success_directory == "":
    print("Failed to process listed sources.\n")
else:
    raise Exception("Conditional statement falls through.")
