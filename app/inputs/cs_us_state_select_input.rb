class CsUsStateSelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    country = "United States"
    state = options[:state] || nil
    @builder.select(attribute_name, CityState.states_for_select(country), { prompt: "State", selected: state }, id: "states-of-country", class: "required form-control" )
  end
end