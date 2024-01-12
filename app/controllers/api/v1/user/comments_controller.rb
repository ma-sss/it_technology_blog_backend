class Api::V1::User::CommentsController < ApplicationController
    def index
        comments = Comment.where(post_id:params[:post_id])
        if comments
            render json: { status: 'SUCCESS', data: comments }
        else
            render json: { status: 'ERROR', data: comments.errors }
        end
    end

    def create
        user = User.new(create_user_params)
        comment = Comment.new(create_params)
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
        params.permit(:text, :post_id)
    end

    def create_user_params
        params.permit(:name)
    end
end
