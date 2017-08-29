// return true if array2 is a subset of array1. Both must be Javascript arrays. Ignores 'hidden' class in second array
isSubset = function(array1, array2) {
  for (var i = 0; i < array2.length; i++) {
    if (!array1.includes(array2[i]) && array2[i] != 'hidden' ) return false
  } 
  return true;
}
// when a filter checkbox is checked or unchecked, hide/show each row of reimbursement requests that doesn't/does correspond to the set of checked filters
$(document).on('change', '.filter', function(e) {
  classes = [];
  checked_boxes = $('.filter').map(function() { if ($(this).is(':checked')) return $(this).attr('data-filter-target') }).toArray();
  checkbox = $(this);
  targetClass = $(this).attr("data-filter-target");
  parentRow = checkbox.parents(".card-body").parents(".row");
  parentRow.next().find("tr").each(function() {
    if ($(this).attr('class') && $(this).attr('class').includes(targetClass)) {
      classes = $(this).attr('class').split(' '); 
      if (checkbox.is(':checked') && isSubset(checked_boxes, classes)) {
        $(this).removeClass('hidden');
      } else if (!isSubset(checked_boxes, classes)) {
        $(this).addClass('hidden');
      }
    }
  });
}); 
