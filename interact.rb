require './corpus'
require './doc'

CUTOFF = 0.75

if(ARGV.length != 1)
  $stderr.puts "usage: ruby find_matches.rb <xslx path>"
  exit 1
end
path = ARGV[0]
corpus = Corpus.new
corpus.read_xsl(path)

$stdin.each do |line|
  strs = line.split(/\s/)
  doc0 = corpus.docs[strs[0].to_i]
  doc1 = corpus.docs[strs[1].to_i]
  similarity = doc0.compare(doc1,corpus)
  puts "Similarity = #{'%.1f' % (similarity*100)}%"
  terms = doc0.scored_comparison_terms(doc1,corpus)
  puts "Terms:"
  terms.each do |term, score|
    if(score > 0.0000000000001)
      puts "    #{term}  ....  dot=#{score}  ... idf=#{corpus.idf(term)}"
    end
  end
end
