class Public::HomesController < ApplicationController
  def top
    @items = Item.latest.limit(4)
    @genres = Genre.all
  end

  def about
  end
end
