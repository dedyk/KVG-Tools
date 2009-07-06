require "kvg2sexp.rb"


IO.read("kanjisstrokes.txt").each do |line|
  if ! line["#"]
    c = SVG_Character.new(line)
    print c.to_sexp + "\n"
  end  
end
