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
    this.destroy_element = this.element.next('.destroy');
    this.state = state;
    this.button = this.element.find('.add-other-expenses');
    this.per_diem = parseFloat(this.element.find('.per-diem-rate').val());
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.element.parents('.table').show();
    this.bindRemove(this.element.find('.remove_fields'));
    this.bindClick(this.button);
    extendObservable(this, {
      row_total: 0
    });
    autorun(() => this.element.find('.row-sum-input').val(this.row_total.toFixed(2)));
    if (data) {
      this.setRowFields(data);
    }
    this.element.find('.sum-input').each((i, input) => this.bindSumInput(input));
    this.element.find('.sum-input').first().change();
  }

  client_id = () => this.element.find('.client-id').val()

  bindClick = button => {
    button.on('click', e => {
      e.preventDefault();
      let data = this.getRowData(this.element);
      let date = Moment(data.date);
      if (this.state.above_per_diem_rows.find(a => a.client_id() == this.client_id()) === undefined) {
        this.state.above_per_diem_queue.push(Object.assign({}, data, { date }));
        $('#add_over_per_diem').click();
      }
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
      this.row_total = parseFloat(total.toFixed(2));
      let above_per_diem_row = this.abovePerDiemRow();
      if(above_per_diem_row.length > 0) {
        above_per_diem_row.find('.row-sum-input').val(Math.max(0, this.row_total - this.per_diem).toFixed(2));
        this.row_total = parseFloat(Math.min(this.per_diem, this.row_total).toFixed(2));
      }
      if (parseFloat(this.element.find('.row-sum-input').val()) > (this.per_diem)) {
        this.element.find('.add-other-expenses').removeClass('hidden');
        this.element.find('.row-sum-input').parent().addClass('has-error');
        if (!this.element.find('.row-sum-input').next().length) {
          this.element.find('.row-sum-input').parent().append('<span class="help-block">Amount exceeds per diem</span>');
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

  abovePerDiemRow = () => {
    let data = this.getRowData(this.element);
    return $('#expense_above_per_diems')
      .find(`.from-date[value^="${data.date}"]`)
      .parents('tr')
      .find(`input.client-id[value="${this.client_id()}"]`)
      .parents('tr');
  }

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
    let data = this.getRowData(this.element);
    let above_per_diems = this.state.above_per_diem_rows.filter(a => a.client_id() === this.client_id() && Moment(a.date()).isSame(Moment(data.date)));
    if (above_per_diems.length) {
      above_per_diems[0].destroy();
    }
    this.state.itinerary_rows = this.state.itinerary_rows.filter(i => i.id !== this.id);
    this.element.remove();
    this.destroy_element.val('true');
  };

  setRowFields = data => {
    let meals_rate = data.per_diem - data.hotel_rate;
    this.element.find('input.date').val(data.day.format('YYYY-MM-DD'));
    this.element.find('.date-label').text(data.day.format('YYYY-MM-DD'));
    this.element.find('.reimbursement_request_travel_itineraries_break > input').val((meals_rate / 4).toFixed(2));
    this.element.find('.reimbursement_request_travel_itineraries_lunch > input').val((meals_rate / 4).toFixed(2));
    this.element.find('.reimbursement_request_travel_itineraries_dinner > input').val((meals_rate / 2).toFixed(2));
    this.element.find('.reimbursement_request_travel_itineraries_hotel > input').val(parseFloat(data.hotel_rate).toFixed(2)).change();
    this.element.find('input.travel-city-id').val(data.travel_city_id);
    this.element.find('input.per-diem-rate').val(data.per_diem);
    this.element.find('input.city').val(data.city);
    this.element.find('input.country').val(data.country);
    this.element.find('input.state').val(data.state);
    this.element.find('input.client-id').val(data.client_id);
    this.element.find('.location-label').text(`${data.city}, ${data.state} (${data.country})`);
  };

  getRowData = tr => {
    let date = tr.find('input.date').val();
    let country = tr.find('input.country').val();
    let state = tr.find('input.state').val();
    let city = tr.find('input.city').val();
    let client_id = this.client_id();
    let amount = this.row_total - this.per_diem;
    return { date, country, state, city, amount, client_id };
  }
}

export default ItineraryRow;
