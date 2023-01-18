module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :notfound

    private
  
    def notfound(exception)
      logger.warn exception # not requiered
      render file: 'public/404.html', status: :not_found, layout: false # layout give file himself without additional stuff
    end
  end
end
