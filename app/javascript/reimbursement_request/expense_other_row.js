import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';
import BasicRow from './basic_row';

class ExpenseOtherRow extends BasicRow {
  constructor(form, element, state) {
    super(form, element, state);
    extendObservable(this, {
      row_total: 0,
      account_code: ''
    });
    this.setAccountCode(this.element.find('.expense-type'));
    this.bindExpenseTypeSelect(this.element.find('.expense-type'));
    this.bindRowSumInput(this.element.find('.row-sum-input'));
    this.bindRemove(this.element.find('.remove_fields'));
  }

  bindRowSumInput = input => {
    $(input).on('keyup change', e => {
      //let row_sum_input = this.element.find('.row-sum-input');
      //let total = Utils.sumInputFloats(row_sum_input);
      //this.row_total = total;
      let accounting_row = this.getAccountRow();
      if (accounting_row) {
        accounting_row.update({ row_total: this.row_total });
      }
    });
  };

  bindExpenseTypeSelect = select => {
    if (select) {
      select.on('change', () => {
        this.setAccountCode(select);
      });
    }
  };

  bindRemove = button => {
    button.on('click', () => {
      let accounting_row = this.getAccountRow();
      if (accounting_row) {
        accounting_row.destroy();
      }
      this.destroy();
    });
  };

  destroy = () => {
    this.state.expense_other_rows = this.state.expense_other_rows.filter(i => i.id !== this.id);
    this.element.remove();
    this.destroy_element.val('true');
  }

  setAccountCode = select => {
    if (select) {
      this.account_code = select.find('option:selected').data('account-code');
      let accounting_row = this.getAccountRow();
      if (accounting_row) {
        accounting_row.update({ account_code: this.account_code, row_total: this.row_total });
      } else {
        this.state.accounting_rows_queue.push({ expense_row_id: this.id, account_code: this.account_code, row_total: this.row_total });
        $('#add_accountings').click();
      }
    }
  };

  getAccountRow = () => {
    return this.state.accounting_rows.find(a => a.expense_row_id === this.id);
  }
}

export default ExpenseOtherRow;
