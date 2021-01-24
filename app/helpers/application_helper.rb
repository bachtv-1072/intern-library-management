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

  def options_publisher
    Publisher.pluck :name, :id
  end

  def average_rating ratings
    if ratings.present?
      (ratings.sum(&:point).to_f / ratings.size).round Settings.rouding
    else
      Settings.quantity
    end
  end

  def options_for_select_rating
    (1..5).map{|i| [i, i]}
  end
end
