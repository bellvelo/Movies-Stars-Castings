require('pry-byebug')
require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')

Movie.delete_all
Star.delete_all

movie1 = Movie.new({
  "title" => "Jaws",
  "genre" => "Shark"
  })
movie1.save()

movie2 = Movie.new({
  "title" => "Gosford Park",
  "genre" => "Whodunnit"
  })
movie2.save()

star1 = Star.new ({
  "first_name" => "Richard",
  "last_name" => "Dreyfuss",
  })
star1.save()

star2 = Star.new ({
  "first_name" => "Maggie",
  "last_name" => "Smith",
  })
star2.save()

star3 = Star.new ({
  "first_name" => "Michael",
  "last_name" => "Gambon",
  })
star3.save()

casting1 = Casting.new({
  "movie_id" => movie1.id,
  "star_id" => star1.id,
  "fee" => 50
  })
casting1.save()

casting2 = Casting.new({
  "movie_id" => movie2.id,
  "star_id" => star2.id,
  "fee" => 100
  })
casting2.save()

casting3 = Casting.new({
  "movie_id" => movie2.id,
  "star_id" => star3.id,
  "fee" => 75
  })
casting3.save()


binding.pry
nil
