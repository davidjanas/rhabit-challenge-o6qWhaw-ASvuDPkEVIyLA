require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new }

  describe 'validations' do
    it "is valid with valid attributes" do
      user.first_name = "Michael"
      user.last_name = "Scott"
      user.title = "Manager"
      user.password = "password123"
  
      expect(user).to be_valid
    end
  end

  describe "#name" do
  it "returns the user's full name" do
      u = create(:user, first_name: "Michael", last_name: "Scott")
      
      expect(u.name).to eq("Michael Scott")
    end
  end



  describe "user creation" do
    it "sets the username to first_initial.last_name" do
      u = User.create!(first_name: 'Michael', last_name: "Scott", title: "Manager", password: "password123")
      expect(u.username).to eq("m.scott")
    end

    it 'does not save passwords to the database' do
      User.create!(first_name: 'Michael', last_name: "Scott", title: "Manager", password: "password123")
      user = User.find_by_username('m.scott')
      expect(user.password).not_to be('abcdef')
    end

    it 'encrypts the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: 'jack_bruce', password: 'abcdef')
    end
  end

  it { should validate_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:password_digest) }
  it { should have_many(:direct_reports).class_name(:User) }
  it { should belong_to(:manager).optional.class_name(:User) }

end
