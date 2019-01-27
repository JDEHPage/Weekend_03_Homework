require_relative("../db/sql_runner")

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO customers(
    name, funds
    ) VALUES (
      $1, $2
      ) RETURNING id;"
      values = [@name, @funds]
      @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      return customers.map {|customer| Customer.new(customer)}
    end

    def delete()
      sql = "DELETE FROM customers WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def update()
      sql = "UPDATE customers SET(
      name, funds
      ) = ($1, $2) WHERE id = $3;"
      values = [@name, @funds, @id]
      SqlRunner.run(sql, values)
    end

    def film()
      sql = "SELECT films.* FROM films
      INNER JOIN tickets ON tickets.film_id = films.id
      WHERE tickets.customer_id = $1 ORDER BY films.title;"
      values = [@id]
      film_data = SqlRunner.run(sql, values)
      return film_data.map {|film| Film.new(film)}
    end


    def buy_ticket(film)
      @funds -= film.price
      update()
    end

    def no_of_tickets()
      return film().count
    end




  end
