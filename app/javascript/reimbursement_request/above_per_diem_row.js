import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

class AbovePerDiemRow {
  constructor(form, element, state, data) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.state = state;
    this.element.find('.row-sum-input').each((i, input) => this.bindRowSumInput(input));
    this.element.find('.unique-id').val(this.id);
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    extendObservable(this, {
      row_total: 0
    });
    this.row_total = parseFloat(this.element.find('.row-sum-input').val()).toFixed(2);
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
    this.element.find('.row-sum-input').change();
    if (data) {
      this.setRowFields(data);
    }
  }

  bindRowSumInput = input => {
    $(input).on('keyup mouseup change', e => {
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
    });
  };

  setRowFields = data => {
    this.element.find('input.from-date').val(data.date.format("YYYY/MM/DD"));
    this.element.find('input.to-date').val(data.date.format("YYYY/MM/DD"));
    this.element.find('input.travel-itinerary-id').addClass(data.travel_itinerary_id);
    this.element.find('input.row-sum-input').val(data.amount);
    this.element.find('div.reimbursement_request_expense_above_per_diems_notes > input').val(`Expenses above per diem on ${data.date.format("YYYY/MM/DD")} in ${data.city}, ${data.state}`);
  };

}

export default AbovePerDiemRow;
