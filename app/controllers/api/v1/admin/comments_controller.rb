class Api::V1::Admin::CommentsController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:create, :destroy]

    def create
        comment = Comment.new(create_params)
        if comment.save
            render json: { status: 'SUCCESS', data: comment }
        else
            render json: { status: 'ERROR', data: comment.errors }
        end
    end

    def destroy
        comment = Comment.find_by(id: params[:id])
        if comment.destroy
            render json: { status: 'SUCCESS', message: 'Deleted the comment' }
        else
            render json: { status: 'Error', message: 'Failed to delete comment', errors: comment.errors.full_messages }
        end

    end

    private
    def create_params
        params.permit(:post_id, :text, :admin_id)
    end
end
