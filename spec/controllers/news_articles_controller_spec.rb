require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do

    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe "#new" do
        context "without signed in user" do
            it "redirects the user to session new" do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end

        end

        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end

            it "renders a new template" do
                get(:new)
                expect(response).to(render_template(:new))
            end
    
            it "sets an instance variable of a new news article" do
                get(:new)
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
            end

        end

    end

    describe "#create" do
        def valid_request
            post(:create, params: { news_article: FactoryBot.attributes_for(:news_article) })
        end

        context "without signed in user" do
            it "redirects to the new session path" do
                valid_request
                expect(response).to redirect_to(new_session_path) 
            end
        end

        context "with signed in user" do

            before do
                session[:user_id] = current_user.id
            end

            context "with valid parameters" do
             
                it "creates a new articles" do
                    count_before = NewsArticle.count
                    valid_request
                    count_after = NewsArticle.count
                    expect(count_after).to eq(count_before + 1)
                end

                it "redirects to the show page of that post" do
                    valid_request
                    expect(response).to redirect_to(news_articles_path(NewsArticle.last))
                end
            end

            context "with invalid parameters" do
                    def invalid_request
                        post(:create,params: { news_article: FactoryBot.attributes_for(:news_article, title: nil)})
                    end

                    it "doesn't create a news artcile" do
                        count_before = NewsArticle.count
                        invalid_request
                        count_after = NewsArticle.count
                        expect(count_after).to(eq(count_before))
                    end

                    it "renders the new template" do
                        invalid_request
                        expect(response).to(render_template(:new))
                    end

            end
        end    
    end

    describe "#destroy" do

        before do 
            @news_article = FactoryBot.create(:news_article)
        end

        it "removes a record from the database" do
            count_before = NewsArticle.count
            delete :destroy, params: {id: @news_article.id}
            count_after = NewsArticle.count
            expect(count_after).to(eq(count_before - 1))
        end
    end

    describe "#show" do
        it "renders the show template" do
        news_article = FactoryBot.create(:news_article)
        get(:show, params: { id: news_article.id })
        expect(response).to(render_template(:show))
        end
    end

    describe "#index" do
        it "renders the index template" do
            get(:index)
            expect(response).to(render_template(:index))
        end

        it "sets an instance variable of a new all news article" do
            get(:index)
            expect(assigns(:news_articles)).to(be_a_new(NewsArticle.all))
        end
    end

    describe "#edit" do
        before do 
            @news_article = FactoryBot.create(:news_article)
        end
        context "without signed in user" do
            it "redirects to the new session path" do
                get(:edit, params: { id: @news_article.id })
                expect(response).to redirect_to(new_session_path) 
            end
        end

        context "with signed in user" do
            before do
                session[:user_id] = current_user.id
            end

            context "not owner of article" do
                it "redirect to root page" do
                    get(:edit, params: { id: @news_article.id })
                    expect(response).to redirect_to(root_path) 
                end
                it "sets a danger flash message" do
                    get(:edit, params: { id: @news_article.id })
                    expect(flash[:alert]).to be
                end
            end

            context "owner of article" do
                before do
                    @news_article.user.id = current_user.id
                end
                it "renders the edit template" do
                    get(:edit)
                    expect(response).to(render_template(:edit))
                end
            end
        end
    end

end
