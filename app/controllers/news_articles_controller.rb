class NewsArticlesController < ApplicationController
    before_action :find_news_article, only: [:destroy, :edit]
    before_action :authenticate_user!, only: [:new, :create, :edit]
    def new
        @news_article = NewsArticle.new
    end

    def create
        @news_article = NewsArticle.new news_article_params
        @news_article.user = current_user
        if @news_article.save
            redirect_to news_articles_path(@news_article)
        else
            render :new
        end
    end

    def destroy
        @news_article.destroy
    end

    def show
    end

    def index
        @news_articles = NewsArticle.all
    end

    def edit
        if can? :edit, @news_article

        else
            redirect_to root_path, alert: 'Not authorized'
        end
    end

    private
    def find_news_article
        @news_article = NewsArticle.find params[:id]
    end
    def news_article_params
      params.require(:news_article).permit(
        :title, :description)
    end

end
