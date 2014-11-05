class Report < ActiveRecord::Base
	validates :title, :content, presence: true
	
  belongs_to :author, class_name: 'User'
  has_many :sentences
  has_many :correction_logs

  def generate_sentences
  	split_text(content).each do |sentence|
  		sentences.build(line: sentence)
  	end
  end

  def pv
    $redis.get(pv_key) || 0
  rescue
    0
  end

  def increase_pv
    $redis.incr(pv_key)
  rescue
  end

  private

    def pv_key
      "report8::report::#{id}.pv"
    end

  	DELIMITERS = Set.new(%w{。 ! . ?})

	  def split_text(text)
	    sentences = []
	    sentence = ''
	    text.chars do |c|
	      if c == ?\n or c == ?\r
	        sentence << ' '
	      elsif DELIMITERS.include? c
	        sentence << c
	        sentences << sentence.strip
	        sentence = ''
	      else
	        sentence << c
	      end
	    end
	    sentence.strip!
	    sentences << sentence unless sentence.empty?
	    sentences
	  end

end