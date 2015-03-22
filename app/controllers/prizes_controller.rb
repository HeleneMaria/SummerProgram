class PrizesController < ApplicationController
  def update
     id = Prize.select(:id).where(reader_id: params[:id]).to_a #a simple where sends back a activerecord:relation instead of an activerecord
    @prize = Prize.find(id.first)
    @current_reader = Reader.find(@prize.reader_id)
      if @prize.update_attributes(prize_param)
      flash[:success] = "Reader updated !"
      redirect_to @current_reader
    else
      render @current_reader
    end
    
  end
  
    def prize_param
    params.require(:prize).permit(:level, :reader_id)
      end
end
