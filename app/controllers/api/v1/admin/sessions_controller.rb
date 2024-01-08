class Api::V1::Admin::SessionsController < DeviseTokenAuth::SessionsController
    private
    def configure_sign_in_params
        params.require(:session).permit(:email, :password)
    end
end
