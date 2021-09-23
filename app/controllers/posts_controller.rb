class PostsController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:search] == nil
          @posts= Post.all
        elsif params[:search] == ''
          @posts= Post.all
        else
          #部分検索
          @posts = Post.where("category LIKE ? ",'%' + params[:search] + '%')
        end
          @posts = @posts.page(params[:page]).per(5)
          @allposts = Post.select(:category).distinct
    end

    def new
        @post = Post.new #空のインスタンスを生成
    end

    def show
        @post = Post.find(params[:id])
    end

    def create
        @post = Post.new(post_params) #データを新規登録するためのインスタンス生成
        @post.user_id = current_user.id
        @post.save #データをデータベースに保存するためのsaveメソッド実行
        redirect_to action: 'index' #トップ画面へリダイレクト
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path, notice:"削除しました"
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          redirect_to posts_path, notice: "編集しました"
        else
          render 'edit'
        end
    end
      
    private
    def post_params #ストロングパラメータ
          params.require(:post).permit(:title, :body, :category) #パラメーターのキー
    end
    
end
