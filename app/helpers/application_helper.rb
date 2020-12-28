module ApplicationHelper
  def toastr_flash
    @message = flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = javascript_tag "toastr.#{type}('#{message}')"
      flash_messages << text if message
    end
    safe_join @message
  end
end
