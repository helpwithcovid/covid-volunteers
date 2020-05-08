require 'rails_helper'

RSpec.describe "success_stories/edit", type: :view do
  before(:each) do
    @success_story = assign(:success_story, SuccessStory.create!())
  end

  it "renders the edit success_story form" do
    render

    assert_select "form[action=?][method=?]", success_story_path(@success_story), "post" do
    end
  end
end
