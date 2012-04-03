require 'test/unit'
require './application.rb'

class TC_Application < Test::Unit::TestCase
  def setup
    @obj = Application.new
  end

  def test_convert
    assert @obj.convert('test/sample.md')
  end

  def test_call
    file_name = "./files/file.md"
    f = File::open(file_name, "w")
    f.close

    response = @obj.call({"PATH_INFO" => "/path/file", "SCRIPT_NAME" => "/path"})
    assert_equal 200, response[0]

    File.delete(file_name)
  end
end
