require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class MuseumTest < MiniTest::Test

  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
  end

  def test_it_has_a_name
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", dmns.name
  end

  def test_it_starts_with_no_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

  assert_equal [], dmns.exhibits
  end

  def test_you_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    assert_equal [gems_and_minerals, dead_sea_scrolls, imax], dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    imax = Exhibit.new("IMAX", 15)
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")

    assert_equal [gems_and_minerals, dead_sea_scrolls], dmns.recommend_exhibits(bob)
    assert_equal [imax], dmns.recommend_exhibits(sally)
    end

    def test_it_starts_with_no_patrons
        dmns = Museum.new("Denver Museum of Nature and Science")
        gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
        dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
        imax = Exhibit.new("IMAX", 15)
        dmns.add_exhibit(gems_and_minerals)
        dmns.add_exhibit(dead_sea_scrolls)
        dmns.add_exhibit(imax)

        assert_equal [], dmns.patrons
      end

    def test_it_can_admit_patrons
        dmns = Museum.new("Denver Museum of Nature and Science")
        gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
        dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
        imax = Exhibit.new("IMAX", 15)
        dmns.add_exhibit(gems_and_minerals)
        dmns.add_exhibit(dead_sea_scrolls)
        dmns.add_exhibit(imax)
        dmns.patrons
        bob = Patron.new("Bob", 20)
        bob.add_interest("Dead Sea Scrolls")
        bob.add_interest("Gems and Minerals")
        sally = Patron.new("Sally", 20)
        sally.add_interest("Dead Sea Scrolls")

        dmns.admit(bob)
        dmns.admit(sally)

        assert_equal [bob, sally], dmns.patrons
      end

    def test_it_can_select_patrons_by_exhibit_interest

      dmns = Museum.new("Denver Museum of Nature and Science")
      gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
      dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
      imax = Exhibit.new("IMAX", 15)
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      dmns.patrons
      bob = Patron.new("Bob", 20)
      bob.add_interest("Dead Sea Scrolls")
      bob.add_interest("Gems and Minerals")
      sally = Patron.new("Sally", 20)
      sally.add_interest("Dead Sea Scrolls")
      dmns.admit(bob)
      dmns.admit(sally)
      dmns.patrons


      expected_hash = {gems_and_minerals => [bob], dead_sea_scrolls => [bob, sally], imax => []}
      assert_equal expected_hash, dmns.patrons_by_exhibit_interest
    end

    def test_patrons_of_exhibits
      dmns = Museum.new("Denver Museum of Nature and Science")
      gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
      imax = Exhibit.new("IMAX", 15)
      dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(imax)
      dmns.add_exhibit(dead_sea_scrolls)

      tj = Patron.new("TJ", 7)
      tj.add_interest("IMAX")
      tj.add_interest("Dead Sea Scrolls")
      dmns.admit(tj)

      assert_equal 7, tj.spending_money

      bob = Patron.new("Bob", 10)
      bob.add_interest("Dead Sea Scrolls")
      bob.add_interest("IMAX")
      dmns.admit(bob)

      assert_equal 0, bob.spending_money

      sally = Patron.new("Sally", 20)
      sally.add_interest("IMAX")
      sally.add_interest("Dead Sea Scrolls")
      dmns.admit(sally)

      assert_equal 5, sally.spending_money

      morgan = Patron.new("Morgan", 15)
      morgan.add_interest("Gems and Minerals")
      morgan.add_interest("Dead Sea Scrolls")
      dmns.admit(morgan)
      # binding.pry

      assert_equal 5, morgan.spending_money

      expected_hash = {dead_sea_scrolls => [bob, morgan], imax => [sally], gems_and_minerals => [morgan] }

      assert_equal expected_hash, dmns.patrons_of_exhibits
    end




end
