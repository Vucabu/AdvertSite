require 'spec_helper'

describe "Site pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_selector('h3',    text: 'Advert Feed') }
    it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:advert, user: user, content: "Sell 5 iMac", email: "example@example.ru",
                           title: "Title title", city: "Sevastopol", address: "Str. Aasdd", category_id: 2)
        FactoryGirl.create(:advert, user: user, content: "Sell 2 iPad", email: "asdas@asd.as",
                           title: "Title title", city: "Sevastopol", address: "Str. Aasdd", category_id: 3)
        sign_in user
        visit user_path(user)
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li#{item.id}")
        end
      end
    end
  end
end