require "test_helper"

class ProjectUriNormalizerTest < ActiveSupport::TestCase
  test "normalizes an https git gem uri" do
    uri = "https://github.com/ideacrew/enroll.git"
    assert_equal("ideacrew/enroll", ProjectUriNormalizer.normalize(uri))
  end

  test "normalizes an https git repo uri" do
    uri = "https://github.com/ideacrew/enroll"
    assert_equal("ideacrew/enroll", ProjectUriNormalizer.normalize(uri))
  end

  test "normalizes a git repo project uri" do
    uri = "git@github.com:ideacrew/enroll.git"
    assert_equal("ideacrew/enroll", ProjectUriNormalizer.normalize(uri))
  end
end