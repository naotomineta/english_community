class MemosController < ApplicationController
  def index
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      redirect_to memos_path
    else
      render :new
    end
  end

  private

  def memo_params
    params.require(:memo).permit(:content, :translation).merge(user_id: current_user.id)
  end
end
