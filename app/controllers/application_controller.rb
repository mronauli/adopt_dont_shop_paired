class ApplicationController < ActionController::Base

    def favorite
        @favorite ||= Favorite.new(session[:favorite])
    end
end
