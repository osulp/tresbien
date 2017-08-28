import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';
import moment from 'moment';
import { extendMoment } from 'moment-range';
const Moment = extendMoment(moment);

class ItineraryRow {
  constructor(form, element, state, data) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.table_name = this.element.data('table-name');
    this.state = state;
    this.element.find('.unique-id').val(this.id);
    this.element.find('.sum-input').each((i, input) => this.bindSumInput(input));
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    extendObservable(this, {
      row_total: 0
    });
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));

    if (data) {
      this.setRowFields(data);
    }
  }

  bindSumInput = input => {
    $(input).on('keyup mouseup change', e => {
      let row_sum_input = this.element.find('.row-sum-input');
      let sum_inputs = this.element.find('.sum-input');
      let total = Utils.sumInputFloats(sum_inputs);
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
    this.element.find('input.datepicker:first').val(data.day.format('YYYY/MM/DD'));
    this.element.find('.reimbursement_request_travel_itineraries_hotel > input').val(data.hotel_rate).change();
    this.element.find('input.travel-city-id').val(data.travel_city_id);
    this.element.find('select#countries-of-world').val(data.country).change();
    this.element.find('select#countries-of-world').show();
    setTimeout(() => {
      this.element.find('select#states-of-country').val(data.state).change();
      setTimeout(() => {
        this.element.find('select#cities-of-state').val(data.city);
      }, 1000);
    }, 1000);
  };
}

export default ItineraryRow;
