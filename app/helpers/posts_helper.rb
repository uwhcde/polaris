module PostsHelper
  # def link_to_remove_fields(name, f)
  #   f.hidden_field(:_destroy)
  # end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to name, '#', onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"
  end
end



# # before
# link_to_function icon_tag('close.png'), '$(this).parent().hide()', :title => t('actions.close'), :class => 'close'

# # after
# link_to icon_tag('close.png'), '#', :onclick => '$(this).parent().hide()', :title => t('actions.close'), :class => 'close'
