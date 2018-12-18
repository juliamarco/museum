class Museum
  attr_reader :name,
              :exhibits,
              :patrons,
              :exhibits_attended_by_patron

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
    @exhibits_attended_by_patron = {}
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommended = []
    @exhibits.each do |exhibit|
      patron.interests.each do |interest|
        if interest == exhibit.name
          recommended << exhibit
        end
      end
    end
    return recommended
  end

  def attend_exhibit(patron)
    sorted_exhibits = recommend_exhibits(patron).sort_by do |exhibit|
      exhibit.cost
    end
    sorted_exhibits.reverse.each do |exhibit|
      if exhibit.cost <= patron.spending_money
        @exhibits_attended_by_patron
        @exhibits_attended_by_patron[patron] = exhibit
        patron.spending_money -= exhibit.cost
        @revenue += exhibit.cost
      end
    end
  end


  def admit(patron)
    @patrons << patron
    attend_exhibit(patron)
  end

  def patrons_by_exhibit_interest
    hash = {}
    @patrons.each do |patron|
      recommend_exhibits(patron).each do |exhibit|
        if hash.has_key?(exhibit)
          hash[exhibit].push(patron)
        else
        hash[exhibit] = [patron]
        end
      end
    end
    @exhibits.each do |exhibit|
      if hash.has_key?(exhibit)
      else
        hash[exhibit] = []
      end
    end
    return hash
  end

  def patrons_of_exhibits
    @exhibits_attended_by_patron.invert
  end


end
