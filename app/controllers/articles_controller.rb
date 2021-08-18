class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end


  # The reason why we added @article = Article.new in the ArticlesController is that 
  # otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.
  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  # def create
  #   # This creates a new article but the inbuilt security throws an error because 
  #   # we have no told our app if the data is allowed or not
  #   # @article = Article.new(params[:article])
 
  #   # This allows our spefic attributes to be passed in from the form
  #   @article = Article.new(params.require(:article).permit(:title, :text))

  #   @article.save
  #   redirect_to @article    
  # end


# From Before adding error correction to database
  # def create
  #   @article = Article.new(article_params)
   
  #   @article.save
  #   redirect_to @article
  # end


  # this checks to see if the save function runs on the new article, if it doesn't, it shows the form again
  def create
    @article = Article.new(article_params)
   

    # Notice that inside the create action we use render instead of redirect_to when save returns false. 
    # The render method is used so that the @article object is passed back to the new template when it is rendered. 
    # This rendering is done within the same request as the form submission, whereas the redirect_to will tell 
    # the browser to issue another request.
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
   
  def update
    @article = Article.find(params[:id])
   
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
   
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
