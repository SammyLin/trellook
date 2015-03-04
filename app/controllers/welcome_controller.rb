class WelcomeController < ApplicationController
  def index

  end

  def get_notifications
    trello = Trello::Client.new(Figaro.env.trello_key, params[:token])

    render :json => trello.notifications
  end
end
