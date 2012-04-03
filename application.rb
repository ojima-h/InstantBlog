require 'rdiscount'

class Application
  def convert(filename)
    content = File::read(filename)
    rd = RDiscount.new(content, :smart)
    return rd.to_html
  end

  def call(env)
    path = "./files" + env["PATH_INFO"]

    if not path =~ /\.md$/ and File::exists? path
      path = path + ".md"
    end

    p path

    if File::exists? path
      [200, {"Content-Type" => "text/html"}, [convert(path)]]
    else
      [404, {"Content-Type" => "text/html"}, [File::read("404.html")]]
    end
  end
end
