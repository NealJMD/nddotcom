require 'spec_helper'

describe Post do

  let(:blog) { Category.new(name: "blog") }
  let(:ror) { Category.new(name: "RoR", parent: blog) }
  let(:np) { Category.new(name: "NP", parent: blog) }
  let(:now) { Time.now }
  let(:body) { "<h1>boy do I like tests!</h1>" }

  before do
    [blog, ror, np].each do |c| c.save! end
    @post = Post.new(title: "my sweet post", body: body, category: ror, published_at: now)
  end

  subject { @post }

  it { should be_valid }
  it { should respond_to :category }
  it { should respond_to :file_assets }
  it { should respond_to :image_assets }
  it { should respond_to :next }
  it { should respond_to :previous }
  it { should respond_to :body }
  it { should respond_to :title }
  it { should respond_to :published_at }
  it { should respond_to :is_single_image }

  describe "next and previous" do

    before do
      5.times do |n|
        p = Post.new(title: "p#{n}", body: body, category: np, published_at: now + n.days - 2.days)
        p.save!
      end
      p = Post.new(title: "no", body: body, category: ror, published_at: now)
      p.save!
    end

    it "should have the next posts in the correct order" do
      posts = Post.where(category: np)
      nexts = posts.map{ |p| p.next }
      expect(nexts).to eq [nil] + posts[0...-1]
    end

    it "should have the previous posts in the correct order" do
      posts = Post.where(category: np)
      prevs = posts.map{ |p| p.previous }
      expect(prevs).to eq posts[1..-1] + [nil]
    end

    describe "with duplicate dates" do

      before do
        3.times do |n|
          Post.new(title: "p2#{n}", body: body, category: np, published_at: now).save!
        end
        3.times do |n|
          Post.new(title: "p3#{n}", body: body, category: np, published_at: now - 1.year).save!
        end
      end

      it "should have the next posts in the correct order" do
        posts = Post.where(category: np)
        nexts = posts.map{ |p| p.next }
        expect(nexts).to eq [nil] + posts[0...-1]
      end

      it "should have the previous posts in the correct order" do
        posts = Post.where(category: np)
        prevs = posts.map{ |p| p.previous }
        expect(prevs).to eq posts[1..-1] + [nil]
      end
    end

  end
end