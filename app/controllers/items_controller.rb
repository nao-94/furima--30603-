class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @item = Item.find(params[:item_id])
  end

  def new
    @item = Item.new
  end

  def create
  end

end
