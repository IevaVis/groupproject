class UsersController < Clearance::UsersController
	before_action :require_login, except: :create

	def new
		@user = User.new
	end

	def create
		@user = User.new(allowed_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			sign_in @user
			redirect_to user_path(@user)
		else
			flash[:alert] = @user.errors.full_messages.join(',')
			render template: "users/new"
		end
	end

	def show
		@user = User.find(params[:id])
		@user_articles = @user.articles
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(allowed_params)
			redirect_to user_path(@user)
		else
			render template: "users/edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path
	end


	private

	def allowed_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :about_me, :role, :title, :avatar)
	end

	def require_login
		if !current_user
			redirect_to root_path
		end
	end


end