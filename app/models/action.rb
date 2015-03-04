class Action < ActiveRecord::Base
  def self.find_action(action_id)
    uri = URI.parse("https://api.trello.com/1/boards/#{action_id}/actions")
    args = {key: '367f978a6bc9b788cb4cd90fb3bfb4c7', token: '94110df10cb6f575fda7c5aaf3639ce988df1242c7e9c4554480e3f508aacad4', filter: 'commentCard'}
    uri.query = URI.encode_www_form(args)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    json = JSON.parse(response.body.force_encoding("UTF-8"))
    json
  end
end
