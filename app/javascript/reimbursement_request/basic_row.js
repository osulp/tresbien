import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

class BasicRow {
  constructor(form, element, state) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.destroy_element = this.element.next('.destroy');
    this.state = state;
    this.element.find('.row-sum-input').each((i, input) => this.bindRowSumInput(input));
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    extendObservable(this, {
      row_total: 0
    });
    this.element.find('.row-sum-input').change();
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
  }

  bindRowSumInput = input => {
    $(input).on('keyup change', e => {
      let row_sum_input = this.element.find('.row-sum-input');
      let total = Utils.sumInputFloats(row_sum_input);
      this.row_total = total;
    });
  };

  bindRemove = button => {
    button.on('click', () => {
      let tooltip_id = button.attr('aria-describedby');
      if (tooltip_id) {
        $(`#${tooltip_id}`).remove();
      }
      this.destroy();
    });
  };

  destroy = () => {
    this.state.basic_rows = this.state.basic_rows.filter(i => i.id !== this.id);
    this.element.remove();
    this.destroy_element.val('true');
  }
}

export default BasicRow;
