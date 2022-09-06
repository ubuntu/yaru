#!/usr/bin/python3
#
# Legal Stuff:
#
# This file is part of the Yaru Icon Theme and is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is part of the Yaru Icon Theme and is distributed in the hope that it will be useful, but WITHOUT
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


OPTIPNG = "optipng"
SOURCES = (
    "actions",
    "apps",
    "categories",
    "devices",
    "emblems",
    "legacy",
    "mimetypes",
    "places",
    "status",
    "wip",
)

# DPI multipliers to render at
DPIS = [1, 2]


def main(args, SRC, DEST):
    def optimize_png(png_file):
        if os.path.exists(OPTIPNG):
            process = subprocess.Popen([OPTIPNG, "-quiet", "-o7", png_file])
            process.wait()

    def wait_for_prompt(process, command=None):
        if command is not None:
            process.stdin.write((command + "\n").encode("utf-8"))

        # This is kinda ugly ...
        # Wait for just a '>', or '\n>' if some other char appearead first
        output = process.stdout.read(1)
        if output == b">":
            return

        output += process.stdout.read(1)
        while output != b"\n>":
            output += process.stdout.read(1)
            output = output[1:]

    def inkscape_render_rect(icon_file, rect, dpi, output_file):
        cmd = [
            "inkscape",
            "--batch-process",
            "--export-dpi={}".format(str(dpi)),
            "-i",
            rect,
            "--export-filename={}".format(output_file),
            icon_file,
        ]
        ret = subprocess.run(cmd, capture_output=True)
        if ret.returncode != 0:
            print("execution of")
            print('  %s' % "".join(cmd))
            print("returned with error %d" % ret.returncode)
            print(5*"=", "stdout", 5*"=")
            print(ret.stdout.decode())
            print(5*"=", "stderr", 5*"=")
            print(ret.stderr.decode())
            return

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
                if (
                    name == "g"
                    and ("inkscape:groupmode" in attrs)
                    and ("inkscape:label" in attrs)
                    and attrs["inkscape:groupmode"] == "layer"
                    and attrs["inkscape:label"].startswith("Baseplate")
                ):
                    self.stack.append(self.LAYER)
                    self.inside.append(self.LAYER)
                    self.context = None
                    self.icon_name = None
                    self.rects = []
                    return
            elif self.inside[-1] == self.LAYER:
                if (
                    name == "text"
                    and ("inkscape:label" in attrs)
                    and attrs["inkscape:label"] == "context"
                ):
                    self.stack.append(self.TEXT)
                    self.inside.append(self.TEXT)
                    self.text = "context"
                    self.chars = ""
                    return
                elif (
                    name == "text"
                    and ("inkscape:label" in attrs)
                    and attrs["inkscape:label"] == "icon-name"
                ):
                    self.stack.append(self.TEXT)
                    self.inside.append(self.TEXT)
                    self.text = "icon-name"
                    self.chars = ""
                    return
                elif name == "rect":
                    self.rects.append(attrs)

            self.stack.append(self.OTHER)

        def endElement(self, name):
            stacked = self.stack.pop()
            if self.inside[-1] == stacked:
                self.inside.pop()

            if stacked == self.TEXT and self.text is not None:
                assert self.text in ["context", "icon-name"]
                if self.text == "context":
                    self.context = self.chars
                elif self.text == "icon-name":
                    self.icon_name = self.chars
                self.text = None
            elif stacked == self.LAYER:
                assert self.icon_name
                assert self.context

                if self.filter is not None and not self.icon_name in self.filter:
                    return

                print(self.context, self.icon_name)
                for rect in self.rects:
                    for dpi_factor in DPIS:
                        width = int(float(rect["width"]))
                        height = int(float(rect["height"]))
                        id = rect["id"]
                        dpi = 96 * dpi_factor

                        size_str = "%sx%s" % (width, height)
                        if dpi_factor != 1:
                            size_str += "@%sx" % dpi_factor

                        dir = os.path.join(DEST, size_str, self.context)
                        outfile = os.path.join(dir, self.icon_name + ".png")
                        if not os.path.exists(dir):
                            os.makedirs(dir)
                        # Do a time based check!
                        if self.force or not os.path.exists(outfile):
                            inkscape_render_rect(self.path, id, dpi, outfile)
                            sys.stdout.write(".")
                        else:
                            stat_in = os.stat(self.path)
                            stat_out = os.stat(outfile)
                            if stat_in.st_mtime > stat_out.st_mtime:
                                inkscape_render_rect(self.path, id, dpi, outfile)
                                sys.stdout.write(".")
                            else:
                                sys.stdout.write("-")
                        sys.stdout.flush()
                sys.stdout.write("\n")
                sys.stdout.flush()

        def characters(self, chars):
            self.chars += chars.strip()

    rendered_icons = 0
    if not args.svg:
        print("Rendering all SVGs in", SRC)
        print('')
        if not os.path.exists(DEST):
            os.mkdir(DEST)

        for svg in os.listdir(SRC):
            file = os.path.join(SRC, svg)
            if os.path.exists(file):
                handler = ContentHandler(file, True, filter=args.filter)
                xml.sax.parse(open(file), handler)
                rendered_icons += 1
                print('')
    else:
        svg = args.svg + ".svg"
        file = os.path.join(SRC, svg)

        if os.path.exists(file):
            print('Rendering SVG "%s" in %s' % (svg, SRC))
            handler = ContentHandler(file, True, filter=args.filter)
            xml.sax.parse(open(file), handler)
            rendered_icons += 1
        else:
            print(
                'Could not find SVG "%s" in %s, looking into the next one' % (svg, SRC)
            )
            # icon not in this directory, try the next one
            pass

    return rendered_icons


parser = argparse.ArgumentParser(description="Render icons from SVG to PNG")

parser.add_argument(
    '--source-path',
    type=str,
    default=None,
    help='Path where to look for source svg files. Script path by default'
)
parser.add_argument(
    '--dest-path',
    type=str,
    default=None,
    help='Path where to save generated svg files. Script path by default'
)
parser.add_argument(
    '--variant',
    type=str,
    default='default',
    help='Variant name to render. If not given, render the default variant'
)
parser.add_argument(
    '--categories',
    type=str,
    default=None,
    help='Only look for icons in a specified categories'
)
parser.add_argument(
    "svg",
    type=str,
    nargs="?",
    metavar="SVG",
    help="Optional SVG names (without extensions) to render. If not given, render all icons",
)
parser.add_argument(
    "filter",
    type=str,
    nargs="?",
    metavar="FILTER",
    help="Optional filter for the SVG file",
)

args = parser.parse_args()

script_path = os.path.abspath(os.path.dirname(sys.argv[0]))
source_path = args.source_path if args.source_path else script_path
dest_path = args.dest_path if args.dest_path else os.path.join(script_path, '../../')
rendered_icons = 0

for source in SOURCES:
    if args.categories and source not in args.categories:
        continue

    SRC = os.path.join(source_path, args.variant, source)
    DEST = os.path.abspath(os.path.join(dest_path, "Yaru" if args.variant ==
                                        'default' else "Yaru-" + args.variant))
    if os.path.exists(SRC):
        rendered_icons += main(args, SRC, DEST)

if rendered_icons == 0:
    print('No SVG found to render')
    sys.exit(1)
