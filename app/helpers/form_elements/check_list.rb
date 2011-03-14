InlineForms::SPECIAL_COLUMN_TYPES[:check_list]=:no_migration

# checklist
def check_list_show(object, attribute)
  out = '<ul class="checklist">'
  out << link_to_inline_edit(object, attribute) if object.send(attribute).empty?
  object.send(attribute).sort.each do | item |
    out << '<li>'
    out << link_to_inline_edit(object, attribute, item._presentation )
    out << '</li>'
  end
  out <<  '</ul>'
  out.html_safe
end

def check_list_edit(object, attribute)
  object.send(attribute).build  if object.send(attribute).empty?
  values = object.send(attribute).first.class.name.constantize.find(:all) # TODO bring order
  out = '<div class="edit_form_checklist">'
  out << '<ul>'
  values.each do | item |
    out << '<li>'
    out << check_box_tag( attribute + '[' + item.id.to_s + ']', 1, object.send(attribute.singularize + "_ids").include?(item.id) )
    out << '<div class="edit_form_checklist_text">'
    out << h(item._presentation)
    out << '</div>'
    out << '<div style="clear: both;"></div>'
    out << '</li>'
  end
  out << '</ul>'
  out << '</div>'
  out.html_safe
end

def check_list_update(object, attribute)
  params[attribute] ||= {}
  object.send(attribute.singularize + '_ids=', params[attribute].keys)
end
