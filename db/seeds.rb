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
	{name: 'XnnYygn', password: 'secret', department: Department.first}
])

Report.delete_all

Report.create([
	{
		title: 'First',
		author: User.first,
		content: 'Hello, world!'
	}
])