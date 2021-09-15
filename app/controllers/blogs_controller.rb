class BlogsController < ApplicationController
  def index
    if params[:search] == nil
      @blogs= Blog.all
    elsif params[:search] == ''
      @blogs= Blog.all
    else
      #部分検索
      @blogs = Blog.where("category LIKE ? ",'%' + params[:search] + '%')
    end
    @allblogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
    params[:search] = @blog.start_time.to_date #datetimeの日付のみparams[:search]で取得
    #日付が同じ投稿のみ検索
    @blogs = Blog.where("start_time >= ? AND start_time < ?", params[:search], params[:search] + 1)
  end

  def create
    Blog.create(blog_parameter)
    redirect_to blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"削除しました"
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_parameter)
      redirect_to blogs_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def blog_parameter
    params.require(:blog).permit(:title, :content, :start_time, :category)
  end
  
end
