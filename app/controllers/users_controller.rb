class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action:signed_in_user_exclusion, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if (user.id == current_user.id)
      flash.now[:error] = "You can not delete yourself!"
      logger.error("You can not delete yourself!")
    else
      logger.error("**** destroying #{user.email} ****")
      user.destroy
      flash.now[:success] = "User destroyed."
      logger.error("**** destroyed D2")
      begin
        u2 = User.find(params[:id])
        logger.error("**** destroyed #{user.email}.  U2 found? #{u2.email}")
      rescue
        logger.error("****  DID destroy #{user.email}")
      end
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def signed_in_user_exclusion
      if signed_in?
#        puts 'already signed in...'
        flash[:info] = "You're already logged in and can't create a new user..."
        redirect_to(root_path)
      end
    end

end
