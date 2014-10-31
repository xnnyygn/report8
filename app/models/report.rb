class Report < ActiveRecord::Base
	validates :title, :content, presence: true
	
  belongs_to :author, class_name: 'User'
  has_many :sentences #TODO order problem

  before_save :save_sentences

  private

  	def save_sentences
  		split_text(content).each do |sentence|
  			sentences.build(line: sentence)
  		end
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