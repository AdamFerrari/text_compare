require 'matrix'
require './toks'

class CosineSimilarity

  def self.compare(ref, comp)
    tokenizer = Toks.new

    ref_toks = tokenizer.tokenize(ref)
    comp_toks = tokenizer.tokenize(comp)

    vocab = (ref_toks + comp_toks).uniq

    a = self.vectorize(vocab, ref_toks)
    b = self.vectorize(vocab, comp_toks)

    # cosine_similarity
    a.dot(b)/(a.magnitude * b.magnitude)
  end

  def self.vectorize(vocab, toks)
    counts = Hash.new(0)
    vocab.each { |tok| counts[tok] = 0 }
    toks.each { |tok| counts[tok] = counts[tok] + 1 }
    Vector.elements(counts.values)
  end

end
