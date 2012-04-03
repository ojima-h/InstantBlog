require 'test/unit'
require './application.rb'

class TC_Application < Test::Unit::TestCase
  def setup
    @obj = Application.new
  end

  def test_convert
    assert @obj.convert('test/sample.md')
  end
end
