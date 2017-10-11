class NestedAttributesForStrategy
  def association(runner)
    runner.run(:null)
  end

  def result(evaluation)
    evaluation.hash
  end
end
