#language: es
Característica: UserSignup

  Escenario: registro con información inváĺida
  
    Cuando un usuario intenta registrase con información inválida
    Entonces se muestra un error

  Escenario: registro con información válida sin activación
  
    Cuando un usuario se registra con información válida
    Y intenta iniciar sesión
    Entonces no puede

  Escenario: registro con información válida sin activación
  
    Cuando un usuario se registra con información válida
    Y intenta iniciar sesión
    Entonces no puede