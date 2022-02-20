class ShortUrlsController < ApplicationController
  def index
    @short_urls = ShortUrl.all
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
end