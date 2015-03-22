class SearchController < ApplicationController
   before_filter :signed_in_user
   
  def search
    puts"controller search--------------------------------"
    if params[:name] #comes from home or search
      puts "#comes from home or search"
      if params[:schoolFallName] or params[:schoolFallGrade] #comes from search
        puts "#comes from search"
         @readers = Reader.search2(params[:name],params[:schoolFallName] , params[:schoolFallGrade])
        if @readers !=nil
          @readers = @readers.paginate(:page => params[:page], :per_page => 10)
        end
        puts "from Search"
      else #comes from home
      @readers = Reader.search1(params[:name])
        @readers = @readers.paginate(:page => params[:page], :per_page => 10)
         puts "from Home"
       end
     else #no param
       @readers = Reader.all
       @readers = @readers.paginate(:page => params[:page], :per_page => 10)
    puts "no param"
  end
    
    
  end
  
  
  def exportAll
    puts"controller search--------------------------------"
    if params[:schoolFallName] or params[:schoolFallGrade] or params[:name]  
      @readers = Reader.search2(params[:name],params[:schoolFallName] , params[:schoolFallGrade])
     csv = @readers.as_csv_books
      
          else
      @readers = Reader.all
      csv = @readers.as_csv_books
    end
    
    respond_to do |format|
      format.html
      format.csv { send_data csv }
      format.xls { send_data csv }
    end
  end
  
  private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
  
end

