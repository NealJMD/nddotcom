require 'spec_helper'

describe "Category pages" do
  let(:admin) { create_admin }
  let(:ideas) { Category.new(name: "ideas") }
  
  before do
    ideas.save!
    login_as(admin)
  end

  describe "new" do
    before { visit new_category_path }
    
    it "should successfully save a valid category" do
      name = "brains"
      fill_in "Name", with: name
      select "ideas", from: "Parent"
      click_button "Create Category"
      expect(page).to have_content("Category was successfully created")
      expect(Category.last.name).to eq name
      expect(Category.last.parent.name).to eq "ideas"
      expect(current_path).to eq "/"+name
    end
    
    it "should be rejected saving a category with duplicate slug" do
      name = "  IdeAs  "
      fill_in "Name", with: name
      select "ideas", from: "Parent"
      click_button "Create Category"
      expect(page).to have_content("Slug has already been taken")
      expect(page).to have_field("Parent")
      expect(Category.last.name).not_to eq name
    end
    
  end
end
