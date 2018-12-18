class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
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

  def admit(patron)
    @patrons << patron
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

end
