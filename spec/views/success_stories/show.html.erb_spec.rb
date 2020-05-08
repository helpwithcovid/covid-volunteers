require 'rails_helper'

RSpec.describe "success_stories/show", type: :view do
  before(:each) do
    @success_story = assign(:success_story, SuccessStory.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
