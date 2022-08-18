module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title = ""
    base_title = t("base_title")
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "success"
      type = "error" if type == "error"
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end
end
