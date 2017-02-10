#language: es
Característica: UserIndex

  Escenario: index como admin
  
    Dado un usuario admin y 100 usuarios no admins
    Cuando el usuario admin inicia sesión
    Y se dirige a la lista de usuarios
    Entonces debería ver enlaces de borrado de usuarios y usarlos para borrar

  Escenario: index como no admin
  
    Dado un usuario admin y 100 usuarios no admins
    Cuando un usuario no admin inicia sesión
    Y se dirige a la lista de usuarios
    Entonces no debería ver enlaces de borrado de usuarios