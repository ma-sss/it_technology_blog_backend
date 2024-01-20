class Api::V1::Admin::CommentsController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:create, :update, :destroy]

    def show
        comment = Comment.find(params[:id])
        if comment..present?
            render json: { status: 'SUCCESS', data: comment }
        else
            render json: { status: 'ERROR', data: comment.errors }
        end
    end

    def create
        comment = Comment.new(create_params)
        comment.admin_id = params[:admin_id]
        if comment.save
            render json: { status: 'SUCCESS', data: comment }
        else
            render json: { status: 'ERROR', data: comment.errors }
        end
    end

    def update
        comment = Comment.find_by(id: params[:id])
        if comment.update(update_params)
            render json: { status: 'SUCCESS', data: comment }
        else
            render json: { status: 'Error',  errors: comment.errors }
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
        params.require(:comment).permit(:text, :post_id)
    end

    def update_params
        params.require(:comment).permit(:text)
    end
end
