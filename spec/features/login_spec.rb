require 'rails_helper'

describe "the signin process", type: :feature, js: true do
  let!(:user) { create(:user, { first_name: "Michael", last_name: "Scott", password: "password123" }) }
  before do
    5.times { create(:user, manager: user )}
  end
  

  it "signs me in" do

    visit '/'
    fill_in 'username', with: 'm.scott'
    fill_in 'password', with: 'password123'
    click_button 'log in'
    expect(page).to have_content user.direct_reports.first.username
  end
end