require_relative("../db/sql_runner")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO films(
    title, price
    ) VALUES (
      $1, $2
      ) RETURNING id;"
      values = [@title, @price]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM films"
      films = SqlRunner.run(sql)
      return films.map {|film| Film.new(film)}
    end

    def delete()
      sql = "DELETE FROM films WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def update()
      sql = "UPDATE films SET (
      title, price
      ) = ($1, $2) WHERE id = $3;"
      values = [@title, @price, @id]
      SqlRunner.run(sql, values)
    end

    def customer()
      sql = "SELECT customers.* FROM customers
      INNER JOIN tickets ON customer_id = customers.id
      WHERE film_id = $1 ORDER BY customers.name"
      values = [@id]
      customer_data = SqlRunner.run(sql, values)
      return customer_data.map {|customer| Customer.new(customer)}
    end

    def no_of_viewers()
      return customer().count
    end

    # def popular_time()
    #   sql = "SELECT screenings.* FROM screenings
    #   INNER JOIN tickets ON customer_id = customers.id
    #   WHERE film_id = $1 ORDER BY customers.name"
    #   values = [@id]
    #   customer_data = SqlRunner.run(sql, values)
    #   return customer_data.map {|customer| Customer.new(customer)}
    # end


    # sql = "SELECT customers.* FROM customers
    # INNER JOIN tickets ON customer_id = customers.id
    # WHERE film_id = $1 ORDER BY customers.name"



    def popular_time()
      # sql = "SELECT screenings.* FROM screenings WHERE"


      sql = "SELECT screenings.* FROM screenings
      INNER JOIN tickets ON tickets.screening_id = screenings.id
      WHERE tickets.film_id = $1"
      values = [@id]
      screenings = SqlRunner.run(sql, values).map {|screening| screening["show_time"]}

      # binding.pry
      
      # array = screenings.map {|screening| Screening.new(screening)}
      # times = array.map {|time| time.show_time}
      # return times
      freq = screenings.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      return screenings.max_by { |v| freq[v] }
    end

# find_duplicates


  end
