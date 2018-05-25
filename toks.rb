require 'set'

class Toks

  def self.tokenize(str)
    # Small-brained "hulk smash" type tokenizer.
    # Strip all non-letter characters, downcase, and split on spaces.
    # this kills contractions, but most of their bases are stopwords anyway.
    # Filter out stopwords and single-letter terms.
    str.gsub(/[^a-zA-Z]/,' ').downcase.split(/[[:space:]]+/).reject {|word| stopword?(word)}
  end

  def self.stopword?(word)
    self.stopwords.include?(word) || word.length < 2
  end

  def self.stopwords
    @@sw ||= Set.new([
        'a', 'about', 'above', 'after', 'again', 'against', 'all',
        'am', 'an', 'and', 'any', 'are', 'as', 'at', 'be', 'because',
        'been', 'before', 'being', 'below', 'between', 'both',
        'but', 'by', 'cannot', 'can', 'could', 'did', 'do', 'does',
        'doing', 'down', 'during', 'each', 'few', 'for', 'from',
        'further', 'had', 'has', 'have', 'having', 'he', 'her', 'here',
        'hers', 'herself', 'hes', 'him', 'himself', 'his', 'how', 'hows',
        'i', 'if', 'in', 'into', 'is', 'it', 'its', 'itself', 'me',
        'more', 'most', 'my', 'myself', 'no', 'nor', 'not', 'of', 'off',
        'on', 'once', 'only', 'or', 'other', 'ought', 'our', 'out',
        'over', 'own', 'same', 'she', 'should', 'so', 'some', 'such',
        'than', 'that', 'the', 'their', 'theirs', 'them', 'themselves',
        'then', 'there', 'these', 'they', 'this', 'those', 'through',
        'to', 'too', 'under', 'until', 'up', 'very', 'was', 'we',
        'well', 'were', 'what', 'when', 'where',  'which', 'while',
        'who', 'whom', 'why', 'will', 'with', 'would', 'you', 'your',
        'yours', 'yourself', 'yourselves', ])
  end
end
