require File.expand_path('../lib/enterprise_time_extensions', File.dirname(__FILE__))
require 'test/unit'
require 'rubygems'
require 'shoulda'

require File.dirname(__FILE__) + '/freeze_time'

class EnterpriseTimeExtensionsTest < Test::Unit::TestCase

  context "on :next_sunday" do
    should "return a Time instance for the next Sunday at midnight" do
      Time.freeze(Time.local(2009, 1, 6)) do
        assert_equal Time.local(2009, 1, 11), Time.next_sunday
      end
    end
  end

  context "on :nth_wday" do
    should "return a Time instance for the 'nth' given weekday of the given month, in the given year" do
      # Third Monday of January, 2009
      assert_equal Time.local(2009, 1, 19), Time.nth_wday(3, 1, 1, 2009)
      # First Thursday of January, 2009
      assert_equal Time.local(2009, 1, 1), Time.nth_wday(1, 4, 1, 2009)
    end

    should "not allow an impossible value for the specified 'nth'" do
      assert_raise(ArgumentError) { Time.nth_wday(6, 1, 1, 2009) }
    end

    should "not allow an impossible value for the specified weekday" do
      assert_raise(ArgumentError) { Time.nth_wday(3, 45, 1, 2009) }
    end

    should "not allow an impossible value for the specified month" do
      assert_raise(ArgumentError) { Time.nth_wday(3, 1, 13, 2009) }
    end

    should "return nil if the day doesn't exist" do
      assert_nil Time.nth_wday(5, 0, 1, 2009)
    end
  end

  context "A Time instance" do

    context "on :after_hours?" do
      should "be true if not a weekday between 8AM and 6PM" do
        time = Time.local(2009, 1, 6, 23)
        assert time.after_hours?
      end

      should "be true if it's a holiday" do
        time = Time.local(2009, 1, 19)
        assert time.after_hours?
      end

      should "be false if it's a weekday between 8AM and 6PM" do
        time = Time.local(2009, 1, 6, 10)
        assert !time.after_hours?
      end
    end

    context "on :holiday?" do
      should "be true if it's a holiday" do
        time = Time.local(2009, 1, 19)
        assert time.holiday?
      end

      should "be false if it's not a holiday" do
        time = Time.local(2009, 1, 4)
        assert !time.holiday?
      end
    end

    context "on :new_years_day?" do
      should "be true if it's the first day of the year" do
        time = Time.local(2009,1,1)
        assert time.new_years_day?
      end
      should "be false if it's not the first day of the year" do
        time = Time.local(2009,1,2)
        assert !time.new_years_day?
      end
    end

    context "on :mlk_jr_day?" do
      should "be true if it's Martin Luther King, Jr. Day" do
        time = Time.local(2009, 1, 19)
        assert time.mlk_jr_day?
      end

      should "be false if it's not Martin Luther King, Jr. Day" do
        time = Time.local(2009, 1, 30)
        assert !time.mlk_jr_day?
      end
    end

    context "on :memorial_day" do
      should "be true if it is Memorial Day" do
        time = Time.local(2009, 5, 25)
        assert time.memorial_day?
        time = Time.local(2008, 5, 26)
        assert time.memorial_day?
      end

      should "be false if it's not Memorial Day" do
        time = Time.local(2009, 5, 26)
        assert !time.memorial_day?
      end
    end

    context "on :independence_day" do
      should "be true if it is July 4th" do
        time = Time.local(2009, 7, 4)
        assert time.independence_day?
      end

      should "be false if it's not July 4th" do
        time = Time.local(2009, 7, 5)
        assert !time.independence_day?
      end
    end

    context "on :labor_day?" do
      should "be true if it is Labor Day" do
        time = Time.local(2009, 9, 7)
        assert time.labor_day?
      end

      should "be false if it's not Labor Day" do
        time = Time.local(2009, 9, 12)
        assert !time.labor_day?
      end
    end

    context "on :thanksgiving?" do
      should "be true if it is Thanksgiving" do
        time = Time.local(2009, 11, 26)
        assert time.thanksgiving?
      end

      should "be false if it's not Thanksgiving" do
        time = Time.local(2009, 11, 30)
        assert !time.thanksgiving?
      end
    end

    context "on :christmas_day" do
      should "be true if it's Christmas Day" do
        time = Time.local(2009, 12, 25)
        assert time.christmas_day?
      end

      should "be false if it's not Christmas Day" do
        time = Time.local(2009, 12, 29)
        assert !time.christmas_day?
      end
    end

  end

end
