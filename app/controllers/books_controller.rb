class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all

    if params[:id].present?
      @book = Book.find(params[:id])
    else
      @book = Book.new
    end
  end

  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save(book_params)
        format.html { redirect_to book_path(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :ok, location: @book }
      else
        @books = Book.all
        flash[:notice] = "error"
        format.html { render :index }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    respond_to do |format|
      @book = Book.find(params[:id])
      if @book.update(book_params)
        format.html { redirect_to book_path(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        @books = Book.all
        flash.now[:notice] = 'error'
        format.html { render :index }
        format.json { render json: @books.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path, notice: "Book was successfully destroyed."
    else
      render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end