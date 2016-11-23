require 'rails_helper'

RSpec.describe "photos/edit", type: :view do
  before(:each) do
    @photo = assign(:photo, Photo.create!(
      :content => "MyText",
      :link => "MyString",
      :avatar => "MyString",
      :user_id => 1,
      :question_id => 1,
      :experience_id => 1
    ))
  end

  it "renders the edit photo form" do
    render

    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do

      assert_select "textarea#photo_content[name=?]", "photo[content]"

      assert_select "input#photo_link[name=?]", "photo[link]"

      assert_select "input#photo_avatar[name=?]", "photo[avatar]"

      assert_select "input#photo_user_id[name=?]", "photo[user_id]"

      assert_select "input#photo_question_id[name=?]", "photo[question_id]"

      assert_select "input#photo_experience_id[name=?]", "photo[experience_id]"
    end
  end
end
