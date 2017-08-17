require_relative "kvg2sexp.rb"
require "nokogiri"

#if ENV['SOURCE']
  file = File.open(ARGV[0]) { |f| Nokogiri::XML(f) }

  #create directory csv
  #Dir.mkdir("xml") unless File.directory?("xml")

  f = File.new(ARGV[1], "w")

  f.write("<?xml version=\"1.0\" standalone=\"no\"?>
  <dictionary name=\"Tomoe Handwriting Dictionary\">\n")

  file.xpath("//kanji").each do |kanji|
    #id has format: "kvg:kanji_CODEPOINT-Kaisho"
    #codepoint is a hex number
    codepoint = ("0x" + kanji.attributes["id"].value.split("_")[1].split("-")[0]).hex
    strokes = kanji.xpath("g//path").map{|p| p.attributes["d"].value }
    c = SVG_Character.new(codepoint, strokes)
    #f = File.new("xml/" + codepoint.to_s + ".xml", "w")
    f.write(c.to_xml)
  end

  f.write("</dictionary>")
  f.close
#else
#  puts "Usage: SOURCE=kanjivg-20130901.xml ruby xml_all_kanji.rb"
#end
