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
    #{__FILE__} only image1 image2

DOCOPT

# INKSCAPE = 'flatpak run org.inkscape.Inkscape'
INKSCAPE = '/usr/bin/inkscape'
SRCS = ["./source-symbolic.svg"]
PREFIX = "../../Suru/scalable"

# install with `sudo npm install -g svgo`
SVGO = '/usr/local/bin/svgo'

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
    options = Docopt::docopt(doc)

    svg = Document.new(File.new(SRC, 'r'))

    if options["all"]
        puts "Rendering from icons in #{SRC}"
        # Go through every layer.
        svg.root.each_element("/svg/g[@inkscape:groupmode='layer']") do |context|
            context_name = context.attributes.get_attribute("inkscape:label").value
            puts "Going through layer '" + context_name + "'"
            context.each_element("g") do |icon|
                #puts "DEBUG #{icon.attributes.get_attribute('id')}"
                dir = "#{PREFIX}/#{context_name}"
                icon_name = icon.attributes.get_attribute("inkscape:label").value
                if icon_name.end_with?("-alt")
                    puts " >> skipping icon '" + icon_name + "'"
                else
                    puts "chopSVG: name:#{icon_name}, id:#{icon.attributes.get_attribute("id")}, dir:#{dir}, file:#{get_canonical_filename(dir, icon_name)}"
                    #chopSVG({ :name => icon_name,
                    #:id => icon.attributes.get_attribute("id"),
                    #:dir => dir,
                    #:file => get_canonical_filename(dir, icon_name)})
                end
            end
        end
        puts "\nrendered all SVGs"
    end

    if options["only"] == true
        options["<icon>"].each do |icon_name|
            icon = svg.root.elements["//g[@inkscape:label='#{icon_name}']"]
            dir = "#{PREFIX}/#{icon.parent.attributes['inkscape:label']}"

            puts "chopSVG: name:#{icon_name}, id:#{icon.attributes["id"]}, dir:#{dir}, file:#{get_canonical_filename(dir, icon_name)}"
            #chopSVG({ :name => icon_name,
            #:id => icon.attributes["id"],
            #:dir => dir,
            #:file => get_canonical_filename(dir, icon_name),
            #:forcerender => true})
        end
        puts "\nrendered #{ARGV.length} icons"
    end
rescue Docopt::Exit => e
    puts e.message
end
