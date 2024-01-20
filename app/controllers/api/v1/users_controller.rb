class Api::V1::UsersController < ApplicationController
    def index
        users = User.all
        if users.present?
            render json: { status: 'SUCCESS', data: users }
        else
            render json: { status: 'ERROR', data: users.errors }
        end
    end
end
