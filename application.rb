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
    script_name = env["SCRIPT_NAME"]
    
    match = Regexp.new("^#{Regexp.quote(script_name).gsub('/','/+')}(.*)")
    m = match.match(path_info)

    rest = m[1]
    path = (!rest || rest.empty? || rest[0] == ?/) ? "index.md" : rest
    path = "./files/" + path

    if not path =~ /\.md$/ and File::exists? path
      path = path + ".md"
    end

    if File::exists? path
      [200, {"Content-Type" => "text/html"}, [convert(path)]]
    else
      [404, {"Content-Type" => "text/html"}, [File::read("public/404.html")]]
    end
  end
end
