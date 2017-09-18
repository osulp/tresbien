import BasicRow from './basic_row';

class MileageRow extends BasicRow {
  constructor(form, element, state) {
    super(form, element, state);
    this.bindRoundTripCheckbox(this.element.find('input.round-trip-checkbox'));
    this.bindMileageSumInput(this.element.find('.reimbursement_request_expense_mileages_miles > input'));
  };

  bindRoundTripCheckbox = checkbox => {
    checkbox.on('click', e => {
      let distance_input = checkbox.parents('td').prev().find('input');
      let distance_input_val = parseFloat(distance_input.val());
      if (!isNaN(distance_input_val)) {
        if (checkbox.is(':checked')) {
          distance_input.val(distance_input_val * 2);
        } else {
          distance_input.val(distance_input_val / 2);
        }
      }
      distance_input.change();
    });
  };

  bindMileageSumInput = input => {
    input.on('keyup mouseup change', e => {
      let row_sum_input = this.element.find('.row-sum-input');
      if (!isNaN(parseFloat(input.val()))) {
        row_sum_input.val((parseFloat(input.val()) * .54).toFixed(2));
      } else {
        row_sum_input.val(0);
      }
    });
  };
}

export default MileageRow;
