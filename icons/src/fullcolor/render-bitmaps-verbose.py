#!/usr/bin/python3
# coding: utf-8
#
# Original Version Copyright (C) by the GNOME icon developers
#
# Modifications Copyright (C) by Moka Icon Theme developers
# Modifications Copyright (C) by Yaru Icon Theme developers
# Modifications Copyright (C) by Elsie Hupp <gpl at elsiehupp dot com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.


import os
import sys
import xml.sax
import subprocess
import argparse


def optimize_png(png_file, args):

    if os.path.exists(args.optipng_path):
        process = subprocess.Popen([args.optipng_path, '-quiet', '-o7', png_file])
        process.wait()


def inkscape_render_rect(icon_file, rect, dpi, output_file, args):

    cmd = ["inkscape",
        "--batch-process",
        '--export-dpi={}'.format(str(dpi)),
        '--export-id={}'.format(str(rect)),
        '--export-filename={}'.format(output_file),
        icon_file]

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

    optimize_png(output_file, args)


class ContentHandler(xml.sax.ContentHandler):
    ROOT = 0
    SVG = 1
    LAYER = 2
    OTHER = 3
    TEXT = 4
    def __init__(self, path, args, force=False):
        self.args = args
        self.stack = [self.ROOT]
        self.inside = [self.ROOT]
        self.path = path
        self.rects = []
        self.state = self.ROOT
        self.chars = ""
        self.force = force
        self.filter = args.filter

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
                for dpi_factor in self.args.scaling_factors:
                    width = rect['width']
                    # height = rect['height']
                    id = rect['id']
                    dpi = self.args.base_dpi * dpi_factor

                    size_str = "%s" % (width)
                    if dpi_factor != 1:
                        size_str += "@%sx" % dpi_factor

                    dir = os.path.join(self.args.output_path, self.context, size_str)
                    outfile = os.path.join(dir, self.icon_name+'.png')
                    if not os.path.exists(dir):
                        os.makedirs(dir)

                    # If PNG does not exist, create it new
                    if self.force or not os.path.exists(outfile):
                        inkscape_render_rect(self.path, id, dpi, outfile, self.args)
                        if self.args.verbose:
                            print("├─ Rendered new \"" + outfile + "\"")
                        new_renders += 1

                    # If PNG exists, compare modify time to that of SVG
                    else:
                        stat_in = os.stat(self.path)
                        stat_out = os.stat(outfile)

                        # If SVG is newer than PNG, replace PNG with updated version
                        if stat_in.st_mtime > stat_out.st_mtime:
                            inkscape_render_rect(self.path, id, dpi, outfile)
                            if self.args.verbose:
                                print("├─ Rendered updated \"" + outfile + "\"")
                            # print("Rendered updated " + outfile)
                            updated_renders += 1

                        # If PNG is newer than SVG, leave PNG as is
                        else:
                            if self.args.verbose:
                                print("├─ \"" + outfile + "\" is newer than SVG")
                            skipped_renders += 1

            # Print horizontal rule below long list
            if self.args.verbose:
                print("├────────────────────────────────┤")

            # Print summary
            if self.args.individual_icons is None:
                print("")
                print("┌────────────────────────────────┐")
                print("│ Directory: " + self.context)
                print("│ Icon Name: " + self.icon_name)
                print("├────────────────────────────────┤")
                print("├─ Rendered %d new PNGs" % new_renders)
                print("├─ Rendered %d updated PNGs" % updated_renders)
                print("├─ Skipped %d up-to-date PNGs" % skipped_renders)
                print("└────────────────────────────────┘")
                print("")

    def characters(self, chars):
        self.chars += chars.strip()


def render_category(args, category_to_render):

    # If invocation includes a file name, try to process it
    if args.individual_icons:
        file = os.path.join(category_to_render, args.individual_icons + '.svg')

        if os.path.exists(os.path.join(file)):
            print("├─ Rendering from \"" + os.path.join(file) + "\"")
            #
            # ContentHandler() implements an interface for xml.sax.parse()
            #
            handler = ContentHandler(file, args, True)
            #
            # xml.sax.parse() uses the various ContentHandler() methods behind the scenes
            #
            xml.sax.parse(open(file), handler)
            return True
        else:
            # icon not in this directory, try the next one
            print("├─ Input file \"" + file + "\" does not exist.")
            return False

    # If invocation does not include a file name, process all SVGs in listed sources
    else:
        print("Rendering from path \"" + category_to_render + "\"")
        if not os.path.exists(args.output_path):
            os.mkdir(args.output_path)

        # this is the loop for the files in the given directory
        for file in os.listdir(category_to_render):
            if file[-4:] == '.svg':
                file = os.path.join(category_to_render, file)
                #
                # ContentHandler() implements an interface for xml.sax.parse()
                #
                handler = ContentHandler(file, args)
                #
                # xml.sax.parse() uses the various ContentHandler() methods behind the scenes
                #
                xml.sax.parse(open(file), handler)
        
        return True


def check_dependencies(args):

    # assert ('linux' in sys.platform), "This code runs on Linux only."
    assert (os.path.isfile(args.inkscape_path)), "Expected to find Inkscape at " + args.inkscape_path + ", but file does not exist."
    assert (os.path.isfile(args.optipng_path)), "Expected to find OptiPNG at " + args.optipng_path + " but file does not exist."
    assert (os.path.isdir(args.output_path)), "Expected to find output directory at " + args.output_path + ", but directory does not exist."


def print_help():

    print("")
    print("┌──────────────────────────────────────────────────┐")
    print("│ Render icons from SVG to PNG                     │")
    print("└──────────────────────────────────────────────────┘")
    print("┌──────────────────────────────────────────────────┐")
    print("│ Usage                                            │")
    print("├──────────────────────────────────────────────────┤")
    print("│ $ [./]render-bitmaps-verbose.py                  │")
    print("│       [--help]                                   │")
    print("│       [--base_dpi BASE_DPI]                      │")
    print("│       [--categories [CATEGORIES]]                │")
    print("│       [--filter FILTER]                          │")
    print("│       [--inkscape_path INKSCAPE_PATH]            │")
    print("│       [--individual_icons [INDIVIDUAL_ICONS]]    │")
    print("│       [--optipng_path OPTIPNG_PATH]              │")
    print("│       [--output_path OUTPUT_PATH]                │")
    print("│       [--scaling_factors [SCALING_FACTORS]]      │")
    print("│       [--verbose]                                │")
    print("│                                                  │")
    print("└──────────────────────────────────────────────────┘")
    print("┌──────────────────────────────────────────────────┐")
    print("│ Optional Arguments                               │")
    print("├──────────────────────────────────────────────────┤")
    print("│ --help                                           │")
    print("│                                                  │")
    print("│   Show this help message and exit.               │")
    print("│                                                  │")
    print("│ --base_dpi BASE_DPI                              │")
    print("│                                                  │")
    print("│   dpi to use for rendering (by default 96)       │")
    print("│                                                  │")
    print("│ --categories [CATEGORIES]                        │")
    print("│                                                  │")
    print("│   categories of icons to render (by default all) │")
    print("│                                                  │")
    print("│ --filter FILTER                                  │")
    print("│                                                  │")
    print("│   Inkscape filter to apply while rendering       │")
    print("│   (by default none)                              │")
    print("│                                                  │")
    print("│ --inkscape_path INKSCAPE_PATH                    │")
    print("│                                                  │")
    print("│   path of Inkscape executable                    │")
    print("│   (if the script can't find it)                  │")
    print("│                                                  │")
    print("│ --individual_icons [INDIVIDUAL_ICONS]            │")
    print("│                                                  │")
    print("│   individual icon names (without extensions)     │")
    print("│   to render (by default all)                     │")
    print("│                                                  │")
    print("│ --optipng_path OPTIPNG_PATH                      │")
    print("│                                                  │")
    print("│   path of OptiPNG executable                     │")
    print("│   (if the script can't find it)                  │")
    print("│                                                  │")
    print("│ --output_path OUTPUT_PATH                        │")
    print("│                                                  │")
    print("│   output directory (by default '../../Suru')     │")
    print("│                                                  │")
    print("│ --scaling_factors [SCALING_FACTORS]              │")
    print("│                                                  │")
    print("│   scaling factors to render at                   │")
    print("│   (by default [1, 2], e.g. 100% & 200%)          │")
    print("│                                                  │")
    print("│ --verbose                                        │")
    print("│                                                  │")
    print("│   print verbose output to the terminal           │")
    print("│                                                  │")
    print("└──────────────────────────────────────────────────┘")
    print("")
    return


def print_categories():

    print("")
    print("┌────────────────────────────────┐")
    print("│ Icon Categories:               │")
    print("├────────────────────────────────┤")
    print("│ - actions                      │")
    print("│ - apps                         │")
    print("│ - categories                   │")
    print("│ - devices                      │")
    print("│ - emblems                      │")
    print("│ - legacy                       │")
    print("│ - mimetypes                    │")
    print("│ - places                       │")
    print("│ - status                       │")
    print("│ - wip                          │")
    print("└────────────────────────────────┘")
    print("")
    return


def build_parser():

    parser = argparse.ArgumentParser(add_help=False)

    parser.add_argument(
        '--categories',
        type=str,
        nargs='?',
        default=(
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
        ),
        help="categories of icons to render (by default all)"
    )
    parser.add_argument(
        '--base_dpi',
        type=int,
        nargs=1,
        default=96,
        help="dpi to use for rendering (by default 96)"
    )
    parser.add_argument(
        '--filter',
        type=str,
        nargs=1,
        help="Inkscape filter to apply while rendering (by default none)"
    )
    parser.add_argument(
        '--help',
        action='store_true',
        help="show this help message and exit"
    )
    parser.add_argument(
        '--inkscape_path',
        type=str,
        nargs=1,
        default = '/usr/bin/inkscape',
        help="path of Inkscape executable (if the script can't find it)"
    )
    parser.add_argument(
        '--individual_icons',
        type=str,
        nargs='?',
        help="individual icon names (without extensions) to render (by default all)"
    )
    parser.add_argument(
        '--list_categories',
        action='store_true',
        help="list categories of icons to choose from and exit"
    )
    parser.add_argument(
        '--optipng_path',
        type=str,
        nargs=1,
        default = '/usr/bin/optipng',
        help="path of OptiPNG executable (if the script can't find it)"
    )
    parser.add_argument(
        '--output_path',
        type=str,
        nargs=1,
        default = '../../Suru',
        help="output directory (by default '../../Suru')"
    )
    parser.add_argument(
        '--scaling_factors',
        type=int,
        nargs='?',
        default=[1, 2],
        help="scaling factors to render at (by default [1, 2])"
    )
    parser.add_argument(
        '--verbose',
        action='store_true',
        help="print verbose output to the terminal"
    )
    return parser


def do(args):

    if args.list_categories:
        print_categories()
        return None

    if args.help:
        print_help()
        return None

    check_dependencies(args)
    
    if args.individual_icons is None:
        print("\nNo arguments provided; processing listed sources:\n")
        for icon_category in args.categories:
            print("-- \"" + os.path.join('.', icon_category) + "\"")
        print("")
    else:
        print("┌────────────────────────────────┐")
        print("│ Rendering from command-line argument \"" + args.individual_icons + "\"")
        print("├────────────────────────────────┤")

    class Result:
        def __init__(self, args):
            self.directory = ""
            self.named = args.individual_icons

    result = Result(args)

    for source in args.categories:
        if os.path.exists(os.path.join('.', source)):
            SRC = os.path.join('.', source)
            #
            # render_category() is the main function call
            #
            if render_category(args, SRC):
                result.directory = source
        else:
            print("Source path \"" + os.path.join('.', source) + "\" does not exist.")
    if args.individual_icons is not None:
        print("└────────────────────────────────┘")

    return result


def print_result(result):

    if result is None: return

    if result.directory != "" and result.named is not None:
        print("\nSuccessfully processed \"" + result.named + "\" in \"" + result.directory + "\".\n")
    elif result.directory == "" and result.named is not None:
        print("\nFailed to process \"" + result.named + "\" in " + result.directory + ".\n")
    elif result.directory != "":
        print("Successfully processed listed sources.\n")
    elif result.directory == "":
        print("Failed to process listed sources.\n")
    else:
        raise Exception("Conditional statement falls through.")
    return


# This is the main function
print_result(do(build_parser().parse_args()))