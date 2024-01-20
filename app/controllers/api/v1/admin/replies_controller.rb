class Api::V1::Admin::RepliesController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:create, :update, :destroy]

    def show
        reply = Reply.find(params[:id])
        if reply.present?
            render json: { status: 'SUCCESS', data: reply }
        else
            render json: { status: 'Error',  errors: reply.errors }
        end
    end

    def create
        reply = Reply.new(reply_create_params)
        reply.comment_id = params[:comment_id]
        reply.admin_id = params[:admin_id]
        if reply.save
            render json: { status: 'SUCCESS', data: reply } 
        else
            render json: { status: 'Error',  errors: reply.errors }
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

    def update_params
        params.require(:reply).permit(:text)
    end
end
