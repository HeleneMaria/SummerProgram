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
      #@readers = Reader.find_by_sql"select id, firstName, lastname from readers where firstname = 'first'"
      #@readers = Reader.select("id, firstName, lastName, phoneNumber, email, schoolFallName, schoolFallGrade, program, age, tShirtSize").where("\"lastName\" like 'first' or \"firstName\" like 'first'")
     #transform the sql query to a CSV
      #csv = CsvExport.new(@readers,[:id, :firstName, :lastName, :phoneNumber, :email, :schoolFallName, :schoolFallGrade, :program, :age, :tShirtSize]).generate
      
     # csv = @readers.as_csv(["id","firstName","lastName","phoneNumber","email","schoolFallName","schoolFallGrade","program","age","tShirtSize","prize"])
     csv = @readers.as_csv_books
      puts @readers.as_csv_all
      
          else
      @readers = Reader.all
      csv = @readers.as_csv_all
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

class CsvExport
  def initialize(collection, attributes=[])
    @collection, @attributes = collection, attributes
  end

  def generate
    CSV.generate do |csv|
      csv << attributes.map(&:to_s)
      @collection.each do |record|
        csv << record.attributes.values_at(*@attributes)
        puts record
      end
    end
  end
end
