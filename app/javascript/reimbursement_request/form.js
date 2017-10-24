import Utils from '../utils/utils';
import { extendObservable, autorun } from 'mobx';

import moment from 'moment';
import { extendMoment } from 'moment-range';
const Moment = extendMoment(moment);

import * as numeral from 'numeral';

import AbovePerDiemRow from './above_per_diem_row';
import AccountingRow from './accounting_row';
import BasicRow from './basic_row';
import CityRow from './city_row';
import ExpenseOtherRow from './expense_other_row';
import ItineraryRow from './itinerary_row';
import MileageRow from './mileage_row';

class Form {
  constructor(selector, state) {
    $(document).ready(() => {
      this.element = $(selector);
      this.state = state;
      this.bindCocoonEvents();
      // Should be executed prior to the travel-itinerary rows
      $('tr.above-per-diem').each((i, element) => {
        this.state.above_per_diem_rows.push(new AbovePerDiemRow(this, element, this.state));
      });
      // Should be executed prior to travel-city rows
      $('tr.travel-itinerary').each((i, element) => {
        this.state.itinerary_rows.push(new ItineraryRow(this, element, this.state));
      });
      $('tr.travel-city').each((i, element) => {
        this.state.city_rows.push(new CityRow(this, element, this.state));
      });
      $('tr.mileage').each((i, element) => {
        this.state.basic_rows.push(new MileageRow(this, element, this.state));
      });
      $('tr.basic').each((i, element) => {
        this.state.basic_rows.push(new BasicRow(this, element, this.state));
      });
      // Should be executed prior to the expense-other rows
      $('tr.accounting').each((i, element) => {
        this.state.accounting_rows.push(new AccountingRow(this, element, this.state));
      });
      $('tr.expense-other').each((i, element) => {
        this.state.expense_other_rows.push(new ExpenseOtherRow(this, element, this.state));
      });
      $('.table').each((i, element) => {
        if ($(element).find('tbody tr').length > 0) {
          $(element).show();
        }
      });
      this.element.find('.notes-warning').find('.slideout').toggle('slide');
      this.bindSlideOut(this.element.find('.notes-warning'));
      this.bindDateTimePicker($('.datepicker'));
      this.bindTimePicker($('.timepicker'));
      this.bindHideNotesWarning(this.element.find('#reimbursement_request_business_notes_and_purpose'));
      this.bindSubmitButtons();
      autorun(() => {
        this.element.find('.itineraries-total').val(this.state.itineraries_total);
        this.element.find('.airfare-total').val(this.state.expense_airfare_total);
        this.element.find('.mileage-total').val(this.state.expense_mileage_total);
        this.element.find('.other-expenses-total').val(this.state.expense_other_total);
        this.element.find('.grand-total-input').val(this.state.grand_total);
        this.element.find('.itineraries-total-label').text(numeral(this.state.itineraries_total).format('$0,0.00'));
        this.element.find('.airfare-total-label').text(numeral(this.state.expense_airfare_total).format('$0,0.00'));
        this.element.find('.mileage-total-label').text(numeral(this.state.expense_mileage_total).format('$0,0.00'));
        this.element.find('.other-expenses-total-label').text(numeral(this.state.expense_other_total).format('$0,0.00'));
        this.element.find('.grand-total-input-label').text(numeral(this.state.grand_total).format('$0,0.00'));
      });
    });
  }

  bindCocoonEvents = () => {
    $(document).on('cocoon:before-remove', '.table', (e, itemToBeRemoved) => {
        if (itemToBeRemoved.parents(".table").find("tbody tr").length <= 1) {
          itemToBeRemoved.parents(".table").hide();
        }
      })
      .on('cocoon:after-insert', '.table', (e, itemInserted) => {
        this.element.find('.notes-warning').removeClass('hidden').addClass('show');
        this.element.find('.reimbursement_request_business_notes_and_purpose > textarea').addClass('warn');
        this.bindDateTimePicker($(e.target).find('.datepicker'));
        this.bindTimePicker($(e.target).find('.timepicker'));

        if (itemInserted.hasClass('travel-itinerary')) {
          // grab and remove the top itinerary day and set this fields values
          let data = this.state.itinerary_days_queue.splice(0, 1)[0];
          this.state.itinerary_rows.push(new ItineraryRow(this, itemInserted, this.state, data));
        } else if (itemInserted.hasClass('travel-city')) {
          this.state.city_rows.push(new CityRow(this, itemInserted, this.state));
        } else if (itemInserted.hasClass('above-per-diem')) {
          let data = this.state.above_per_diem_queue.splice(0, 1)[0];
          this.state.above_per_diem_rows.push(new AbovePerDiemRow(this, itemInserted, this.state, data));
        } else if (itemInserted.hasClass('mileage')) {
          this.state.basic_rows.push(new MileageRow(this, itemInserted, this.state));
        } else if (itemInserted.hasClass('basic')) {
          this.state.basic_rows.push(new BasicRow(this, itemInserted, this.state));
        } else if (itemInserted.hasClass('expense-other')) {
          this.state.expense_other_rows.push(new ExpenseOtherRow(this, itemInserted, this.state));
        } else if (itemInserted.hasClass('accounting')) {
          // grab and remove the top accounting row data and init a new object
          let data = this.state.accounting_rows_queue.splice(0, 1)[0];
          this.state.accounting_rows.push(new AccountingRow(this, itemInserted, this.state, data));
        } else {
          $(itemInserted).parents('table').show();
        }
      });
  };

  bindHideNotesWarning = element => {
    element.on('keyup', (e) => {
      element.prev().find('.notes-warning').removeClass('show').addClass('hidden');
    }).on('mouseenter', (e) => {
      element.removeClass('warn');
    });
  }
  bindDateTimePicker = element => {
    $(element).datetimepicker({
      timepicker: false,
      format: 'Y-m-d',
      scrollInput: false,
      onShow: (current_time, $input) => {
        let row = $input.parents('tr');
        let { from_date, to_date } = this.getDateInputs(row);
        if (this.isFromDate($input)) {
          let max_date = false;
          if (to_date.val() !== '') {
            // prevent selection from anything in the past
            max_date = to_date.datetimepicker('getValue');
          }
          $(from_date).datetimepicker('setOptions', {
            minDate: false,
            maxDate: max_date
          });
        } else {
          let min_date = false;
          if (from_date.val() !== '') {
            // set from_date to the date selected, and prevent selection from anything in the future
            min_date = from_date.datetimepicker('getValue');
          }
          $(to_date).datetimepicker('setOptions', {
            minDate: min_date,
            maxDate: false
          });
        }
      }
    });
  };

  bindSlideOut = element => {
    element.on('mouseenter mouseleave', (e) => {
      element.find('.slideout').toggle('slide');
    });
  }
  getDateInputs = row => {
    return { from_date: $(row).find('input.datepicker[name*="from_date"]'), to_date: $(row).find('input.datepicker[name*="to_date"]') };
  }
  isFromDate = element => {
    return (element.attr('name').indexOf('from_date') > -1);
  }

  bindTimePicker = element => {
    $(element).datetimepicker({
      datepicker: false,
      format: 'g:i A',
      formatTime: 'g:i A',
      scrollInput: false
    });
  };

  bindSubmitButtons = () => {
    let buttons = $("button[type='submit'");
    buttons.on('click', e => {
      $(e.currentTarget).popover('hide');
      $(e.currentTarget).popover('dispose');
      //check accounting rows total vs grand total and error if they do not match
      if (this.state.accountings_total !== this.state.grand_total) {
        $(e.currentTarget).popover({
          content: `Accounting Total: <b>$${this.state.accountings_total}</b><br/>Reimbursement Total: <b>$${this.state.grand_total}</b><br/><br/>Accounting entries and reimbursement totals <b>must match</b> before saving the request.`,
          placement: 'top',
          title: 'Accounting Reimbursement Error',
          trigger: 'focus',
          html: true,
          delay: {
            "show": 300,
            "hide": 10
          }
        });
        $(e.currentTarget).popover('toggle');
        e.preventDefault();
      }
    });
  }
}

export default Form;
