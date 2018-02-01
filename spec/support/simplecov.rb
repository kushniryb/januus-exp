SimpleCov.start do
  add_filter %w[spec config bin controllers]

  add_group 'Decorators',   'app/decorators'
  add_group 'Helpers',      'app/helpers'
  add_group 'Interactions', 'app/interactions'
  add_group 'Models',       'app/models'
  add_group 'Services',     'app/services'
end
