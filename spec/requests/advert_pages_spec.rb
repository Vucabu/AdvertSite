require 'spec_helper'

describe "Advert pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "advert creation" do
    before { visit add_path }

    describe "with invalid information" do

      it "should not create a advert" do
        expect { click_button "Post" }.not_to change(Advert, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'advert_content', with: "Lorem ipsum" }
      it "should create a advert" do
        expect { click_button "Post" }.to change(Advert, :count).by(1)
      end
    end
  end

  describe "advert destruction" do
    before { FactoryGirl.create(:advert, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a advert" do
        expect { click_link "Delete" }.to change(Advert, :count).by(-1)
      end
    end
  end
end
