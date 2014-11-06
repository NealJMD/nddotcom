require 'spec_helper'

describe FileAsset do

  before do
    @cat = Category.new(name: "Blog")
    @post = Post.new(title: "My first post", body: "<h1>hey!</h1> <p>yup</p>", category: @cat)
    @file_asset = FileAsset.new(name: "yeah image", post: @post, content: support_file("test-image.png"))
  end

  subject { @file_asset }

  it { should respond_to(:name) }
  it { should respond_to(:post) }
  it { should respond_to(:content) }
  it { should be_valid }


  describe "when name is not present" do
    before { @file_asset.name = " " }
    it { should_not be_valid }
  end
  describe "when post is not present" do
    before { @file_asset.post = nil }
    it { should_not be_valid }
  end
end
