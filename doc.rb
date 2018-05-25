require './toks'
require 'matrix'

class Doc
  attr_reader(:raw,:toks,:id)

  def initialize(doc_id, raw_text)
    @id = doc_id
    @raw = raw_text
    @toks = Toks.tokenize(raw_text)
  end

  def compare(other_doc, corpus)
    cosine_similarity(other_doc, corpus)
  end

  def vocab
    @vocab ||= Set.new(toks)
  end

  def raw_tfs(corpus)
    tfs = Hash.new
    corpus.vocab.each { |tok| tfs[tok] = 0 }
    toks.each { |tok| tfs[tok] = tfs[tok] + 1 }
    tfs
  end

  def vectorize_simple(corpus)
    counts = raw_tfs(corpus)
    Vector.elements(counts.values)
  end

  def vectorize_tfidf(corpus)
    counts = raw_tfs(corpus)
    tfidfs = []
    doc_len = toks.length
    counts.keys.each do |term|
      raw_tf = counts[term]
      tfidf = (raw_tf>0) ? (raw_tf.to_f / doc_len.to_f) / corpus.idf(term) : 0
      tfidfs << tfidf
    end
    Vector.elements(tfidfs)
  end

  def vectorize(corpus)
    vectorize_tfidf(corpus)
  end

  def cosine_similarity(other_doc, corpus)
      self_vec = vectorize(corpus)
      other_vec = other_doc.vectorize(corpus)
      self_vec.dot(other_vec) / (self_vec.magnitude * other_vec.magnitude)
  end

end