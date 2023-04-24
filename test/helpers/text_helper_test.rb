require 'test_helper'

class TextHelperTest < ActionView::TestCase
  test "#replace_space_with_comma" do
    string = "asd@asd.asd   qwe@qwe.qwe, fgh@fgh.gfh "
    result = "asd@asd.asd,qwe@qwe.qwe,fgh@fgh.gfh"
    assert_equal result, replace_space_with_comma(string)
  end
end
