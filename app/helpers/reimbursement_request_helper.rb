module ReimbursementRequestHelper
  # returns the html for the remove button as an html safe string
  def remove_button
    '<span class="glyphicon glyphicon-minus bg-danger" id="blah"></span>'
  end
  # returns the html for the add button as an html safe string
  def add_button
    '<span class="glyphicon glyphicon-plus bg-success"></span>'.html_safe
  end
end
