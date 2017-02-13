#language: es
Característica: PasswordReset

  Escenario: token espirado
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla cuando el token ha expirado
    Entonces se le notifica que el token ha expirado

  Escenario: email incorrecto en la solicitud
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña incorrecto
    Entonces se le notifica que el correo es incorrecto

  Escenario: acceso al cambio de contraseña con email incorrecto
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla con el email incorrecto
    Entonces se le redirige a la página principal

  Escenario: acceso al cambio de contraseña con usuario inactivo
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla con el usuario inactivo
    Entonces se le redirige a la página principal

  Escenario: acceso al cambio de contraseña con token incorrecto
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla con el token incorrecto
    Entonces se le redirige a la página principal

  Escenario: acceso al cambio de contraseña sin introducir la contraseña
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla correctamente
    Y no introduce la contraseña
    Entonces se le muestra un error

  Escenario: acceso al cambio de contraseña con errores en formulario
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla correctamente
    Y introduce los datos de reseteo incorrectamente
    Entonces se le muestra los errores

  Escenario: acceso al cambio de contraseña correcto
  
    Dado un usuario michael
    Cuando solicita un reseteo de contraseña correcto
    Y accede a resetearla correctamente
    Y introduce los datos de reseteo correctamente
    Entonces se modifica la contraseña
