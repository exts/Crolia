module Crolia
    class Request
        # send get request
        def self.get(path, headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType = nil) : HTTP::Client::Response
            HTTP::Client.get(path, headers, body)
        end

        # send post request
        def self.post(path, headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType = nil) : HTTP::Client::Response
            HTTP::Client.post(path, headers, body)
        end

        # send put request
        def self.put(path, headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType = nil) : HTTP::Client::Response
            HTTP::Client.put(path, headers, body)
        end

        # send put request
        def self.delete(path, headers : HTTP::Headers? = nil, body : HTTP::Client::BodyType = nil) : HTTP::Client::Response
            HTTP::Client.delete(path, headers, body)
        end
    end
end