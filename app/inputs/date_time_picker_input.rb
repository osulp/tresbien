class DateTimePickerInput < SimpleForm::Inputs::Base
  def input_html_classes
    super.push('datetimepicker form-control')
  end

  def input(wrapper_options)
    @builder.text_field(attribute_name, input_html_options)
  end
end

