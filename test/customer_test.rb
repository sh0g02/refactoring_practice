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

  # NEW_RELEASE
  def test_new_release_movie_statement
    movie = Movie.new('new_release_movie', Movie::NEW_RELEASE)
    rental = Rental.new(movie, 1)
    customer = Customer.new('user_name')
    customer.add_rental(rental)
    assert_equal "Rental Record for user_name\n\tnew_release_movie\t3\nAmount owed is 3\nYou earned 1 frequent renter points", customer.statement
  end

  # NEW_RELEASEかつボーナスあり
  def test_new_release_movie_with_2_days_statement
    movie = Movie.new('new_release_movie', Movie::NEW_RELEASE)
    rental = Rental.new(movie, 2)
    customer = Customer.new('user_name')
    customer.add_rental(rental)
    assert_equal "Rental Record for user_name\n\tnew_release_movie\t6\nAmount owed is 6\nYou earned 2 frequent renter points", customer.statement
  end

  # CHILDREN
  def test_children_movie_statement
    movie = Movie.new('children_movie', Movie::CHILDREN)
    rental = Rental.new(movie, 3)
    customer = Customer.new('user_name')
    customer.add_rental(rental)
    assert_equal "Rental Record for user_name\n\tchildren_movie\t1.5\nAmount owed is 1.5\nYou earned 1 frequent renter points", customer.statement
  end

  # CHILDREN with delay
  def test_children_movie_with_delay_statement
    movie = Movie.new('children_movie', Movie::CHILDREN)
    rental = Rental.new(movie, 4)
    customer = Customer.new('user_name')
    customer.add_rental(rental)
    assert_equal "Rental Record for user_name\n\tchildren_movie\t3.0\nAmount owed is 3.0\nYou earned 1 frequent renter points", customer.statement
  end
end
