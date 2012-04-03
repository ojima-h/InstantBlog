require 'bluefeather'

class Application
  def convert(filename)
    content = BlueFeather.parse_document_file(filename)
    content.gsub(/\[\[([^\[\]]+)\]\]/) do |m|
      "<a href=#{$1 + ".md"}>#{$1}</a>"
    end
  end

  def call(env)
    path_info = env["PATH_INFO"]

    path = "./files/" + (path_info == "/" ? "index.md" : path_info)
    path.gsub!(%r{/+}, '/')

    if not (path =~ /\.md$/ or File.exists?(path))
      path = path + ".md"
    end

    if File::exists? path
      [200, {"Content-Type" => "text/html"}, [convert(path)]]
    else
      [404, {"Content-Type" => "text/html"}, [File.read("public/404.html")]]
    end
  end
end
