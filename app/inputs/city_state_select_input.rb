class CityStateSelectInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    collection_states = CS.get(:us)
    state_names = collection_states.map { |v| v[1] }
    label_method = :to_s
    value_method = :to_s
    out = ActiveSupport::SafeBuffer.new
    # states_select = @builder.collection_select(
    #   attribute_name, state_names, value_method, label_method, input_options_states, input_html_options.merge(id: "states-of-country", name: "project[state]")
    # )
    # states_select = @builder.input attribute_name, :collection => Proc.new { collection_states.map { |state| [ state[1], state[1], { id: state[0] }] } }
    states_select = @builder.select "state".to_sym, collection_states.map { |state| [ state[1], state[1], { id: state[0] } ] }, {prompt: "State"}, input_html_options.merge(id: "states-of-country") 
    out << states_select
    city_select =@builder.collection_select(
      "city".to_sym, [], value_method, label_method, input_options, input_html_options.merge(required: true, id: "cities-of-state", name: "project[city]")
    )
    out << city_select
  end
  
  def input_options_states
    input_options.merge(prompt: "Please select a state")
  end

  def input_html_classes
    super.push('form-control')
  end

  def state_name(state)
    state[1]
  end

  def state_postal_code(state)
    state[0]
  end
end
