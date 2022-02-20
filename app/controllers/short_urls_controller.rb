class ShortUrlsController < ApplicationController
  def index
    @short_urls = ShortUrl.includes(:domain).order(created_at: :desc).limit(10)
  end

  def show
    @short_url = ShortUrl.find(params[:id])
  end

  def create
    @short_url = ShortUrl.new(params.require(:short_url).permit(:domain_id, :url))

    respond_to do |format|
      if @short_url.save
        format.html { redirect_to short_url_url(@short_url), notice: "Short url was successfully created." }
        format.json { render :show, status: :created, location: @short_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
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