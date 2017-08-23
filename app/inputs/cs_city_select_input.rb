class CsCitySelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    state = options[:state] || nil
    @builder.select(attribute_name, cities_for_select(state), { prompt: "City" }, id: "cities-of-state", class: "required form-control" ) 
  end

  def cities_for_select(in_state) 
    return [] if in_state.nil?
    state = CS.get(:us).select { |k,v| v == in_state }.keys.first
    CS.cities(state, :us).map { |city| [city, city] }
  end
end
