if Rails.env.development?
  Bullet.enable       = true
  Bullet.alert        = true
  Bullet.console      = true
  Bullet.rails_logger = true
end
