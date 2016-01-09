module ReadersHelper
  def sortable(column,title=nil)
    column=column.delete "\""
    title ||=column.titleize
    css_class=(column == sort_column) ? "currentSort #{sort_direction}" : nil
    direction=(column == sort_column && sort_direction == "asc")? "desc" :"asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
