# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Department.delete_all

Department.create([
	{name: 'Department001'},
	{name: 'Department002'}
])

User.delete_all

User.create([
	{name: 'XnnYygn', password: 'secret', department: Department.first},
	{name: 'admin', password: 'secret', department: Department.second}
])

Report.delete_all
Sentence.delete_all
Correction.delete_all
CorrectionLog.delete_all

Report.create([
	{
		title: 'First',
		language: 'en',
		author: User.first,
		content: 'Hello, world!'
	},
	{
		title: '日曜日のゲーム',
		language: 'jp',
		author: User.first,
		content: 'たぶん私が勉強と休憩を両立できない人だ。
昨日の日曜日また一日中ゲームを遊んでしまった。
いつもこれをコントロールしようと思っているが、なか なかできなかった。
勉強の時間が長くなると、ドラマを見たり、ゲーム遊んだりしてほしい。
でも、ほんとに遊びに行ったら、時間やご飯を忘れて、やめようで もできなかった。
やっぱりふだんに自分に圧力しすぎたっただろうか。もっと優しいリラックス方法を探すべきたったかな。'
	}
])

Report.all.each  do |r| 
	r.generate_sentences
	r.save
end