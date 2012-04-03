require 'bluefeather'

class Application
  def convert(filename)
    content = BlueFeather.parse_document_file(filename)
    content.gsub(/\[\[([^\[\]]+)\]\]/) do |m|
      "<a href=#{$1 + ".md"}>#{$1}</a>"
    end
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
