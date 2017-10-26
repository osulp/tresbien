import BasicRow from './basic_row';

class MileageRow extends BasicRow {
  constructor(form, element, state) {
    super(form, element, state);
    // cents/mile for mileage reimbursement calculations, sourced and rendered from a configuration on the server
    this.mileage_reimbursement_rate = parseFloat(this.element.find('.mileage-reimbursement-rate').val());
    this.bindRoundTripCheckbox(this.element.find('input.round-trip-checkbox'));
    this.bindMileageSumInput(this.element.find('.reimbursement_request_expense_mileages_miles > input'));
    this.element.find('.reimbursement_request_expense_mileages_miles > input').change();
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
      if (isNaN(parseFloat(input.val()))) {
        this.row_total = 0;
      } else {
        this.row_total = parseFloat((input.val() * this.mileage_reimbursement_rate).toFixed(2));
      }
    });
  };
}

export default MileageRow;
