class CsCitySelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    country = options[:country] || nil
    state = options[:state] || nil
    city = options[:city] || nil
    @builder.select(attribute_name, CityState.cities_for_select(country, state, city), { prompt: "City", selected: city }, id: "cities-of-state", class: "required form-control" )
  end
end
