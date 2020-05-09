require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(),
      Post.create!()
    ])
  end

  it "renders a list of posts" do
    render
  end
end
