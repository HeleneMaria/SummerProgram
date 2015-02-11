class ReadersController < ApplicationController
  
  def destroy
    Reader.find(params[:id]).destroy
    flash[:success] = "Reader deleted !"
    redirect_to readers_path
  end
  
  def index
    @readers=Reader.paginate(page: params[:page])
  end
  
 def edit
    @reader = Reader.find(params[:id])
  end
  
  def update
    @reader = Reader.find(params[:id])
    if @reader.update_attributes(reader_param)
      flash[:success] = "Reader updated !"
      redirect_to @reader
    else
      render 'edit'
    end
  end
  
  def show
    @reader = Reader.find(params[:id])
  end
  
  def create
    @reader = Reader.new(reader_param)
    if @reader.save
      flash[:success] = "New reader added"
      redirect_to @reader
    else
      render 'new'
    end
  end
  
  def new
   @reader = Reader.new
  end
  
  def reader_param
    params.require(:reader).permit(:firstName, :lastName, :phoneNumber, :email, :schoolFallName, :schoolFallGrade, :program)
  end
end
