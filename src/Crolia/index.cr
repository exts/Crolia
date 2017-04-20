module Crolia
    class Index
        include Crolia

        def initialize(@api : Api, @index : String)
        end

        # find all index items
        def find_all
            path = parse_url(api_path("index/list"), @api.api_id, true)
            api_response(Request.get(path, @api.headers()))
        end

        # todo
        def find_multiple(items = [] of Hash(String, String|Nil), strategy = "none")
        end

        def find_by(term, params = {} of String => String)
            # set query value (overwrite any params)
            params["query"] = term

            # generate proper url data
            opts = "?" + HTTP::Params.from_hash(params)

            path = parse_url(
                api_path("index/search", {"index" => @index}), 
                @api.api_id, 
                true
            ) + opts

            api_response(Request.get(path, @api.headers()))
        end
    end
end