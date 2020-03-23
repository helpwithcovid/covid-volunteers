class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  def set_filters_open
    @filters_open = case cookies['filters_open']
                    when 'nil'
                    when true
                    when 'true'
                      true
                    when false
                    when 'false'
                      false
                    else
                      true
                    end
  end
end
