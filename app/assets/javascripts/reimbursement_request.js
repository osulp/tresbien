// returns the value in input converted to a float or zero if the input is blank; returns NaN for non-number inputs
var getInputTotal = function(input) {
  if (input.length) {
    if (input.val().length > 0) {
      return parseFloat(input.val());
    }
  }
  return 0;
}

// sets the 'total' input box for table; table should be a "form-table" div with an field whose name contains amount in the last row; total is left blank if total is 0
var setTableTotal = function(table) {
  var totalInput = table.children().last().find("input");
  var total;
  total = 0;
  table.children().each( function() {
    $(this).find('.amount-input').each( function() {
      total += getInputTotal($(this));
    });
  });
  if (!isNaN(total) && total > 0) 
    totalInput.val(total);
  else  {
    totalInput.val(null);
  }
}

// set grandTotalInput to the sum of the values in each total-input field; ignores null values and leaves grandTotalInput blank if total is zero 
var setGrandTotal = function(grandTotalInput) {
  var total;
  total = 0;
  $(".total-input").each( function() {
    total += getInputTotal($(this)); 
  });
  if (total > 0) totalInput.val(total);
  else totalInput.val(null);
}

$(document).ready(function() {
  $(document).on('change keyup','.amount-input', function(e) {
    table = $(this).parents('.form-table');
    setTableTotal(table);
  })
  .on('cocoon:after-remove', '.form-table', function(e) {
    setTableTotal($(this));
  })
  .on('click', "#calculate-total", function(e) {
    e.preventDefault();
    totalInput = $(this).next().find(".grand-total-input");
    setGrandTotal(totalInput);
  })
  .on('cocoon:after-insert', '.form-table', function(e) {
    $(this).find('.datetimepicker').datetimepicker();
    $(this).find('.datepicker').datetimepicker({
      timepicker: false
    });
    $(this).find('.timepicker').datetimepicker({
      datepicker: false,
      format: 'g:i A',
      formatTime: 'g:i A' 
    });
  });
  $('.datetimepicker').datetimepicker();
  $('.datepicker').datetimepicker({
    timepicker:false// ,
    // uformat:'m/d/y'
  });
  $('.timepicker').datetimepicker({
    datepicker:false,
    format:'g:i A',
    formatTime:'g:i A'
  });
});



