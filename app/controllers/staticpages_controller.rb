class StaticpagesController < ApplicationController
  def top
    @articles = Article.all
  end
end
