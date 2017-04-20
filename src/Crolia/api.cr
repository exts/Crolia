module Crolia
  class Api
    getter api_id : String
    getter api_key : String

    # initiate a new angolia api project
    def initialize(@api_key : String, @api_id : String)
      raise Exception.new("Application ID & Key is required") if @api_key.nil? || @api_id.nil?
    end

    # used to pass api authentication data headers to api request
    def headers : HTTP::Headers
      headers = HTTP::Headers.new
      headers.add("X-Algolia-API-Key", @api_key)
      headers.add("X-Algolia-Application-Id", @api_id)
      headers
    end

    def index(index : String)
        Index.new self, index
    end

    def objects(index : String)
        Objects.new self, index
    end
  end
end