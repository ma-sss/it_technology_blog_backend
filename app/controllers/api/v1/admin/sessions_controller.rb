class Api::V1::Admin::SessionsController < DeviseTokenAuth::SessionsController
    private
    def resource_params
        params.require(:session).permit(:email, :password)
    end
end
