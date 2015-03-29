class ReadersController < ApplicationController
  before_filter :signed_in_user
  
  
  def destroy
    Reader.find(params[:id]).destroy
    flash[:success] = "Reader deleted !"
    redirect_to readers_path
  end
  
  def index
    if params[:schoolFallName] or params[:schoolFallGrade] or params[:prize]
      @readers = Reader.search2(params[:schoolFallName] , params[:schoolFallGrade])
      if @readers !=nil
        @readers = @readers.paginate(:page => params[:page], :per_page => 10)
      end
    elsif params[:search]
    @readers = Reader.search1(params[:search])
    @readers = @readers.paginate(:page => params[:page], :per_page => 10)
    else
      @readers = Reader.all
      @readers = @readers.paginate(:page => params[:page], :per_page => 10)
    end
  end
  
 def edit
    @reader = Reader.find(params[:id])
    @schools = Reader.select(:schoolFallName).distinct
    @programs = ["Baby program","Kids program", "Pre-Teen program", "Teen program"]
    @grade = ["None","Pre-School","Pre-Kindergarten","Kindergarten","1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th"]
    @size = ["Youth Small","Youth Medium","Youth Large","Adult Small","Adult Medium","Adult Large","Adult X-Large","Adult 2 X-Large","Adult 3 X-Large"]
  end
  
  def update
    @reader = Reader.find(params[:id])
    if @reader.update_attributes(reader_param)
      if @reader.newSchoolFallName != ""
        @reader.schoolFallName =@reader.newSchoolFallName
        @reader.newSchoolFallName=nil
        @reader.save
      end
      flash[:success] = "Reader updated !"
      redirect_to @reader
    else
      render 'edit'
    end
  end
  
  def show
    @reader = Reader.find(params[:id])
    @book = @reader.books.build
    id = Prize.select(:id).where(reader_id: params[:id]).to_a #a simple where sends back a activerecord:relation instead of an activerecord
    @prize = Prize.find(id.first)
  end
  
  def create
    @reader = Reader.new(reader_param)
    if @reader.newSchoolFallName != ""
        puts "if @reader.newSchoolFallName"
      @reader.schoolFallName =@reader.newSchoolFallName
      @reader.newSchoolFallName=nil
      
    end
    if @reader.save
      @prize = Prize.new(level:0,reader_id:@reader.id)
      @prize.save
      flash[:success] = "New reader added"
      redirect_to @reader
    else
      render 'new'
    end
  end
  
  def new
   @reader = Reader.new
   @schools = Reader.select(:schoolFallName).distinct
   @programs = ["Baby program","Kids program", "Pre-Teen program", "Teen program"]
       @grade = ["None","Pre-School","Pre-Kindergarten","Kindergarten","1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th"]
    @size = ["Youth Small","Youth Medium","Youth Large","Adult Small","Adult Medium","Adult Large","Adult X-Large","Adult 2 X-Large","Adult 3 X-Large"]
  end
  
  def reader_param
    params.require(:reader).permit(:firstName, :lastName, :phoneNumber, :email, :schoolFallName, :schoolFallGrade, :program, :age, :tShirtSize, :newSchoolFallName, :books, :prize, :notes)
  end
  
  
  private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
end
