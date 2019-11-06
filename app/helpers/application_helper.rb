module ApplicationHelper

def body_class(body_class)
  if body_class.present?
    "#{body_class}"
  end
end

end