module ApplicationHelper

  def dev_safe_url(url)
    if url.index("system/") == 0 then return "/"+url else return url end
  end

end
