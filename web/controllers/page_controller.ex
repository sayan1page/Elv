defmodule ArticleApi.PageController do
  use ArticleApi.Web, :controller
  
  @url "https://api.elevio-staging.com/v1/articles/"
  @token "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC5lbGV2aW8tc3RhZ2luZy5jb20iLCJzdWIiOiI1ZDE1MzY1OTE4NGVkIiwiZXhwIjozMTM4NDk4ODk4LCJpYXQiOjE1NjE2OTg4OTgsImp0aSI6ImFyZWE2cmc3NnFjajJjanZ0M29yaTE5MjIyYjdxMWVhIiwKICAidXNlck5hbWUiIDogInNheWFuX2pkcEB5YWhvby5jby5pbiIsCiAgInVzZXJJZCIgOiAxMzA0NiwKICAic2NvcGUiIDogWyAicmVhZDpjb250ZXh0dWFsIiwgIndyaXRlOmNvbnRleHR1YWwiLCAicmVhZDpjYXJkIiwgIndyaXRlOmNhcmQiLCAiYXBwcm92ZTphcnRpY2xlIiwgInJlYWQ6YXJ0aWNsZSIsICJ3cml0ZTphcnRpY2xlIiBdCn0.KEbdOAsLXGbzn__bSvuKbd1fKkgFjetrSlnrPRQjtfg"
  @headers ["x-api-key": "b69eb85cb9796f88861d100875c5df79", "Authorization": "Bearer #{@token}", "Accept": "Application/json"]
  
  def all(conn, _params) do
	HTTPoison.start
	case HTTPoison.get(@url, @headers) do
		{:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
			json conn, body
	end
  end
  
  def by_id(conn, %{"id" => id}) do
	url_id = @url <> id
	HTTPoison.start
	case HTTPoison.get(url_id, @headers) do
		{:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
			json conn, body
	end
  end
  
  def nohing(conn, params) do
  end
  
  
  def by_key(conn, params) do
	keys = params["keywords"]
	HTTPoison.start
	case HTTPoison.get(@url, @headers) do
		{:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
			obj = Jason.decode!(body)
			res = Enum.filter(obj["articles"], fn article -> Enum.any?(keys,&( Jason.encode!(article["title"]) =~ &1 || Jason.encode!(article["notes"]) =~ &1 || Jason.encode!(article["keywords"]) =~ &1)) end)
			json conn, body	
			
	end
  end
  
end
