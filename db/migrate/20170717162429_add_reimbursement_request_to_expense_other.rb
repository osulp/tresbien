class AddReimbursementRequestToExpenseOther < ActiveRecord::Migration[5.1]
  def change
    add_reference :expense_others, :reimbursement_request, foreign_key: true
  end
end
