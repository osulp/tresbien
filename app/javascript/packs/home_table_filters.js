// return true if array2 is a subset of array1. Both must be Javascript arrays. Ignores 'hidden' class in second array
isSubset = function(array1, array2) {
  return !(array2.filter((e) => e !== 'hidden')
    .some((e, i, a) => !array1.includes(e)))
}
// when a filter checkbox is checked or unchecked, hide/show each row of reimbursement requests that doesn't/does correspond to the set of checked filters
$(document)
  .on('change', '.filter', function(e) {
    let checked_boxes = $('.filter')
      .map(function() {
        if ($(this)
          .is(':checked')) return $(this)
          .attr('data-filter-target')
      })
      .toArray();
    let checkbox = $(this);
    let targetClass = $(this)
      .attr("data-filter-target");
    let parentRow = checkbox.parents(".card-body")
      .parents(".row");
    parentRow.next()
      .find("tr")
      .each(function() {
        if ($(this)
          .attr('class') && $(this)
          .attr('class')
          .includes(targetClass)) {
          let classes = $(this)
            .attr('class')
            .split(' ');
          if (checkbox.is(':checked') && isSubset(checked_boxes, classes)) {
            $(this)
              .removeClass('hidden');
          } else if (!isSubset(checked_boxes, classes)) {
            $(this)
              .addClass('hidden');
          }
        }
      });
  });