class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_review, only: [:destroy]
    before_action :authorize, only: [:edit,:update, :destroy]

    def create
        @product = Product.find(params[:product_id])
        @review = Review.new review_params
        @review.product = @product
        @review.user = current_user
        if @review.save
            redirect_to product_path(@product)
        else
            @reviews = @product.reviews.order(created_at: :desc)
            render 'products/show'
        end
    end

    

    def destroy
        @review.destroy
        redirect_to product_path(@review.product)
    end

    private
    def review_params
        params.require(:review).permit(:body, :rating)
    end

    def authorize
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @review)
    end

    def find_review
        @review = Review.find(params[:id])
    end
end
