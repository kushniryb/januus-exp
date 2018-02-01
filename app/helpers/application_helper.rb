module ApplicationHelper
  def page_title(params = {})
    page_name = t("#{controller_name}.#{action_name}.page_title", params.merge(default: ''))

    return t('app_name') if page_name.blank?

    t('app_action', action_name: page_name)
  end

  def include_action_javascript
    ActionSpecificAssets::Loader.call(
      context:         self,
      controller_name: controller_name,
      action_name:     action_name,
      asset_type:      ActionSpecificAssets::AssetType::JAVASCRIPT,
      optional:        { 'data-turbolinks-track': 'reload' },
      silence:         Rails.env.production?
    )
  end

  def include_action_stylesheet
    ActionSpecificAssets::Loader.call(
      context:         self,
      controller_name: controller_name,
      action_name:     action_name,
      asset_type:      ActionSpecificAssets::AssetType::STYLESHEET,
      optional:        { 'data-turbolinks-track': 'reload', media: 'all' },
      silence:         Rails.env.production?
    )
  end
end
