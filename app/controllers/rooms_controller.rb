class RoomsController < ApplicationController
  before_action :search_room, only: [:index, :search]
  before_action :authenticate_user!, except: [:index]

  def index
    @rooms = Room.all.order(id: 'DESC')
    set_room_column
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @memos = Memo.all.order(id: 'DESC')
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result
  end

  private

  def room_params
    params.require(:room).permit(:title, :content, :toeic_id).merge(user_id: current_user.id)
  end

  def search_room
    @p = Room.ransack(params[:q])
  end

  def set_room_column
    @toeic = Room.select('toeic_id').distinct
  end
end
