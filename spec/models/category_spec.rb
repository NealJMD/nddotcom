require 'spec_helper'

describe Category do

  let(:blog) { Category.new(name: "blog") }
  let(:ror) { Category.new(name: "RoR", parent: blog) }
  let(:neuro) { Category.new(name: "neuro", parent: blog) }
  let(:design) { Category.new(name: "Design") }

  before do
    blog.save!
    ror.save!
    neuro.save!
    design.save!
  end

  subject { blog }

  it { should be_valid }
  it { should respond_to :name }
  it { should respond_to :children }
  it { should respond_to :parent }
  it { should respond_to :siblings }

  describe "when name is" do

    describe "whitespace string" do
      before { blog.name = " " }
      it { should_not be_valid }
    end

    describe "empty string" do
      before { blog.name = "" }
      it { should_not be_valid }
    end

    describe "a number" do
      before { blog.name = 123 }
      it { should be_valid }
    end
  end

  describe "parent-child relations" do

    it "should have correct single level children" do
      expect(blog.children).to eq [ror, neuro]
    end

    it "should correctly handle siblings" do
      expect(neuro.siblings).to eq [ror]
    end

    it "should correctly handle parents" do
      expect(neuro.parent).to eq blog
    end

    it "should handle no parents" do
      expect(blog.parent).to eq nil
    end
  end

  describe "with deeper nesting" do

    let(:connectomics) { Category.new(name: "connectomics", parent: neuro) }
    let(:brains) { Category.new(name: "brains", parent: neuro) }
    let(:gems) { Category.new(name: "gems", parent: ror) }

    before do
      connectomics.save!
      brains.save!
      gems.save!
    end

    it "should have correct single level children" do
      expect(blog.children).to eq [ror, neuro]
    end

    it "should correctly handle siblings" do
      expect(neuro.siblings).to eq [ror]
      expect(brains.siblings).to eq [connectomics]
      expect(gems.siblings).to eq []
    end

    it "should correctly handle parents" do
      expect(brains.parent).to eq neuro
      expect(brains.parent.parent).to eq blog
    end

    it "should handle root siblings" do
      expect(design.parent.blank?).to eq true
      expect(design.children.blank?).to eq true
      expect(design.siblings).to eq [blog]
    end

    it "should iterate over them correctly" do
      out = ""
      Category.walk_tree do |cat, level|
        out << "#{'-'*level}#{cat.name}\n"
      end
      expect(out).to eq "Design\nblog\n-RoR\n--gems\n-neuro\n--brains\n--connectomics\n"
    end

    describe "attempted loop" do

      before do
        blog.parent = brains
        @success = blog.save
      end

      it "should have changed the grandparent to itself" do
        expect(blog.parent.parent.parent).to eq blog
      end
    end

  end

end