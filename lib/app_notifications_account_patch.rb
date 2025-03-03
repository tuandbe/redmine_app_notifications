require_dependency 'my_controller'

module AppNotificationsAccountPatch
  # Sobrescribe el método account para extender su comportamiento.
  def account
    result = super  # Llama a la implementación original.
    User.safe_attributes 'app_notification', 'app_notification_desktop'
    result
  end
end

# En lugar de include, usamos prepend para que este módulo tenga prioridad.
MyController.prepend(AppNotificationsAccountPatch)
