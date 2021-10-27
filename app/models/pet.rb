class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_pets(params)
    if params[:pet] != nil
      @found_pets = Pet.search(params[:pet])
    end
    # require 'pry'; binding.pry
  end
end
