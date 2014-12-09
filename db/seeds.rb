# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')



Meetup.create(title: "Kickin\' ASS and takin\' names", description: "Discuss kicking ass and taking names for as long as possible, cause it's awesome.", location: "Boston Kickass Club", url:"/1" )

Meetup.create(title: "Making money", description: "Let's talk about how rich we could be.", location: "Somerville Theater", url:"/2" )

Meetup.create(title: "Being awesome", description: "How can we be awesome and do awesome things", location: "Boston Kickass Club", url:"/3" )








# t.string :title, null: false
# t.text :description, null: false
# t.string :location, null: false
# t.string :url, null: false
# t.integer :users
