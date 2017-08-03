/*
var set_city_state = function(input_state, state) {
  console.log("Input state: " + input_state.class + "\nState: " + state);
  var cities_of_state;
  cities_of_state = input_state.parent().next().find("#cities-of-state");
  // state = this.options[e.target.selectedIndex].id;
  if (state === 'no-state') {
    return cities_of_state.html('');
  } else {
    $.ajax({
      url: '/cities/' + $(this).children(':selected').attr('id'),
      success: function(data) {
        var opt;
        opt = '<option value="" selected>City</option>';
        if (data.length === 0) {

        } else {
          data.forEach(function(i) {
            opt += '<option value="' + i + '">' + i + '</option>';
          });
          cities_of_state.html(opt);
        }
      }
    });
  }
};
$(document).on('change', '#states-of-country', function(e) {
  set_city_state($(this), this.options[e.target.selectedIndex].id);
}).ready( function() {
  $("#states-of-country").each( function() { set_city_state($(this), $(this).find(":selected").id) } );
});
*/
$(document).on('load change', '#states-of-country', function(e) {
  console.log("setting . . .");
  var cities_of_state, input_state, state;
  input_state = $(this);
  cities_of_state = input_state.parent().next().find("#cities-of-state");
  state = this.options[e.target.selectedIndex].id;
  if (state === 'no-state') {
    return cities_of_state.html('');
  } else {
    $.ajax({
      url: '/cities/' + $(this).children(':selected').attr('id'),
      success: function(data) {
        var opt;
        opt = '<option value="" selected>City</option>';
        if (data.length === 0) {

        } else {
          data.forEach(function(i) {
            opt += '<option value="' + i + '">' + i + '</option>';
          });
          cities_of_state.html(opt);
        }
      }
    });
  }
});
