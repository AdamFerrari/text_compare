require 'csv'
require './doc'

class Corpus
  attr_reader(:docs, :doc_count)

  # Assume corpus comes as a single-column csv, with a raw document per row.
  # Using csv instead of raw lines allows for multi-line documents.
  #
  def initialize(path)
    @doc_count = 0
    @docs = []
    CSV.foreach(path) do |row|
      doc = Doc.new(@doc_count, row[0])
      @docs << doc
      accumulate(doc)
    end
  end

  def term_counts
    @term_counts ||= Hash.new
  end

  def vocab
    @vocab ||= Set.new
  end

  def idf(term)
    Math.log(doc_count.to_f / (term_counts[term] + 1).to_f)
  end

  private

  def accumulate(doc)
    @doc_count = @doc_count + 1
    doc.vocab.each do |term|
      term_counts[term] = (term_counts[term] || 0) + 1
      vocab << term
    end
  end

end