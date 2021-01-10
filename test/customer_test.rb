require 'minitest/autorun'
require '../src/customer'
require '../src/movie'
require '../src/rental'

class CustomerTest < Minitest::Test
  def test_sample
    assert_equal 'RUBY', 'ruby'.upcase
  end

  # REGULARかつ遅延なし
  def test_regular_movie_statement
    regular_movie = Movie.new('regular_movie', Movie::REGULAR)
    regular_movie_rental = Rental.new(regular_movie, 1)
    customer = Customer.new('user_name')
    customer.add_rental(regular_movie_rental)
    assert_equal "Rental Record for user_name\n\tregular_movie\t2\nAmount owed is 2\nYou earned 1 frequent renter points", customer.statement
  end

  # REGULARかつ遅延あり
  def test_regular_movie_with_delay_statement
    regular_movie = Movie.new('regular_movie', Movie::REGULAR)
    regular_movie_rental = Rental.new(regular_movie, 3)
    customer = Customer.new('user_name')
    customer.add_rental(regular_movie_rental)
    assert_equal "Rental Record for user_name\n\tregular_movie\t3.5\nAmount owed is 3.5\nYou earned 1 frequent renter points", customer.statement
  end



end
