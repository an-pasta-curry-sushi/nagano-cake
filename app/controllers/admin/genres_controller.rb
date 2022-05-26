class Admin::GenresController < Admin::ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルを追加しました"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました"
    else
      render "edit"
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
