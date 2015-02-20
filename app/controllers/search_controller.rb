class SearchController < ApplicationController
  
  def search
    puts"controller search--------------------------------"
    if params[:name] #comes from home or search
      put "#comes from home or search"
      if params[:schoolFallName] or params[:schoolFallGrade] or params[:prize] #comes from search
        puts "#comes from search"
         @readers = Reader.search2(params[:name],params[:schoolFallName] , params[:schoolFallGrade] ,params[:prize])
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
end
