require 'spec_helper'

describe Advert do
  let(:user) { FactoryGirl.create(:user) }
  before { @advert = user.adverts.build(content: "Lorem ipsum") }

  subject { @advert }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:category_id) }
  it { should respond_to(:city) }
  it { should respond_to(:email) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @advert.user_id = nil }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Advert.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @advert.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @advert.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @advert.content = "a" * 141 }
    it { should_not be_valid }
  end
end
