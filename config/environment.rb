# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Override default field_with_errors behaviour
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end