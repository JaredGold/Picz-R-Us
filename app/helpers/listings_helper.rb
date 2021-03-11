module ListingsHelper

  def generate_tag(url) 
    url.split('/')[-1]
  end

end
