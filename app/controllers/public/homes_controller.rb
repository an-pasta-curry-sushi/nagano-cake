class Public::HomesController < Public::ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]

  def top
    @items = Item.latest.limit(4)
    @genres = Genre.all
    month_order_detail = OrderDetail.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
    @month_rank_items = Item.find(month_order_detail.group(:item_id).order('count(item_id) desc').limit(4).pluck(:item_id))
  end

  def about
  end
end
