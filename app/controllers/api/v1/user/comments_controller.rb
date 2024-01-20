class Api::V1::User::CommentsController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:update, :destroy]

    def index
        comments = Comment.all
        if comments.present?
            render json: { status: 'SUCCESS', data: comments }
        else
            render json: { status: 'ERROR', data: comments.errors }
        end
    end

    def show
        comment = Comment.find(params[:id])
        if comment.present?
            render json: { status: 'SUCCESS', data: comment }
        else
            render json: { status: 'ERROR', data: comment.errors }
        end
    end

    def create
        user = User.new(create_user_params)
        comment = Comment.new(create_comment_params)

        if user.save
            comment.user_id = user.id
            if comment.save
                render json:  { user: { status: 'SUCCESS', data: user }, comment: { status: 'SUCCESS', data: comment } }
            else
                render json: { status: 'ERROR', data: comment.errors }
            end
        else
            render json: { status: 'ERROR', data: user.errors }
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
    def create_comment_params
        params.require(:comment).permit(:text, :post_id)
    end

    def create_user_params
        params.require(:user).permit(:name)
    end

    def update_params
        params.require(:comment).permit(:text)
    end
end
