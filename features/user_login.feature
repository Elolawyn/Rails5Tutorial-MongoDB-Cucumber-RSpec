#language: es
Característica: UserIndex

  Escenario: login con información inválida
  
    Dado un usuario michael
    Cuando se dirige a la página de login
    Y introduce información errónea
    Entonces no inicia sesión

  Escenario: login con información válida
  
    Dado un usuario michael
    Cuando se dirige a la página de login
    Y introduce información correcta
    Entonces se inicia sesión

  Escenario: login con remembering y logout
  
    Dado un usuario michael
    Cuando se dirige a la página de login
    Y introduce información correcta con remembering
    Entonces se recibe una cookie
    Cuando se hage logout
    Entonces ya no hay cookie de recuerdo