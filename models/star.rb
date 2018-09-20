require_relative('../db/sql_runner')


class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def save()
    sql ="
    INSERT INTO stars (first_name, last_name)
    VALUES ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star["id"].to_i
  end

  def movies
    sql ="
    SELECT movies.*
    FROM movies INNER JOIN castings
    ON movie_id = movies.id
    WHERE star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map {|movies_data| Movie.new(movies_data)}
  end


  def self.delete_all
    sql ="DELETE FROM stars"
    values = []
    SqlRunner.run(sql, values)
  end



  #this is the end
end
