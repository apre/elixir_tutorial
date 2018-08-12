defmodule PhotomapWeb.TilesController do
    use PhotomapWeb, :controller
    require Logger
   
    
    @doc ~S"""
            Split a string to with "." as separator

            ## Examples

            iex> PhotomapWeb.TilesController.split_extention("abcd.png")
            {:ok, {"abcd", "png"}}

            iex> PhotomapWeb.TilesController.split_extention("XXXX")
            {:ok, {"xxxx"}}            

    """ 
    def split_extention(filenameToSplit) do
        String.split(filenameToSplit,".")
    end


    defp cache_state(c) do
        #Logger.debug "cache_state: #{inspect(c)}"
        case c do
            :ok ->"OK"
            :error -> "error"
            {:error, :no_cache} -> "no cache error"
            _->"UNKNOWN ERROR"
        end
    end

    defp makeTileFileName(params) do
        storageDir = "/tmp/tiles"
        storageDir = Path.join storageDir, params["imageIdent"]
        storageDir = Path.join storageDir, params["zoom"]
        storageDir = Path.join storageDir, params["xcoord"]

        {storageDir,params["ycoord"]}
    end


    @doc ~S"""
        Saves into cache-directory the content as a binary array

    """
    def saveTile(rootdir, filename, content) do
        
        if File.dir?(rootdir) == false do
            File.mkdir_p(rootdir)
        end
        
        fullFilename = Path.join(rootdir,filename)

        
        #File.write(fullFilename,content)

        {:ok, file} = File.open fullFilename, [:write]
        write_result = IO.binwrite file, content
        File.close file

        
        #Logger.debug "save filename [#{fullFilename}]" 
        {write_result,fullFilename}
    end

    @doc"""
    Fetch the tile from OSM and save it to cache.
    return file name
    """
    def fetchFromOsm(params, tile_key, rootdir,filename) do
        full_url = "https://" <>params["subMachine"]<>".tile.openstreetmap.org/"<>params["zoom"]<>"/"<>params["xcoord"]<>"/" <>params["ycoord"]
         
        Logger.info "downloading #{full_url}"
        case HTTPoison.get(full_url, [], hackney: [pool: :osm_pool, recv_timeout: 60000]) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                
                case  saveTile(rootdir,filename,body) do
                    {:ok,savedFileName} ->   Cachex.set(:tile_cache,tile_key,savedFileName)
                                        Logger.debug "saved into  #{full_url} into  #{filename} "
                           _ -> Logger.debug "ERROR while saving into  #{full_url} into  key #{tile_key} "
                           cachedTileName = "/tmp/blank.png"
                end
               
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                Logger.debug "not found #{full_url}"
                cachedTileName = "/tmp/blank.png"
            {:error, %HTTPoison.Error{reason: reason}} ->
                Logger.debug "not found #{reason}" 
                cachedTileName = "/tmp/blank.png"
          end        


    end


    def fetch(conn, params) do
        #Logger.debug "TilesController:fetch: #{inspect(params)}"
        

        splited = split_extention(params["ycoord"])
        y = Enum.at(splited,0)
        extention = Enum.at(splited,1)

        
         
        tile_key = params["imageIdent"]<>"/"<>params["zoom"] <>"/" <>params["xcoord"]  <>"/"<>params["ycoord"]

        #Logger.debug "TilesController:fetch: #{tile_key}"

        logMessage =  "Ident: [" <> params["imageIdent"] <>"] "<>
        "srv: [" <> params["subMachine"] <>"] "<>
        "Z: [" <> params["zoom"] <>"] "<>
        "X: [" <> params["xcoord"] <>"] "<>
        "Y: [" <> y<>"] "<>
        "ext: [" <> extention  <>"] <br/> ["<>tile_key <>"] "

        charlit_titlekey = to_charlist(tile_key)

        {rootdir , fname } = makeTileFileName(params);
        #Logger.debug "rootdir : #{rootdir}"
        #Logger.debug "fname : #{fname}"
        
        cachedTileName = "/tmp/blank.png"
        cachedTileName = Path.join(rootdir,fname)
        
        dataToSend = ""

        needToFetch =false

        case Cachex.get(:tile_cache,tile_key) do
            {:ok, nil} -> needToFetch =  (false ==File.exists?( cachedTileName))
            #Logger.debug "got nil from map #{tile_key}, fetch: #{needToFetch}"
            if needToFetch == true do
                fetchFromOsm(params,tile_key,rootdir,fname)
            else
                Cachex.set(:tile_cache,tile_key,cachedTileName)
            end
  
            {:ok, filename}   ->
                cachedTileName = filename
                needToFetch = false
                #Logger.debug "got file  #{filename} from map #{tile_key}, fetch: #{needToFetch}"
            _ -> needToFetch = true
        end

        #Logger.debug "now we should fetch   #{needToFetch} to #{rootdir} / #{fname}"
       
        

        #c = Cachex.get(:tile_cache,tile_key)

        conn
        |> put_resp_content_type("image/png")
        |> send_download {:file, cachedTileName}
           
        end
        
   
  end