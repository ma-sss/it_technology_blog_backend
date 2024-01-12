class Api::V1::UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        if user
            render json: { status: 'SUCCESS', data: user }
        else
            render json: { status: 'ERROR', data: user.errors }
        end
    end
end
