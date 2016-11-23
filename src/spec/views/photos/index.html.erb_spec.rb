require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      Photo.create!(
        :content => "MyText",
        :link => "Link",
        :avatar => "Avatar",
        :user_id => 2,
        :question_id => 3,
        :experience_id => 4
      ),
      Photo.create!(
        :content => "MyText",
        :link => "Link",
        :avatar => "Avatar",
        :user_id => 2,
        :question_id => 3,
        :experience_id => 4
      )
    ])
  end

  it "renders a list of photos" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
