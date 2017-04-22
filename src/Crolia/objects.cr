module Crolia
    class Objects
        include Crolia
        def initialize(@api : Api, @index : String)
        end

        # search for an object by id w/ optional attributes
        def find(id : String, attr = {} of String => String)
            path = parse_url(api_path("objects/read", {"index" => @index, "id" => id}), @api.api_id, true)
            path = path + "?" + HTTP::Params.encode(attr) if !attr.empty?

            api_response(Request.get(path, @api.headers()))
        end

        # search many objects
        def find_all(items = [] of Hash(String, String))

            # append indexName
            items.each_index do |k|
                items[k]["indexName"] = @index
            end

            request = {"requests" => items}

            path = parse_url(api_path("objects/read/many"), @api.api_id, true)
            api_response(Request.post(path, @api.headers(), request.to_json))
        end

        # update an object by id or insert one without
        def add_or_update(data : String, id : String|Nil = nil)
            path = parse_insert_path(id)

            if id.nil?
                response = Request.post(path, @api.headers(), data)
            else
                response = Request.put(path, @api.headers(), data)
            end

            api_response(response)
        end

        # partial update object field
        def partial_update(id : String, data : String, create_if_not_exists = false)
            path = parse_url(api_path("objects/update/partial", {"index" => @index, "id" => id}), @api.api_id, false)
            path = path + "?createIfNotExists=" + if(create_if_not_exists) "true" else "false" end

            response = Request.post(path, @api.headers(), data)
            api_response(response)
        end

        # delete object by id
        def delete(id : String)
            path = parse_url(api_path("objects/delete", {"index" => @index, "id" => id}), @api.api_id)
            response = Request.delete(path, @api.headers())
            api_response(response)
        end

        # parses the insert path based on if we provide an id or not
        private def parse_insert_path(id : String|Nil = nil)
            path_opts = {"index" => @index}
            path_opts["id"] = id if !id.nil?

            path_key = if id.nil? "objects/insert" else "objects/update" end
            parse_url(api_path(path_key, path_opts), @api.api_id, false)
        end
    end
end