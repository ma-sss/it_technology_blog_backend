class Api::V1::UsersController < ApplicationController
    def index
        users = User.all
        if users
            render json: { status: 'SUCCESS', data: users }
        else
            render json: { status: 'ERROR', data: users.errors }
        end
    end

    def show
        user = User.find(params[:id])
        if user
            render json: { status: 'SUCCESS', data: user }
        else
            render json: { status: 'ERROR', data: user.errors }
        end
    end
end
