import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

class AbovePerDiemRow {
  constructor(form, element, state, data) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.destroy_element = this.element.next('.destroy');
    this.state = state;
    this.element.find('.unique-id').val(this.id);
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    extendObservable(this, {
      row_total: 0
    });
    this.row_total = parseFloat(this.element.find('.row-sum-input').val()).toFixed(2);
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
    if (data) {
      this.setRowFields(data);
    }
    this.element.find('.row-sum-input').each((i, input) => this.bindRowSumInput(input));
    this.element.find('.row-sum-input').change();
    this.showNotesWarning();
  }

  client_id = () => this.element.find('.client-id').val()
  date = () => this.element.find('.from-date').val()

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
    this.element.remove();
    this.destroy_element.val('true');
    this.state.above_per_diem_rows = this.state.above_per_diem_rows.filter(a => a.id !== this.id);
  };

  setRowFields = data => {
    this.element.find('.date').text(data.date.format("YYYY-MM-DD"));
    this.element.find('input.from-date').val(data.date.format("YYYY-MM-DD"));
    this.element.find('input.to-date').val(data.date.format("YYYY-MM-DD"));
    this.element.find('input.row-sum-input').val(data.amount);
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
