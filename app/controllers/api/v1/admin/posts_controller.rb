class Api::V1::Admin::PostsController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:create, :update, :destroy]

    def index
        posts = Post.all
        if posts.present?
            render json: { status: 'SUCCESS', data: posts }
        else
            render json: { status: 'ERROR', data: ['No posts found'] }
        end
    end

    def show
        post = Post.find(params[:id])
        if post.present?
            render json: { status: 'SUCCESS', data: post }
        else
            render json: { status: 'ERROR', data: post.error }
        end
    end

    def create
        post = Post.new(create_params)
        post.admin_id = params[:admin_id]

        if post.save
            render json: { status: 'SUCCESS', data: post }
        else
            errors = {}
            errors[:status] = 'ERROR'
            errors[:error] = []

            errors[:error].concat(post.errors.full_messages)
            render json: errors
        end
    end

    def update
        post = Post.find_by(id: params[:id])
        if post.update(update_params)
            render json: { status: 'SUCCESS', data: post }
        else
            render json: { status: 'ERROR',  errors: post.errors.full }
        end
    end

    def destroy
        post = Post.find_by(id: params[:id])
        if post.destroy
            render json: { status: 'SUCCESS', message: 'Deleted the post' }
        else
            render json: { status: 'ERROR', message: 'Failed to delete post', errors: post.errors.full_messages }
        end
    end

    private
    def create_params
        params.require(:post).permit(:title, :content, :category)
    end

    def update_params
        params.require(:post).permit(:title, :content)
    end
end
