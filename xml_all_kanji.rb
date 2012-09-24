require "kvg2sexp.rb"

i = 0

f = File.new(ARGV[0], "w")

f.write("<?xml version=\"1.0\" standalone=\"no\"?>
<dictionary name=\"Tomoe Handwriting Dictionary\">\n")

IO.read("kanjisstrokes.txt").each do |line|
  if ! line["#"]
    c = SVG_Character.new(line)
    f.write(c.to_xml)
    i += 1    
  end  
end

f.write("/<dictionary>")
f.close
