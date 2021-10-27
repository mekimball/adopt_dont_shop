require 'rails_helper'

RSpec.describe 'the application create' do
  it 'can create a new application' do

    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '90210'

    click_button "Submit"
    
    expect(page).to have_content('Jimbo Jones')
    expect(page).to have_content('123 Fake St Denver CO 90210')
    expect(page).to have_content('In Progress')
  end

  it 'returns an error if application is not complete' do
    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'

    click_button "Submit"
    
    expect(page).to have_content("Error: Zip code can't be blank")
  end

  describe 'applications submission' do
    it 'allows me to submit an application if I have pets' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')
      PetApplication.create!(pet: pet_1, application: application)

      visit "/applications/#{application.id}"
      fill_in :good_reason, with: "Becuz I R good"
      click_button "Submit Application"

      expect(page).to have_content("Pending")
      expect(page).to_not have_content("In Progress")
      expect(page).to_not have_content("Add a pet to this application")
    end
    
    it "doesn't allow me to submit an application with no pets" do
      application = Application.create!(name: 'Jim Jimmerson', street: '123 Fake St', city: 'Denver', state: 'CO', zip_code: '90210')
      visit "/applications/#{application.id}"
      save_and_open_page
      expect(page).to_not have_content("Submit Application")
    end
  end
end
# No Pets on an Application

# As a visitor
# When I visit an application's show page
# And I have not added any pets to the application
# Then I do not see a section to submit my application