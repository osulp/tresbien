class CsCountrySelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    country = options[:country] || "United States"
    @builder.select(attribute_name, CityState.countries_for_select, { prompt: "Country", selected: country }, id: "countries-of-world", class: "required form-control" )
  end
end
