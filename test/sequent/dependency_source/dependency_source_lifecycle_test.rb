class DependencySourceLifecycleTest < ActiveSupport::TestCase
  test "creates a dependency source" do
    command = CreateDependencySource.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk")
    Sequent.command_service.execute_commands command

    record = DependencySourceRecord.where({aggregate_id: command.aggregate_id}).first
    assert_not_nil(record)
  end

  test "creates a dependency source with dependency branches" do
    command = CreateDependencySource.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk")
    Sequent.command_service.execute_commands command

    branch_command = AddDependencySourceBranch.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk", "1387412341234abcde")
    Sequent.command_service.execute_commands branch_command

    branch_record = DependencySourceBranchRecord.where({dependency_source_record_aggregate_id: command.aggregate_id}).first
    assert_not_nil(branch_record)
  end

  test "updates a dependency source branch with a new version" do
    command = CreateDependencySource.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk")
    Sequent.command_service.execute_commands command

    branch_command = AddDependencySourceBranch.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk", "1387412341234abcde")
    Sequent.command_service.execute_commands branch_command

    branch_update_command = AddDependencySourceBranch.create("enroll", "git@github.com:ideacrew/enroll.git", "trunk", "234update")
    Sequent.command_service.execute_commands branch_update_command

    branch_record = DependencySourceBranchRecord.where({dependency_source_record_aggregate_id: command.aggregate_id}).first

    assert_equal(branch_record.head, "234update")
  end
end