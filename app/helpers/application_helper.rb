module ApplicationHelper
  def page_title(params = {})
    page_name = t("#{controller_name}.#{action_name}.page_title", params.merge(default: ''))

    return t('app_name') if page_name.blank?

    t('app_action', action_name: page_name)
  end
end
