class ApplicationController < ActionController::Base
  def render_not_found
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end
end
