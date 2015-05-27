class SearchController < ApplicationController
   before_filter :signed_in_user
   
  def search
    @programs = ["","Baby program","Kids program", "Pre-Teen program", "Teen program"]
    puts"controller search--------------------------------"
    if params[:name] #comes from home or search
      if params[:schoolFallName] or params[:schoolFallGrade] or params[:program] #comes from search
        puts "#comes from search"
         @readers = Reader.search2(params[:name],params[:schoolFallName] , params[:schoolFallGrade],params[:program])
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
    if params[:schoolFallName] or params[:schoolFallGrade] or params[:name] or params[:program] 
      @readers = Reader.search2(params[:name],params[:schoolFallName] , params[:schoolFallGrade],params[:program])
      
          else
      @readers = Reader.all
    end
    
    respond_to do |format|
      format.html
      format.csv { send_data @readers.as_csv_books }
      format.xls { send_data @readers.as_csv_books(col_sep: "\t")  }
    end
  end
  
  def deleteAll
    Prize.delete_all()
    Book.delete_all()
    Reader.delete_all()
    redirect_to searchReaders_path
  end
  
  private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end
  
end

