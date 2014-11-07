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

  describe "post processing" do
    before do
      @success = @file_asset.save
    end

    it "should have saved successfully" do
      expect(@success).to eq true
    end

    it "should have thumbnails" do
      path = @file_asset.content.path(:square)
      expect(File).to exist("#{Rails.root}/#{path}")
    end

    it "should have the original" do
      path = @file_asset.content.path
      expect(File).to exist("#{Rails.root}/#{path}")
    end

    it "should not have an unspecified format" do
      path = @file_asset.content.path(:wrong)
      expect(File).not_to exist("#{Rails.root}/#{path}")
    end
  end

  describe "non image upload" do

    before do
      @file_asset.content = support_file("test-doc.pdf")
      @success = @file_asset.save
    end

    it "should have saved successfully" do
      expect(@success).to eq true
    end

    it "should not have thumbnails" do
      path = @file_asset.content.path(:square)
      expect(File).not_to exist("#{Rails.root}/#{path}")
    end

    it "should have the original" do
      path = @file_asset.content.path
      expect(File).to exist("#{Rails.root}/#{path}")
    end

  end

end
