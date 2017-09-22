import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';
import moment from 'moment';
import { extendMoment } from 'moment-range';
const Moment = extendMoment(moment);

class CityRow {
  constructor(form, element, state) {
    this.id = Utils.generateId();
    this.form = form;
    this.element = $(element);
    this.element.find('.unique-id').val(this.id);
    this.element.find('[data-toggle="tooltip"]').tooltip();
    this.table_name = this.element.data('table-name');
    this.destroy_element = this.element.next('.destroy');
    this.element.parents('.table').show();
    this.state = state;
    this.bindClick(this.element.find('.add-itineraries'));
    this.bindRemove(this.element.find('.remove_fields'));
    if (this.client_id() == '' || this.client_id() == 0) {
      this.element.find('.client-id').val(this.id);
    }
    extendObservable(this, {
      row_total: 0
    });
    autorun(() => this.element.find('.row-sum-input').val(this.row_total));
    this.element.find('.sum-input').each((i, input) => this.bindSumInput(input));
    this.element.find('.sum-input').change();

    if (this.state.itinerary_rows.find(c => c.client_id() == this.client_id())) {
      this.element.find('.add-itineraries').addClass('hidden');
    }
  }

  client_id = () => this.element.find('.client-id').val()

  bindSumInput = input => {
    $(input).on('keyup mouseup change', e => {
      let row_sum_input = this.element.find('.row-sum-input');
      let sum_inputs = this.element.find('.sum-input');
      let total = Utils.sumInputFloats(sum_inputs);
      this.row_total = total;
      $('.travel-itinerary').each((i, row) => {
        if ($(row).find('.travel-city-id').val() == this.travel_city_id) {
          $(row).find('.per-diem-rate').val(this.row_total);
        }
      });
    });
  };

  bindClick = button => {
    button.on('click', e => {
      e.preventDefault();
      let data = this.getRowData(this.element);
      if (this.state.itinerary_rows.find(c => c.client_id() == data.client_id)) {
        console.log(`Travel City Itineraries ${data.client_id} already added to form.`);
      } else {
        let from_date = Moment(data.from_date);
        let to_date = Moment(data.to_date);
        if (from_date.isValid() && to_date.isValid()) {
          // calculate the number of days between fromDate and toDate
          // add to citiesTravelledItineraryDaysQueue for each day
          // then "click" the add travel itinerary button for each day, so that the click event handler
          //   will iterate through each of the citiesTravelledItineraryDaysQueue items to update its rows
          let range = Moment.range(from_date, to_date);
          let days = Array.from(range.by('days'));
          days.forEach(day => this.state.itinerary_days_queue.push(Object.assign({}, data, { day })));
          days.forEach(day => $('#add_travel_itinerary').click());
          $(button).addClass('hidden');
        } else {
          // warn user that there are invalid dates
          console.log('Invalid dates selected.');
        }
      }
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
    let itinerary_rows = this.state.itinerary_rows.filter(i => i.client_id() === this.client_id());
    itinerary_rows.forEach(i => i.destroy());
    this.state.city_rows = this.state.city_rows.filter(i => i.id !== this.id);
    this.element.remove();
    this.destroy_element.val('true');
  };

  getRowData = tr => {
    let from_date = $(tr.find('input.datepicker')[0]).val();
    let to_date = $(tr.find('input.datepicker')[1]).val();
    let country = tr.find('select#countries-of-world').val();
    let state = tr.find('select#states-of-country').val();
    let city = tr.find('select#cities-of-state').val();
    let hotel_rate = tr.find('.reimbursement_request_travel_cities_hotel_rate > input').val();
    let per_diem = tr.find('.reimbursement_request_travel_cities_per_diem > input').val();
    let client_id = this.client_id();
    return { from_date, to_date, state, city, hotel_rate, per_diem, client_id, country };
  };
}

export default CityRow;
