class DatePickerInput < SimpleForm::Inputs::Base
  def input_html_classes
    super.push('datepicker form-control')
  end

  def input(wrapper_options)
    @builder.text_field(attribute_name, input_html_options);
  end
end

