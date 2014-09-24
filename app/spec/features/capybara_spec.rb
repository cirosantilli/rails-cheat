require 'spec_helper'

describe Controller0Controller, type: :feature do
  it 'has capybara methods' do
    visit '/rspec'
    expect(page).to have_content('rspec')
  end
end
