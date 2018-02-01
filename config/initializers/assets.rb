Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

Rails.application.config.assets.precompile << %w[*.png *.jpg *.jpeg *.gif]
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/

# STYLESHEETS

Rails.application.config.assets.precompile << %w[
  tickets/index.sass
  tickets/show.sass
]

# JAVASCRIPTS

Rails.application.config.assets.precompile << %w[
  tickets/index.js
  tickets/show.js
]
