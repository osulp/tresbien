$(document).on('load change', '#states-of-country', function(e) {
  console.log('Querying cities for selected state.');
  var cities_of_state, input_state, state;
  input_state = $(this);
  cities_of_state = input_state.parent().next().find('#cities-of-state');
  state = this.options[e.target.selectedIndex].id;
  $.ajax({
    url: '/cities/' + $(this).children(':selected').attr('data-abbreviation'),
    success: function(data) {
      var opt = '<option value="" selected>City</option>';
      if (data.length) {
        data.forEach(function(i) {
          opt += '<option value="' + i + '">' + i + '</option>';
        });
        cities_of_state.html(opt);
      }
    }
  });
});
