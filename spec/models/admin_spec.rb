require 'spec_helper'

describe Admin do
  
  let(:email) { "nealjmd@gmail.com" }
  let(:password) { "asdfasdf" }

  before do
    @admin = Admin.new(email: email, 
                     password: password,
                     password_confirmation: password)
  end

  subject { @admin }
  
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:encrypted_password) }
  it { should be_valid }

  describe "when email is not present" do
    before { @admin.email = " " }
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before do
      @admin.password = " "
      @admin.password_confirmation = " "
    end 
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @admin.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @admin.password = @admin.password_confirmation = "a" * 3 }
    it { should_not be_valid } 
  end
  
  describe "with a password that's too long" do
    before { @admin.password = @admin.password_confirmation = "a" * 129 }
    it { should_not be_valid } 
  end
  
  describe "when email format is invalid" do
    it "for a number of invalid formats" do
      addresses = %w[admin@foo,com admin_at_foo.org example.admin@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @admin.email = invalid_address
        expect(@admin).not_to be_valid
      end
    end
  end
  
  describe "when another admin has the same email" do

    before do
      @other_admin = Admin.new(email: email,
                     password: password,
                     password_confirmation: password)
      @other_admin.save!
    end
    
    it { should_not be_valid }
  end
  
  describe "when another admin has the same email with different case" do

    before do
      @other_admin = Admin.new(email: email.upcase,
                     password: password,
                     password_confirmation: password)
      @other_admin.save!
    end
    
    it { should_not be_valid }
  end
end
