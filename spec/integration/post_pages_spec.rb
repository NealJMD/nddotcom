require 'spec_helper'

describe "Category pages" do
  let(:admin) { create_admin }
  let(:ideas) { Category.new(name: "ideas") }
  let(:neuro) { Category.new(name: "neuro", parent: ideas) }
  let(:neuro_first_post) { Post.new(title: "Axons are great!", body: "hey yo yo g", category: neuro, published_at: Time.now) }
  let(:neuro_second_post) { Post.new(title: "& dendrites are cool", body: "thats whats up", category: neuro, published_at: Time.now) }

  let(:software) { Category.new(name: "software") }
  let(:grinbox_cat) { Category.new(name: "grinbox", parent: software) }
  let(:grinbox_post) { Post.new(title: "grinbox", body: "gbx body", category: grinbox_cat, published_at: Time.now) }
  
  before do
    [ideas, neuro, software, grinbox_cat, neuro_first_post, neuro_second_post, grinbox_post].each do |thing|
      thing.save!
    end
  end

  describe "paths" do
    
    it "should allow clicking through nested categories" do
      visit category_clean_path(ideas)
      expect(page.status_code).to eq 200
      first(:link, neuro.name).click
      expect(page.status_code).to eq 200
      expect(current_path).to eq "/"+neuro.slug
      click_link neuro_first_post.title
      expect(page.status_code).to eq 200
      expect(current_path).to eq "/"+neuro.slug+"/"+neuro_first_post.slug
    end
    
    it "should render post for category with one post" do
      visit category_clean_path(software)
      first(:link, grinbox_cat.name).click
      expect(page.status_code).to eq 200
      expect(current_path).to eq "/"+grinbox_post.slug
      expect(page).to have_content(grinbox_post.body)
    end

  end
end
