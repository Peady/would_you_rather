require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: 'Chris', email: 'whicheverpeady@gmail.com', password: '123456', password_confirmation: '123456')
  end
  
  test "instance of user should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = ''
    assert_not @user.valid?
  end
  
  test "email should not be blank " do
    @user.email = ''
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test "email should accept valid addresses" do
    addresses = %w[ snappy@yahoo.com bones@swiss.com hallelujah@godaddy.com]
    addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should reject invalid address" do
    addresses = %w[ harryg@blendin,org jackandjill69@@@crazy nast@s+)*.com]
    addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

end
