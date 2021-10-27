require 'rails_helper'

RSpec.describe 'the application show' do
  describe 'application info' do
    it 'can list application information' do
      shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake st', city: 'Denver', state: 'CO', zip_code: '90210')
      pet1 = application.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet2 = application.pets.create!(name: 'Mia', age: 3, breed: 'cat', adoptable: true, shelter_id: shelter.id)
      visit "/applications/#{application.id}"
      
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
    end
  end

    describe 'pet search' do
    it 'can search for a pet' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
      pet_2 = shelter.pets.create!(adoptable: true, age: 7, breed: 'tiger', name: 'Fluffy 2')
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a pet to this application:")

      fill_in 'pet', with: 'Fluffy'
      click_button 'Submit'

      expect(page).to have_content('Fluffy')
      expect(page).to have_content('Fluffy 2')
    end
  end

  describe 'add pet' do
    it 'can add a pet to this application' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')

      visit "/applications/#{application.id}"

      fill_in 'pet', with: 'fluff'
      click_button 'Submit'

      click_button("Adopt this Pet")

      expect(page).to have_content('Fluffy')
    end
  end
end
