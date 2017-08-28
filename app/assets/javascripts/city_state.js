$(document).on('load change', '#states-of-country', function(e) {
  console.log('Querying cities for selected state.');
  var cities_of_state = $(this).parents('tr').find('#cities-of-state');
  var country = $(this).parents('tr').find('#countries-of-world').children(':selected').data('abbreviation');
  var state = $(this).children(':selected').data('abbreviation');
  var state_value = $(this).children(':selected').val();
  $.ajax({
    url: `/cities/${state}/${country}`,
    success: function(data) {
      var opt = '<option value="" selected>City</option>';
      if (data.length) {
        data.forEach(function(i) {
          opt += `<option value="${i}">${i}</option>`;
        });
      } else {
        opt = `<option value="${state_value}">${state_value}</option>`;
      }
      cities_of_state.html(opt);
    }
  });
});

$(document).on('load change', '#countries-of-world', function(e) {
  console.log('Querying states of a country.');
  var cities_of_state = $(this).parents('tr').find('#cities-of-state');
  var states_of_country = $(this).parents('tr').find('#states-of-country');
  var country = $(this).children(':selected').data('abbreviation');
  var country_value = $(this).children(':selected').val();
  $.ajax({
    url: `/states/${country}`,
    success: function(data) {
      var opt = '<option value="" selected>State</option>';
      if (Object.keys(data).length) {
        for(var k of Object.keys(data)) {
          opt += `<option value="${data[k]}" data-abbreviation='${k}'>${data[k]}</option>`;
        }
      } else {
        opt = `<option value="${country_value}">${country_value}</option>`;
        cities_of_state.html(opt);
      }
      states_of_country.html(opt);
    }
  });
});
