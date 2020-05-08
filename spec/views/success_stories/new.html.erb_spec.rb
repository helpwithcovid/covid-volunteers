require 'rails_helper'

RSpec.describe "success_stories/new", type: :view do
  before(:each) do
    assign(:success_story, SuccessStory.new())
  end

  it "renders new success_story form" do
    render

    assert_select "form[action=?][method=?]", success_stories_path, "post" do
    end
  end
end
