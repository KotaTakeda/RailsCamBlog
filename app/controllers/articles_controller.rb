class ArticlesController < ApplicationController
    def new
        @article = current_user.articles.build if signed_in?
    end
    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to @article
        else
            render 'new_article_path'
        end
    end
    def destroy
        @article = Article.find(params[:id])
        if current_user == @article.user
            @article.destroy
        else
            flash[:danger] = "Not yours"
        end
        redirect_to root_path
        
    end

    def show
        @article = Article.find(params[:id])
        @user = @article.user
        @article.increment_view
        # REDIS.zincrby "ranking/#{category.id}/#{Date.today.to_s}", 1, "#{article.id}"
    end

    def edit
        @article = Article.find(params[:id])
        if current_user == @article.user 
            
        else
            redirect_to root_path
            flash[:danger] = "Not yours"
        end
        
    end

    def update
        @article = Article.find(params[:id])
        if @article.update_attributes(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    private
        def article_params
            params.require(:article).permit(:title, :content)
        end
end
