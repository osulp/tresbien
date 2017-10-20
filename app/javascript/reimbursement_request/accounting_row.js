import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';
import BasicRow from './basic_row';

class AccountingRow extends BasicRow {
  constructor(form, element, state, data) {
    super(form, element, state);
    extendObservable(this, {
      account_code: '',
      row_total: 0
    });
    autorun(() => this.element.find('.account-code').val(this.account_code));
    autorun(() => this.element.find('.accounting-row-total').val(parseFloat(this.row_total.toFixed(2))));
    if (data) {
      this.expense_row_id = data.expense_row_id;
      this.account_code = data.account_code;
      this.row_total = data.row_total;
    }
  }

  update = (data) => {
    if (data.account_code) {
      this.account_code = data.account_code;
    }
    if (data.row_total !== undefined){
      this.row_total = parseFloat(data.row_total.toFixed(2));
    }
  };

  destroy = () => {
    this.state.accounting_rows = this.state.accounting_rows.filter(i => i.id !== this.id);
    this.element.remove();
    this.destroy_element.val('true');
  }
}

export default AccountingRow;
