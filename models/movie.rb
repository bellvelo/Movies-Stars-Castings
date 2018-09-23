require_relative('../db/sql_runner')

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @budget = options["budget"].to_i
  end

  def save()
    sql = "
    INSERT INTO movies (title, genre, budget)
    VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie["id"].to_i
  end

  def stars()
    sql ="
    SELECT stars.*
    FROM stars INNER JOIN castings
    ON castings.star_id = stars.id
    WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map {|star_data| Star.new(star_data)}
  end

  def castings()
    sql = "SELECT * FROM castings WHERE movie_id = $1"
    values = [@id]
    casting_data = SqlRunner.run(sql, values)
    return casting_data.map{|casting| Casting.new(casting)}
  end

  def remaining_budget()
    fees = self.castings()
    casting_fees = fees.map{|casting| casting.fee}
    combined_fees = casting_fees.sum
    return @budget - combined_fees
  end

  ## can be refactored to this single method ##

  def budget_balance
    # this section pulls the desired data from the db and converts it from a postgres object to a class object
    sql = "SELECT * FROM castings WHERE movie_id = $1"
    values = [@id]
    casting_fees = SqlRunner.run(sql, values)
    fees = casting_fees.map{|casting| Casting.new(casting)}
    # this section extracts the fee info from the class object array, then does the math operations
    casting_data = fees.map{|cast| cast.fee.to_i}
    combined_fees = casting_data.sum
    return @budget - combined_fees
  end

  def self.delete_all
    sql ="DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end




#this is the end
end
