require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test "a user should enter a profile name" do
        user = User.new
        assert !user.save
        assert !user.errors[:profile_name].empty?
    end

    test "a user should enter a email" do
        user = User.new
        assert !user.save
        assert !user.errors[:email].empty?
    end

    test "a user should have a unique profile name" do
        user = User.new
        user.profile_name = users(:mathieu).profile_name
        assert !user.save
        assert !user.errors[:profile_name].empty?
    end

    test "a user should have a profile name without spaces" do
        user = User.new
        user.profile_name = "My Profile With Spaces"
        assert !user.save
        assert !user.errors[:profile_name].empty?
        assert user.errors[:profile_name].include?("Must be formatted correctly.")
    end
end