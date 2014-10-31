module ApplicationHelper

	def language(abbr)
		LANGUAGES.each do |xs|
			if xs[1] == abbr
				return xs[0]
			end
		end
		nil
	end

	# TODO remove
	def sentences(text)
		sentences = []
		sentence = ''
		text.chars do |c|
			if c == ?\n or c == ?\r
				sentence << ' '
			elsif c == '。'
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
