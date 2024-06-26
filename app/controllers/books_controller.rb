class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book.view_count+=1
    @book.save
    @book_comment = BookComment.new
  end

  def index
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    if params[:status].to_i == 1
      @books = Book.includes(:favorites).all.order(created_at: :desc)
    elsif params[:status].to_i == 2
      @books = Book.includes(:favorites).all.order(star: :desc)
    else
      @books = Book.includes(:favorites).
        sort {|a,b| 
          b.favorites.where(created_at: from...to).size <=> 
          a.favorites.where(created_at: from...to).size
        }
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:tag_ids].split(',')
    if @book.save
      @book.save_tags(tag_list)  
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  def search_tag
      @tag = Tag.find_by(name: params[:name])
      if @tag.nil?
        @tag = ""
        @books = nil
      else
        @books = @tag.books.all
      end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end