class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      resp.write cart_search(resp)

    elsif req.path.match(/add/)
      search_term = req.params["item"]

      resp.write cart_action(search_term)

    else
      resp.write "Path Not Found"

    end

    resp.finish
  end



  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def cart_search(resp)
    if @@cart.empty?
      return "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end

  end

  def cart_action(search_term)
    if @@items.include?(search_term)
      @@cart << search_term
      return "added #{search_term}"
    elsif !@@items.include?(search_term)
      return "We don't have that item"
    end

  end

end

# if !@@cart.include?(search_term) &&
