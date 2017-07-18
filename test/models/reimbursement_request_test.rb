require 'test_helper'

class ReimbursementRequestTest < ActiveSupport::TestCase
  setup do
    @form = reimbursement_requests(:one)
  end

  test "should have id of 0" do
    assert_same reimbursement_requests(:one).id, 0
  end

  test "should have accountings" do
    assert_not_empty @form.accountings
  end
 
  test "totals should not return nil" do
    assert_not_nil @form.totals
  end

  test "individual totals should not be nil" do
    @form.totals.each do |total|
      assert_not_nil total
    end
  end

  test "calling set_totals should change grand total" do
    old_grand_total = @form.grand_total
    @form.calculate_grand_total
    assert_not_equal @form.grand_total, old_grand_total
  end

  test "calling set_totals should change individual totals" do
    old_totals = @form.totals
    @form.calculate_grand_total
    (0..4).each { |index| assert_not_equal @form.totals[index], old_totals[index], "Total at index #{index} is equal" }
  end
end
