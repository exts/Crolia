require "http/client"
require "http/client/response"
require "http/headers"
require "http/params"
require "json"

require "./Crolia/*"
require "./Crolia/exceptions/*"

module Crolia
  extend self

  include Exceptions

  # api endpoint url
  ENDPOINT_URL = "https://[APPID][DSN].algolia.net/"

  # hash of api pathes
  PATHS = {
    "index/list" => "/1/indexes",
    "index/search" => "/1/indexes/[index]",
    "index/search/query" => "/1/indexes/[index]/query",
    "index/search/queries" => "/1/indexes/*/queries",
    "objects/delete" => "/1/indexes/[index]/[id]",
    "objects/read" => "/1/indexes/[index]/[id]",
    "objects/read/many" => "/1/indexes/*/objects",
    "objects/insert" => "/1/indexes/[index]",
    "objects/update" => "/1/indexes/[index]/[id]",
    "objects/update/partial" => "/1/indexes/[index]/[id]/partial"
  }

  # used to parse our end point path's to the rest api url
  def parse_url(path, api_id, dsn = false)
    current = ENDPOINT_URL.gsub("[APPID]", api_id)
    current = current.gsub("[DSN]", if dsn == true "-dsn" else "" end)
    current + path.lchop("/").rchop("/")
  end

  # used to parse a full api path based on our hash path keys
  def api_path(index, opts = {} of String => String)
    # path doesn't exist so exception out
    raise InvalidApiPath.new("Invalid Path Index") if !PATHS.has_key?(index)

    path = PATHS[index]

    # loop through options and replace blocks from path
    opts.each do |k, v|
      path = path.gsub("[" + k + "]", v)
    end

    path
  end

  # create Algolia::Response object based on the response data recieved 
  def api_response(response : HTTP::Client::Response)
      Response.new JSON.parse(response.body.strip()), response
  end

end
