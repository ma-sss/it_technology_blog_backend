class Api::V1::User::RepliesController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:update, :destroy]

    def index
        replies = Reply.all
        if replies.present?
            render json: { status: 'SUCCESS',  data: replies }
        else
            render json: { status: 'Error',  errors: replies.errors }
        end
    end

    def show
        reply = Reply.find(params[:id])
        if reply.present?
            render json: { status: 'SUCCESS',  data: reply }
        else
            render json: { status: 'Error',  errors: reply.errors }
        end
    end

    def create
        reply = Reply.new(reply_create_params)
        reply.comment_id = params[:comment_id]
        user = User.new(user_create_params)
        if user.save
            reply.user_id = user.id
            if reply.save
                render json:  { user: { status: 'SUCCESS', data: user }, reply: { status: 'SUCCESS', data: reply } }
            else
                render json: { status: 'Error',  errors: reply.errors }
            end
        else
            render json: { status: 'Error',  errors: user.errors }
        end
    end

    def update
        reply = Reply.find_by(id: params[:id])
        if reply.update(update_params)
            render json: { status: 'SUCCESS', data: reply }
        else
            render json: { status: 'Error',  errors: reply.errors }
        end
    end

    def destroy
        reply = Reply.find_by(id: params[:id])
        if reply.destroy
            render json: { status: 'SUCCESS', message: 'Deleted the reply' }
        else
            render json: { status: 'Error', message: 'Failed to delete reply', errors: reply.errors.full_messages }
        end
    end

    private
    def reply_create_params
        params.require(:reply).permit(:text)
    end

    def user_create_params
        params.require(:user).permit(:name)
    end

    def update_params
        params.require(:reply).permit(:text)
    end
end
