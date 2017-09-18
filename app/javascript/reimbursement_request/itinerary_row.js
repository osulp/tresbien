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
    this.button = this.element.find('.add-other-expenses');
    this.per_diem = parseFloat(this.element.find('.per-diem-rate').val());
    this.element.find('.unique-id').val(this.id);
    this.element.find('.sum-input').each((i, input) => this.bindSumInput(input));
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    this.bindClick(this.button);
    extendObservable(this, {
      row_total: 0
    });
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
    this.element.find('.sum-input:first').change();

    if (data) {
      this.setRowFields(data);
    }
    this.element.find('.sum-input').first().change();
  }

  bindClick = button => {
    button.on('click', e => {
      e.preventDefault();
      let data = this.getRowData(this.element);
      let date = Moment(data.date);
      this.state.above_per_diem_queue.push(Object.assign({}, data, {date}));
      $('#add_over_per_diem').click();
      this.element.find('.row-sum-input').val(this.per_diem);
      this.element.find('.sum-input').first().change();
    });
  }

  bindSumInput = input => {
    $(input).on('keyup change', e => {
      this.per_diem = parseFloat(this.element.find('.per-diem-rate').val());
      let row_sum_input = this.element.find('.row-sum-input');
      let sum_inputs = this.element.find('.sum-input');
      let total = Utils.sumInputFloats(sum_inputs);
      this.row_total = total;
      if ($(`input.${this.id}`).length) {
        $(`input.${this.id}`).parents('tr').find('.row-sum-input').val(Math.max(0, this.row_total - this.per_diem));
        row_sum_input.val(Math.min(this.per_diem, this.row_total));
      }
      if (parseFloat(this.element.find('.row-sum-input').val()) > (this.per_diem)) {
        this.element.find('.add-other-expenses').removeClass('hidden');
        this.element.find('.row-sum-input').parent().addClass('has-error');
        if (!this.element.find('.row-sum-input').next().length) {
          this.element.find('.row-sum-input').parent().append('<span class="help-block">can\'t be greater than per diem rate</span>');
        }
      } else {
        if (this.element.find('.reimbursement_request_travel_itineraries_amount > .help-block').length) {
          this.element.find('.reimbursement_request_travel_itineraries_amount > .help-block').remove();
        }
        this.element.find('.add-other-expenses').addClass('hidden');
        this.element.find('.row-sum-input').parent().removeClass('has-error');
      }
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
    this.element.find('input.date').val(data.day.format('YYYY-MM-DD'));
    this.element.find('.date-label').text(data.day.format('YYYY-MM-DD'));
    this.element.find('.reimbursement_request_travel_itineraries_hotel > input').val(data.hotel_rate).change();
    this.element.find('input.travel-city-id').val(data.travel_city_id);
    this.element.find('input.per-diem-rate').val(data.per_diem);
    this.element.find('input.city').val(data.city);
    this.element.find('input.country').val(data.country);
    this.element.find('input.state').val(data.state);
    this.element.find('.location-label').text(`${data.city}, ${data.state} (${data.country})`);
  };

  getRowData = tr => {
    let date = tr.find('input.date').val();
    let country = tr.find('input.country').val();
    let state = tr.find('input.state').val();
    let city = tr.find('input.city').val();
    let travel_itinerary_id = tr.find('input.unique-id').val();
    let amount = this.row_total - this.per_diem;
    return { date, country, state, city, amount, travel_itinerary_id };
  }
}

export default ItineraryRow;
