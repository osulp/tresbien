FactoryGirl.define do
  factory :nested_params, class: Hash do
    transient do
      main nil
      children []
    end

    initialize_with do
      { main.to_s => {
        build(main).attributes.except('id', 'created_at', 'updated_at')}
          .merge(children.each_with_object({}) {
            |child, hash| hash[child.to_s] = (build(child).attributes.except('id', 'created_at', 'updated_at'))
          })
        }
    end
  end
end
