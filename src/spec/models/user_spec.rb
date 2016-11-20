require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user1 = User.new(email:"test@exp.com", password:"test")
    @user1.save(:validate=>false)
    @user2 = User.new(email:"test1@exp.com", password:"test")
    @user2.save(:validate=>false)
  end
  describe 'Test remove friendship' do
    it "can remove friendship" do
      @friendship = Friendship.new(user_id:@user1.id, friend_id: @user2.id)
      expect(@friendship.save).to be_truthly
      @user.unfriend(@user2.id)
      expect(@user.friends).to eq []
    end
  end

end
