module Trello
  class Client
    def initialize(key, token)
      @key = key
      @token = token
    end

    def boards
      uri = URI.parse("https://api.trello.com/1/members/me/boards")
      args = {key: @key, token: @token}
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      JSON.parse(response.body.force_encoding("UTF-8"))
    end
#commentCard
    def actions_with_board(board_id, filter = nil)
      uri = URI.parse("https://api.trello.com/1/boards/#{board_id}/actions")
      args = {key: @key, token: @token, filter: filter}
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      json = JSON.parse(response.body.force_encoding("UTF-8"))
    end

    def all_action(filter = nil)
      actions = []
      boards.map do |board|
        actions.concat actions_with_board(board['id'], 'commentCard')
      end
      actions
    end

    def notifications
      uri = URI.parse("https://api.trello.com/1/members/me/notifications")
      args = {:key => @key, :token => @token, :filter => 'mentionedOnCard,commentCard'}
      uri.query = URI.encode_www_form(args)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri.request_uri)

      response = http.request(request)
      if response.code == '200'
        json = JSON.parse(response.body.force_encoding("UTF-8"))
        json.map do |notification|
          action = Action.find_or_create_by(:action_id => notification['id'])
          notification['trello_read'] = action.read_state
        end
        json
      else
        raise 'expired token'
      end
    end

  end
end