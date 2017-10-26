import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

class AbovePerDiemRow {
  constructor(form, element, state, data) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.destroy_element = this.element.next('.destroy');
    this.row_sum_input = this.element.find('.row-sum-input');
    this.state = state;
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    extendObservable(this, {
      row_total: 0
    });
    if (data) {
      this.setRowFields(data);
    } else {
      this.row_total = parseFloat(this.row_sum_input.val());
    }
    autorun(() => this.row_sum_input.val(this.row_total.toFixed(2)));
    this.bindRowSumInput(this.row_sum_input);
    this.showNotesWarning();
  }

  client_id = () => this.element.find('.client-id').val()
  date = () => this.element.find('.from-date').val()

  bindRowSumInput = input => {
    $(input).on('keyup change', e => {
      let total = Utils.sumInputFloats(input);
      this.row_total = parseFloat(total.toFixed(2));
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
    this.element.remove();
    this.destroy_element.val('true');
    this.state.above_per_diem_rows = this.state.above_per_diem_rows.filter(a => a.client_id() !== this.client_id());
    let itinerary_rows = this.state.itinerary_rows.filter(i => i.client_id() === this.client_id());
    itinerary_rows.forEach(i => i.inputChange());
  };

  setRowFields = data => {
    this.element.find('.date').text(data.date.format("YYYY-MM-DD"));
    this.element.find('input.from-date').val(data.date.format("YYYY-MM-DD"));
    this.element.find('input.to-date').val(data.date.format("YYYY-MM-DD"));
    this.row_sum_input.val(parseFloat(data.amount).toFixed(2));
    this.element.find('input.notes').val(`Expenses above per diem on ${data.date.format("YYYY-MM-DD")} in ${data.city}, ${data.state}`);
    this.element.find('.client-id').val(data.client_id);
  };

  showNotesWarning = () => {
    alert = this.element.parents('.form-row').prev().find('.alert');
    if (alert.length) {
      alert.removeClass('hidden');
      alert.addClass('show');
    }
  }
}

export default AbovePerDiemRow;
