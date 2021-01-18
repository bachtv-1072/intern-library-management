module ApplicationHelper
  def page_index params_page, index, per_page
    params_page ||= 1
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def toastr_flash
    @message = flash.each_with_object([]) do |(type, message), flash_messages|
      type = "success" if type == "notice"
      type = "error" if type == "alert"
      text = javascript_tag "toastr.#{type}('#{message}')"
      flash_messages << text if message
    end
    safe_join @message
  end

  def average_rating ratings
    ratings.present? ? (ratings.map { |x| x.point.to_i }.sum.to_f / ratings.size).round(1) : 0
  end
end
