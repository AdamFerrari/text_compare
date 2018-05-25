require './corpus'
require './doc'

CUTOFF = 0.75

if(ARGV.length != 1)
  $stderr.puts "usage: ruby find_matches.rb <file path>"
  exit 1
end
path = ARGV[0]
corpus = Corpus.new(path)
corpus.docs.each do |doc|

  corpus.docs.each do |compare_doc|
    if compare_doc.id > doc.id
      similarity = doc.compare(compare_doc, corpus)
      if(similarity > CUTOFF)
        puts '----------------------------------------'
        puts "Found match, similarity = #{'%.1f' % (similarity*100)}%"
        puts "Doc #{doc.id}"
        puts doc.raw
        puts "\nDoc #{compare_doc.id}"
        puts compare_doc.raw
        puts"\n\n"
      end
    end
  end
end
