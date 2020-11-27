class MemosController < ApplicationController
  def index
    @memos = Memo.all.order(id: 'DESC')
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

  def edit
    @memo = Memo.find(params[:id])
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      redirect_to memos_path
    else
      render :edit
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to action: :index
  end

  private

  def memo_params
    params.require(:memo).permit(:content, :translation).merge(user_id: current_user.id)
  end
end
