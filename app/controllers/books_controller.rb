class BooksController < ApplicationController
   before_filter :signed_in_user
   
  def create
    @current_reader =  Reader.find(book_param[:reader_id])
    @book = @current_reader.books.build(book_param)
    if @book.save
      flash[:success] = "book created!"
      redirect_to @current_reader
     else
       render @current_reader
    end
  end
  
  def destroy
   @book = Book.find(params[:id])
    @current_reader = Reader.find(@book.reader_id)
   if  @book.destroy
      flash[:success] = "book deleted!"
      puts @current_reader.id
      redirect_to @current_reader
    end
  end
  
   def book_param
    params.require(:book).permit(:title, :reader_id)
      end
      
  private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end