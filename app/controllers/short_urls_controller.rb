class ShortUrlsController < ApplicationController
  def index
    if params[:format] == 'json'
      domains = params[:domains].to_s.split(',').map(&:to_i).join(',')
      unless domains.blank?
        filter = "short_urls.domain_id IN (#{domains})"
      end

      @limit = 10

      @total = ShortUrl.where(filter).count
      @page = params[:page].to_i
      @page = 1 if @page > @total || @page < 1
      @last_page = (@total.to_f / @limit.to_f).ceil

      @short_urls = ShortUrl.includes(:domain).where(filter).order(created_at: :desc).limit(@limit).offset((@page - 1) * @limit)
    end
  end
  
  def domains
    ids = ShortUrl.select('domain_id, COUNT(*) AS total').group(:domain_id).order('total DESC').collect(&:domain_id)
    @domains = Domain.where("url ILIKE ?", "%#{params[:url]}%").sort_by {|d| ids.index(d.id) || (2**(0.size * 8 -2) -1) }.take(5)

    render json: @domains.to_json(except: [:created_at, :updated_at])
  end

  def create
    @short_url = ShortUrl.find_or_create_by(params.require(:short_url).permit(:url))

    if @short_url.save
      render :show, status: :created, short_url: @short_url
    else
      render json: { error: "El texto debe ser una URL válida" }, status: :unprocessable_entity
    end
  end

  def redirect
    short_url = ShortUrl.find_by_short_code(params[:short_code])

    if short_url
      short_url.increment!(:visits)
      redirect_to short_url.url
    else
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end
  end
end