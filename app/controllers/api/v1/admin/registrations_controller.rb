class Api::V1::Admin::RegistrationsController < DeviseTokenAuth::RegistrationsController
    private
    def sign_up_params
        params.require(:registration).permit(:email, :password, :password_confirmation)
    end
end
