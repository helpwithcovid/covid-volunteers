require 'rails_helper'

RSpec.describe "success_stories/index", type: :view do
  before(:each) do
    assign(:success_stories, [
      SuccessStory.create!(),
      SuccessStory.create!()
    ])
  end

  it "renders a list of success_stories" do
    render
  end
end
