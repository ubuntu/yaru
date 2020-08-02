#!/usr/bin/env ruby
#
# Legal Stuff:
#
# This file is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; version 3.
#
# This file is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/lgpl-3.0.txt>
#
#
# Thanks to the GNOME icon developers for the original version of this script


require "open3"
require "docopt"
require "rexml/document"
require "fileutils"
include REXML

doc = <<DOCOPT
Usage:
    #{__FILE__} [force] all
    #{__FILE__} [force] only <icon>...

Options:
    all     extract all icon in the SVG file
    only    extract only the list of given icon names
    force   force extraction of already existing icon [optional]

Examples:
    #{__FILE__} only image1 image2  # render only image1 and image2 if not already rendered
    #{__FILE__} force only image3   # render only image3 even if already rendered
    #{__FILE__} all                 # render all images, if not already rendered
    #{__FILE__} force all           # render all images even if already rendered

DOCOPT

# INKSCAPE = 'flatpak run org.inkscape.Inkscape'
INKSCAPE = 'inkscape'
SRCS = ["./source-symbolic.svg"]
PREFIX = "../../Suru/scalable"

# install with `sudo npm install -g svgo`
SVGO = 'svgo'


def check_deps(dependencies)
    dependencies.each do |dependency|
        begin
            stdout, stderr, status = Open3.capture3("which", dependency)
            if not status.success?
                puts "could not find \"#{dependency}\". See README for needed dependencies"
                exit 1
            end
        rescue
            puts "rescue"
            exit 1
        end
    end
end

def chopSVG(svg_file_name, icon)
	FileUtils.mkdir_p(icon[:dir]) unless File.exists?(icon[:dir])
	unless (File.exists?(icon[:file]) && !icon[:forcerender])
		FileUtils.cp(svg_file_name, icon[:file])

		puts " >> #{icon[:name]}"
		cmd = "#{INKSCAPE} -f #{icon[:file]} --select #{icon[:id]} --verb=FitCanvasToSelection  --verb=EditInvertInAllLayers "
		cmd += "--verb=EditDelete --verb=EditSelectAll --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=SelectionUnGroup --verb=StrokeToPath --verb=FileVacuum "
		cmd += "--verb=FileSave --verb=FileQuit > /dev/null 2>&1"
		system(cmd)

		#saving as plain SVG gets rid of the classes :/
		cmd = "#{INKSCAPE} --vacuum-defs -z #{icon[:file]} --export-plain-svg=#{icon[:file]} > /dev/null 2>&1"
		system(cmd)

		#completely vaccuum with svgo
		cmd = "#{SVGO} --pretty --disable=convertShapeToPath -i  #{icon[:file]} -o  #{icon[:file]} > /dev/null 2>&1"
		system(cmd)

		# crop
		svgcrop = Document.new(File.new(icon[:file], 'r'))
		svgcrop.root.each_element("//rect") do |rect|
			w = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #get rid of 16 vs 15.99999
			h = ((rect.attributes["width"].to_f * 10).round / 10.0).to_i #Inkscape bugs
			if w == 16 && h == 16
				rect.remove
			end
		end
		icon_f = File.new(icon[:file],'w+')
		icon_f.puts svgcrop
		icon_f.close
	else
		puts " -- #{icon[:name]} already exists"
	end
end #end of function


# Remove the "-rtl" substring from icon_name if exists
# SVG file does not have "-rtl" substring even if the
# icon name has it.
# +directory+:: directory containing the SVG file
# +icon_name+:: icon name
def get_canonical_filename(directory, icon_name)
	if (/rtl$/.match(icon_name))
		outfile = "#{directory}/#{icon_name.chomp('-rtl')}-symbolic-rtl.svg"
	else
		outfile = "#{directory}/#{icon_name}-symbolic.svg"
	end
	return outfile
end


begin
    check_deps([INKSCAPE, SVGO])

    options = Docopt::docopt(doc)

    # Get all the icons from the SVG files
    icons = []
    SRCS.each do |src|
        puts "Getting icons from #{src}"
        svg = Document.new(File.new(src, 'r'))

        # Go through every layer.
        svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context|
            context_name = context.attributes.get_attribute("inkscape:label").value

            context.each_element("g") do |icon|
                #puts "DEBUG #{icon.attributes.get_attribute('id')}"
                icon_name = icon.attributes.get_attribute("inkscape:label").value
                dir = "#{PREFIX}/#{context_name}"

                icons << { :src => src,
                           :name => icon_name,
                           :id => icon.attributes.get_attribute("id").value,
                           :dir => dir,
                           :file => get_canonical_filename(dir, icon_name),
                           :skip => icon_name.end_with?("-alt"),
                           :forcerender => options["force"]}
            end
        end
    end

    icons.each do |icon|
        if options["only"] and !options["<icon>"].include? icon[:name]
            icon[:skip] = true
        end

        if !icon[:skip]
            #puts "chopping #{icon}"
            chopSVG(icon[:src], icon)
        end
    end
rescue Docopt::Exit => e
    puts e.message
end
