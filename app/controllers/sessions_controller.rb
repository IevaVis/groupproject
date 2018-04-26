class SessionsController < Clearance::SessionsController
	def create_from_omniauth
  		auth_hash = request.env["omniauth.auth"]
  		authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

  # if: previously already logged in with OAuth
  	if authentication.user
   	 	user = authentication.user
    	authentication.update_token(auth_hash)
    	@next = root_url
    	@notice = "Signed in!"
  # else: user logs in with OAuth for the first time
  	else
   		 user = User.create_with_auth_and_hash(authentication, auth_hash)
  	end

  	sign_in(user)
  	redirect_to root_path 
   
	end

  def create
    @role = params[:session][:role]
    @user = authenticate(params) 

    sign_in(@user) do |status|
      if sign_in_successful?(status)
        redirect_back_or url_after_create
      else
        sign_out
        flash[:notice] = "Please sign in with correct account!"
        render template: "sessions/new", status: :unauthorized
      end
    end
  end

 	private
  
    def sign_in_successful?(status)
      status.success? && @user.role == @role
    end

  	def url_after_destroy
    	root_path
  	end

end



