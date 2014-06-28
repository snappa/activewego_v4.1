require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
# WDS: Replaced the following with a helper "have_error_message" in spec/support/utilities.rb
#      it { should have_selector('div.alert.alert-error') }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
 # WDS: Replaced the following with a helper "have_error_message" in spec/support/utilities.rb
#       it { should_not have_selector('div.alert.alert-error') }
        it { should_not have_error_message('') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
#          fill_in "Email",    with: user.email.upcase
#          fill_in "Password", with: user.password
#          click_button "Sign in"

#          valid_signin(user)
          sign_in(user, { no_capybara: false })
        end

        it { should have_title(user.name) }
        it { should have_link('Users',       href: users_path) }
        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Settings',    href: edit_user_path(user)) }
        it { should have_link('Sign out',    href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }

        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end

        describe "signed in user can't create new user" do
          describe "can't create new when logged in" do
            before { visit new_user_path }
            it { should have_info_message("logged in and can't create a new user..") }
          end
        end
=begin
  WDS: Need to figure out how to test the controller directly without invoking the
       "new" first.  Need to test the action 'create'

        describe "test create" do
          before do
            post '/users', {methpd: 'post', user: {first_name: "boo", last_name: "bar", password: "password",
                                     password_confirmation: "password",
                                     email: "boo@bar.com"}}
          end
          it { should have_info_message("logged in and can't create a new user..") }
        end
=end
      end

    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
      end

      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end

          describe "when signing in again" do
            before do
              click_link "Sign out"
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              expect(page).to have_title(user.name)
            end
          end
        end
      end

    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "admin user can NOT delete themselves" do
      let(:admin_user) { FactoryGirl.create(:admin) }

      before { sign_in admin_user, no_capybara: true }

      describe "no way" do
          before { delete user_path(admin_user) }
          specify { expect(response).to redirect_to(users_path) }
      end

      describe "can't delete self" do
        it "should not be possible" do
          expect { delete user_path(admin_user)  }.not_to change(User, :count)
        end
      end

#        expect do
#          delete user_path(admin)
#        end.not_to change(User, :count).by(-1)
    end

  end

end
