require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
      end

      # EXERCISE 7.6, #2, WDS tests
      describe "name to long" do
        before do
          fill_in "First", with: ("a" * 51)
          fill_in "Last", with: ("b" * 51)
          fill_in "Email", with: "foo@bar.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirm Password", with: "foobar"
          click_button submit
        end

        it { should have_selector('div', text: 'form contains 2 errors') }
        it { should have_content('First name is too long (maximum is 50 characters') }
        it { should have_content('Last name is too long (maximum is 50 characters') }

      end

      describe "name to long and invalid email" do
        before do
          fill_in "First", with: ("a" * 51)
          fill_in "Last", with: ("b" * 51)
          fill_in "Email", with: "bar.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirm Password", with: "foobar"
          click_button submit
        end

        it { should have_selector('div', text: 'form contains 3 errors') }
        it { should have_content('First name is too long (maximum is 50 characters') }
        it { should have_content('Last name is too long (maximum is 50 characters') }
        it { should have_content('Email is invalid') }

      end
    end

    describe "with valid information" do
      let(:new_user) { FactoryGirl.create(:user) }
      before do
# WDS: Before creating new_form_user from exercises in 8.5 to decouple...
#
#        fill_in "First name",         with: "Example"
#        fill_in "Last name",         with: "User"
#        fill_in "Email",        with: "user@example.com"
#        fill_in "Password",     with: "foobar"
#        fill_in "Confirm Password", with: "foobar"
        new_user.email = "user@example.com"
        new_form_user(new_user)
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_success_message('Welcome') }
      end

    end
  end

end
