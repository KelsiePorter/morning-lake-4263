require 'rails_helper'

RSpec.describe 'projects show page', type: :feature do 
  before :each do
    @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
    @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

    @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
    @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
  end
  it 'displays the specific projects name and material' do
    visit "/projects/#{@news_chic.id}"

    expect(page).to have_content("News Chic")
    expect(page).to have_content("Newspaper")
    expect(page).to_not have_content("Boardfit")

    visit "/projects/#{@boardfit.id}"

    expect(page).to have_content("Boardfit")
    expect(page).to have_content("Newspaper")
    expect(page).to_not have_content("Boardfit")
  end

  it 'displays the theme of the challenge that the project belongs to' do
    visit "/projects/#{@news_chic.id}"
    save_and_open_page
    expect(page).to have_content("Recycled Material")
  end
end