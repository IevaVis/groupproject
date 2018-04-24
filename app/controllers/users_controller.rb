class UsersController < Clearance::UsersController

	def new
		@user = User.new
		@role = get_role(params[:role])
	end

	def create
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def allowed_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :about_me)
	end


end