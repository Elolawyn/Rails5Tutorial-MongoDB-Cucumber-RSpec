#language: es
Característica: UserEdit

  Escenario: edición errónea
  
    Dado un usuario michael
    Cuando el usuario se logea, accede a su perfil y lo modifica erróneamente
    Entonces su perfil no se actualiza y se muestran errores

  Escenario: edición correcta
  
    Dado un usuario michael
    Cuando el usuario se logea, accede a su perfil y lo modifica correctamente
    Entonces su perfil se actualiza

  Escenario: edición correcta con redireccionamiento amistoso
  
    Dado un usuario michael
    Cuando el usuario anónimo intenta acceder al perfil, es redirigido amistasamente y luego actualiza su perfil correctamente
    Entonces su perfil se actualiza