import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

import moment from 'moment';
import { extendMoment } from 'moment-range';
const Moment = extendMoment(moment);

import * as numeral from 'numeral';

import CityRow from './city_row';
import ItineraryRow from './itinerary_row';
import BasicRow from './basic_row';

class Form {
  constructor(selector, state) {
    $(document).ready(() => {
      this.element = $(selector);
      this.state = state;
      this.bindCocoonEvents();
      $('tr.travel-city').each((i, element) => {
        this.state.city_rows.push(new CityRow(this, element, this.state));
      });
      $('tr.travel-itinerary').each((i, element) => {
        this.state.itinerary_rows.push(new ItineraryRow(this, element, this.state));
      });
      $('tr.basic').each((i, element) => {
        this.state.basic_rows.push(new BasicRow(this, element, this.state));
      });
      $('.table').each((i, element) => {
        if ($(element).find('tbody tr').length > 0) {
          $(element).show();
        }
      });
      this.bindDateTimePicker($('.datepicker'));
      this.bindTimePicker($('.timepicker'));
      autorun(() => {
        this.element.find('.itineraries-total').val(this.state.itineraries_total);
        this.element.find('.accountings-total').val(this.state.accounting_total);
        this.element.find('.airfare-total').val(this.state.expense_airfare_total);
        this.element.find('.mileage-total').val(this.state.expense_mileage_total);
        this.element.find('.other-expenses-total').val(this.state.expense_other_total);
        this.element.find('.grand-total-input').val(this.state.grand_total);
        this.element.find('.itineraries-total-label').text(numeral(this.state.itineraries_total).format('$0,0.00'));
        this.element.find('.accountings-total-label').text(numeral(this.state.accounting_total).format('$0,0.00'));
        this.element.find('.airfare-total-label').text(numeral(this.state.expense_airfare_total).format('$0,0.00'));
        this.element.find('.mileage-total-label').text(numeral(this.state.expense_mileage_total).format('$0,0.00'));
        this.element.find('.other-expenses-total-label').text(numeral(this.state.expense_other_total).format('$0,0.00'));
        this.element.find('.grand-total-input-label').text(numeral(this.state.grand_total).format('$0,0.00'));
      });
    });
  }

  bindCocoonEvents = () => {
    $(document)
      .on('cocoon:before-remove', '.table', (e, itemToBeRemoved) => {
        let id = $(itemToBeRemoved).find('.unique-id').val();
        if (itemToBeRemoved.hasClass('travel-city')) {
          let travel_city_id = $(itemToBeRemoved).find('input.travel-city-id').prop('id');
          // find all of the travel itineraries related to this city and remove them
          $('tr.travel-itinerary').find(`input.travel-city-id[value="${travel_city_id}"]`).parents('tr').find('.remove_fields').click();
          // reset citiesTravelled to exclude the travel_city_id which was clicked to be removed
          this.clearAndRemoveRow(this.state.city_rows, id, 'id');
        } else if (itemToBeRemoved.hasClass('travel-itinerary')) {
          this.clearAndRemoveRow(this.state.itinerary_rows, id, 'id');
        } else {
          this.clearAndRemoveRow(this.state.basic_rows, id, 'id');
        }
        if (itemToBeRemoved.parents(".table").find("tbody tr").length <= 1) {
          itemToBeRemoved.parents(".table").hide();
        }
      })
      .on('cocoon:after-insert', '.table', (e, itemInserted) => {
        this.bindDateTimePicker($(e.target).find('.datepicker'));
        this.bindTimePicker($(e.target).find('.timepicker'));

        if (itemInserted.hasClass('travel-itinerary')) {
          // grab and remove the top itinerary day and set this fields values
          let data = this.state.itinerary_days_queue.splice(0, 1)[0];
          this.state.itinerary_rows.push(new ItineraryRow(this, itemInserted, this.state, data));
        } else if (itemInserted.hasClass('travel-city')) {
          this.state.city_rows.push(new CityRow(this, itemInserted, this.state));
        } else {
          this.state.basic_rows.push(new BasicRow(this, itemInserted, this.state));
        }
      });
  };

  clearAndRemoveRow = (state_collection, id, comparison_field) => {
    let row = state_collection.find(c => c[comparison_field] === id);
    if (row.row_total !== undefined) {
      row.row_total = 0;
    }
    state_collection = state_collection.filter(c => c[comparison_field] !== id);
  };

  bindDateTimePicker = element => {
    $(element).datetimepicker({
      timepicker: false,
      format: 'Y/m/d',
      scrollInput: false
    });
  };

  bindTimePicker = element => {
    $(element).datetimepicker({
      datepicker: false,
      format: 'g:i A',
      formatTime: 'g:i A',
      scrollInput: false
    });
  };
}

export default Form;
