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
    if (data) {
      this.element.find('.client-id').val(data.client_id);
      this.account_code = data.account_code;
      this.row_total = data.row_total;
    } else {
      if (this.client_id() === '') {
        this.element.find('.client-id').val(this.id);
      }
      if (this.element.find('.account-code').val() !== '') {
        this.account_code = this.element.find('.account-code').val();
      }
      let val = this.element.find('.accounting-row-total').val();
      if (isNaN(val)) {
        this.row_total = 0;
      } else {
        this.row_total = parseFloat(parseFloat(val).toFixed(2));
      }
    }
    autorun(() => this.element.find('.account-code').val(this.account_code));
    autorun(() => this.element.find('.accounting-row-total').val(this.row_total));
    this.bindRowInput(this.element.find('.accounting-row-total'));
  }

  client_id = () => this.element.find('.client-id').val()

  bindRowInput = input => {
    input.on('keyup mouseup', e => {
      this.row_total = parseFloat(parseFloat(input.val()).toFixed(2));
    });
  };

  update = (data) => {
    if (data.account_code) {
      this.account_code = data.account_code;
    }
    if (data.row_total !== undefined){
      this.row_total = parseFloat(data.row_total.toFixed(2));
    }
  };

  destroy = () => {
    this.state.accounting_rows = this.state.accounting_rows.filter(i => i.client_id() !== this.client_id());
    this.element.remove();
    this.destroy_element.val('true');
  }
}

export default AccountingRow;
