module MapDisplayHelper
  def get_marker_data(screen_name,name)
    "<strong>Name:</strong> #{name} <br/><strong>Twitter handle:</strong>#{screen_name}"
  end
end
