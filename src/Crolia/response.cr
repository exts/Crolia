module Crolia
    class Response
        getter data : JSON::Any
        getter response : HTTP::Client::Response

        def initialize(@data, @response)
        end
    end
end