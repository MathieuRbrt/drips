require 'test_helper'

class PostTest < ActiveSupport::TestCase

	test "post should include a picture" do
		post = Post.new
		assert !post.save
		assert !post.errors[:picture].empty?
	end

	test "post should include a location" do
		post = Post.new
		assert !post.save
		assert !post.errors[:location].empty?
	end

	test "post should belong to a user" do
		post = Post.new
		assert !post.save
		assert !post.errors[:user_id].empty?
	end


end
