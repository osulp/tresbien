class CsStateSelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @builder.select(attribute_name, CS.get(:us).map { |s| [s[1], s[1], { 'data-abbreviation' => s[0] }] }, { prompt: "State"}, id: "states-of-country", class: "required form-control" )
  end
end
