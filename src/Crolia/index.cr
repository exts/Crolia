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

        # find multiple search indexes
        def find_multiple(items = [] of Hash(String, String|Nil), strategy = "none")

            items.each_index do |k|
                items[k]["indexName"] = @index
            end

            data = {"requests" => items, "strategy" => strategy}
            
            path = parse_url(api_path("index/search/queries"), @api.api_id, true)
            response = Request.post(path, @api.headers(), data.to_json)
            api_response(response)
        end

        # search index by query term with optional parameters
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