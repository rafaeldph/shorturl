class ShortUrlsController < ApplicationController
  def index
    @short_urls = ShortUrl.includes(:domain).order(created_at: :desc).limit(10)
  end

  def create
    @short_url = ShortUrl.find_or_create_by(params.require(:short_url).permit(:url))

    if @short_url.save
      render :show, status: :created, short_url: @short_url
    else
      render json: @short_url.errors, status: :unprocessable_entity
    end
  end

  def redirect
    short_url = ShortUrl.find_by_short_code(params[:short_code])

    if short_url
      short_url.increment!(:visits)
      redirect_to short_url.url
    end
  end
end