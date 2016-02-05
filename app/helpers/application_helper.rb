module ApplicationHelper
  # https://gist.github.com/suryart/7418454
  FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-danger',
    warning: 'alert-warning',
    notice: 'alert-warning'
  }

  def flash_class_for(flash_type)
    FLASH_MSG[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "full-width-alert text-center alert alert-position #{flash_class_for(msg_type)} alert-dismissible fade in", role: 'alert') do
        concat (content_tag(:span) do
          concat content_tag(:span, "×", class: "close", "aria-hidden": true, data: { dismiss: "alert" })
          concat content_tag(:span, 'close', class: 'sr-only')
        end)
        concat message
      end)
      # "Added clearing of flash messages after initial page view" https://gist.github.com/suryart/7418454
      flash.clear
    end
    nil
  end
end
