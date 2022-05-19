class Public::HomesController < ApplicationController
  def top
    @items = Item.latest.limit(4)
  end

  def about
  end
end
