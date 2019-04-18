require 'rails_helper'

RSpec.describe NewsArticle, type: :model do

    describe "validates" do
        it("requires a title") do
          news_article = NewsArticle.new
          news_article.valid?
          expect(news_article.errors.messages).to(have_key(:title))
        end
    
    
        it("requires a unique title") do
          unique_article = NewsArticle.create(title: "Best Article", description:"best description")
          n_a = NewsArticle.new(title: unique_article.title)
          n_a.valid?
          expect(n_a.errors.messages).to have_key(:title)
        #   byebug
          expect(n_a.errors.messages[:title]).to(include("has already been taken"))
        end

        it("requires a description") do
            news_article = NewsArticle.new
            news_article.valid?
             expect(news_article.errors.messages).to(have_key(:description))
        end

        it "published date is after created date" do
          n = NewsArticle.new(title: "Best Article", description:"best description")
          n.save
          n.published_at = n.created_at
          n.valid?
          expect(n.errors).to have_key(:published_at)
        end
    end
      
end