import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';
import BasicRow from './basic_row';

class ExpenseOtherRow extends BasicRow {
  constructor(form, element, state) {
    super(form, element, state);
    extendObservable(this, {
      account_code: ''
    });
    if (this.client_id() === '') {
      this.element.find('.client-id').val(this.id);
    }
    this.setAccountCode(this.element.find('.expense-type'));
    this.bindExpenseTypeSelect(this.element.find('.expense-type'));
    this.bindRowSumInput(this.element.find('.row-sum-input'));
    this.bindRemove(this.element.find('.remove_fields'));
  }

  client_id = () => this.element.find('.client-id').val()

  bindRowSumInput = input => {
    $(input).on('keyup change', e => {
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
    this.state.expense_other_rows = this.state.expense_other_rows.filter(i => i.client_id() !== this.client_id());
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
        this.state.accounting_rows_queue.push({ client_id: this.client_id(), account_code: this.account_code, row_total: this.row_total });
        $('#add_accountings').click();
      }
    }
  };

  getAccountRow = () => {
    return this.state.accounting_rows.find(a => a.client_id() === this.client_id());
  }
}

export default ExpenseOtherRow;
