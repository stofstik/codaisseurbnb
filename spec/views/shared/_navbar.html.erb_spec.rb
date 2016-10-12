require 'rails_helper'

describe "shared/_navbar.html.erb" do

  context "user signed in" do
    before { sign_in user }

    context "without profile" do
      let(:user) { create :user }

      it "renders email" do
        render
        expect(rendered).to have_content user.email
      end
    end

    context "with profile" do
      let(:profile) { create :profile }
      let(:user) { create :user, profile: profile }

      it "renders full name" do
        render
        puts user.full_name
        expect(rendered).to have_content user.full_name
      end
    end

  end

  context "user not signed in" do
    it "shows login and signup" do
      render
      expect(rendered).to have_content "Log In"
      expect(rendered).to have_content "Sign Up"
    end
  end

end
