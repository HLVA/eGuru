require 'rails_helper'

RSpec.describe "photos/new", type: :view do
  before(:each) do
    assign(:photo, Photo.new(
      :content => "MyText",
      :link => "MyString",
      :avatar => "MyString",
      :user_id => 1,
      :question_id => 1,
      :experience_id => 1
    ))
  end

  it "renders new photo form" do
    render

    assert_select "form[action=?][method=?]", photos_path, "post" do

      assert_select "textarea#photo_content[name=?]", "photo[content]"

      assert_select "input#photo_link[name=?]", "photo[link]"

      assert_select "input#photo_avatar[name=?]", "photo[avatar]"

      assert_select "input#photo_user_id[name=?]", "photo[user_id]"

      assert_select "input#photo_question_id[name=?]", "photo[question_id]"

      assert_select "input#photo_experience_id[name=?]", "photo[experience_id]"
    end
  end
end
