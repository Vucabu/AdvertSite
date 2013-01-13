require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:email) }
  it { should respond_to(:role_id) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:adverts) }
  it { should respond_to(:feed) }

  it { should be_valid }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "c" * 25 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "advert associations" do

    before { @user.save }
    let!(:older_advert) do
      FactoryGirl.create(:advert, user: @user, created_at: 1.day.ago, email: "example@example.ru",
                         title: "Title title", city: "Sevastopol", address: "Str. Aasdd", category_id: 2)
    end
    let!(:newer_advert) do
      FactoryGirl.create(:advert, user: @user, created_at: 1.hour.ago, email: "example@example.ru",
                         title: "Title title", city: "Sevastopol", address: "Str. Aasdd", category_id: 2)
    end

    it "should have the right adverts in the right order" do
      @user.adverts.should == [newer_advert, older_advert]
    end

    it "should destroy associated adverts" do
      adverts = @user.adverts.dup
      @user.destroy
      adverts.should_not be_empty
      adverts.each do |advert|
        Advert.find_by_id(advert.id).should be_nil
      end
    end

    describe "status" do
      its(:feed) { should include(newer_advert) }
      its(:feed) { should include(older_advert) }
    end
  end


end
