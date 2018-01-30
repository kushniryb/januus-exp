SimpleCov.start do
  add_filter %w[spec config bin]

  add_group 'Controllers', 'app/decorators'
  add_group 'Facades',     'app/facades'
  add_group 'Models',      'app/models'
  add_group 'Operations',  'app/operations'
  add_group 'Services',    'app/services'
end
