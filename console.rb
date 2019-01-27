require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require('pry')


Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({ 'name' => 'John', 'funds' => 150})
customer2 = Customer.new({ 'name' => 'Craig', 'funds' => 400})
customer3 = Customer.new({ 'name' => 'Kyle', 'funds' => 120})
customer1.save
customer2.save
customer3.save




film1 = Film.new({ 'title' => 'Dune' ,'price' => 20})
film2 = Film.new({ 'title' => 'Battle Tech' ,'price' => 18})
film3 = Film.new({ 'title' => 'The Grinch' ,'price' => 15})
film1.save
film2.save
film3.save


screening1 = Screening.new({ 'show_time' => '17:00', 'film_id' => film1.id})
screening2 = Screening.new({ 'show_time' => '19:00', 'film_id' => film1.id})
screening3 = Screening.new({ 'show_time' => '21:00', 'film_id' => film1.id})

screening4 = Screening.new({ 'show_time' => '18:00', 'film_id' => film2.id})
screening5 = Screening.new({ 'show_time' => '20:00', 'film_id' => film2.id})
screening6 = Screening.new({ 'show_time' => '22:00', 'film_id' => film2.id})

screening7 = Screening.new({ 'show_time' => '15:00', 'film_id' => film3.id})
screening8 = Screening.new({ 'show_time' => '17:00', 'film_id' => film3.id})
screening9 = Screening.new({ 'show_time' => '18:00', 'film_id' => film3.id})

screening1.save
screening2.save
screening3.save
screening4.save
screening5.save
screening6.save
screening7.save
screening8.save
screening9.save


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening2.id })
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening5.id })
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id, 'screening_id' => screening8.id })
ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id, 'screening_id' => screening5.id })
ticket5 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening6.id })
ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

film2.popular_time

binding.pry
nil
