require "test_helper"

class RubyConstraintVersionTest < ActiveSupport::TestCase
  test "reads an exact constraint version" do
    version_string = "2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000003")
    assert_equal(result.max_version, "000002.000001.000003")
  end

  test "reads a two point constraint version" do
    version_string = "2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000000")
    assert_equal(result.max_version, "000002.000001.999999")
  end

  test "reads a one point constraint version" do
    version_string = "2"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000000.000000")
    assert_equal(result.max_version, "000002.999999.999999")
  end

  test "reads an three point ~> constraint version" do
    version_string = "~> 2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000003")
    assert_equal(result.max_version, "000002.000001.999999")
  end

  test "reads a two point ~> constraint version" do
    version_string = "~>2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000000")
    assert_equal(result.max_version, "000002.999999.999999")
  end

  test "reads an exact >= constraint version" do
    version_string = ">= 2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000003")
    assert_nil(result.max_version)
  end

  test "reads a two point >= constraint version" do
    version_string = ">= 2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000000")
    assert_nil(result.max_version)
  end

  test "reads a one point >= constraint version" do
    version_string = ">= 2"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000000.000000")
    assert_nil(result.max_version)
  end

  test "reads an exact <= constraint version" do
    version_string = "<= 2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000001.000003")
  end

  test "reads a two point <= constraint version" do
    version_string = "<= 2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000001.000000")
  end

  test "reads a one point <= constraint version" do
    version_string = "<= 2"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000000.000000")
  end

  test "reads an exact > constraint version" do
    version_string = "> 2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000001.000004")
    assert_nil(result.max_version)
  end

  test "reads a two point > constraint version" do
    version_string = "> 2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000002.000002.000000")
    assert_nil(result.max_version)
  end

  test "reads a one point > constraint version" do
    version_string = "> 2"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_equal(result.min_version, "000003.000000.000000")
    assert_nil(result.max_version)
  end

  test "reads an exact < constraint version" do
    version_string = "< 2.1.3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000001.000002")
  end

  test "reads an exact < constraint on boundary 1 version" do
    version_string = "< 2.1.0"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000000.999999")
  end

  test "reads an exact < constraint on boundary 2 version" do
    version_string = "< 2.0.0"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000001.999999.999999")
  end

  test "reads a two point < constraint version on the boundary" do
    version_string = "< 2.0"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000001.999999.999999")
  end

  test "reads a two point < constraint version" do
    version_string = "< 2.1"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.000000.999999")
  end

  test "reads a one point < constraint version" do
    version_string = "< 3"
    result = RubyConstraintVersion.from_constraint_string(version_string)
    assert_nil(result.min_version)
    assert_equal(result.max_version, "000002.999999.999999")
  end
end