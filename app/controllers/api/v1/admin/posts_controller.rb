class Api::V1::Admin::PostsController < ApplicationController
    before_action :authenticate_api_v1_admin!, only: [:create, :destroy]

    def index
        posts = Post.all
        if posts
            render json: { status: 'SUCCESS', data: posts }
        else
            render json: { status: 'ERROR', data: posts.errors }
        end
    end

    def show
        post = Post.find(params[:id])
        if post
            render json: { status: 'SUCCESS', data: post }
        else
            render json: { status: 'ERROR', data: post.error }
        end
    end

    def create
        post = Post.new(create_params)
        if post.save
            render json: { status: 'SUCCESS', data: post }
        else
            render json: { status: 'ERROR', data: post.errors }
        end
    end

    def update
        post = Post.find_by(id: params[:id])
        if post.update(update_params)
            render json: { status: 'SUCCESS', data: post }
        else
            render json: { status: 'Error',  errors: post.errors }
        end
    end

    def destroy
        post = Post.find_by(id: params[:id])
        if post.destroy
            render json: { status: 'SUCCESS', message: 'Deleted the post' }
        else
            render json: { status: 'Error', message: 'Failed to delete post', errors: post.errors.full_messages }
        end

    end

    private
    def create_params
        params.permit(:admin_id, :title, :content)
    end

    def update_params
        params.permit(:title, :content)
    end
end
