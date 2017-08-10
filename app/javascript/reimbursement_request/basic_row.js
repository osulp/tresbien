import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

class BasicRow {
  constructor(form, element, state) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.state = state;
    this.element.find('.row-sum-input').each((i, input) => this.bindRowSumInput(input))
    this.element.find('.unique-id').val(this.id);
    extendObservable(this, {
      row_total: 0
    });
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
  }

  bindRowSumInput = input => {
    $(input).on('keyup mouseup', (e) => {
      let row_sum_input = this.element.find('.row-sum-input');
      let total = Utils.sumInputFloats(row_sum_input);
      this.row_total = total;
    })
  }
}

export default BasicRow;
