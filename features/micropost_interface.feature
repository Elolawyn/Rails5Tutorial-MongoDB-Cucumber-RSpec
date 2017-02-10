#language: es
Característica: InterfazMicropost

  Escenario: un usuario ve que tiene un micropost
  
    Dado un usuario michael que tiene un micropost
    Cuando el usuario se loguea
    Entonces debería ver en la página inicial que dispone de un micropost

  Escenario: al borrar el micropost, el usuario tiene 1 menos
  
    Dado un usuario michael que tiene un micropost
    Cuando el usuario se loguea y borra su micropost
    Entonces debería ver en la página inicial que no tiene microposts

  Escenario: error al crear un micropost

    Dado un usuario michael
    Cuando el usuario se loguea y crea un micropost con errores
    Entonces debería ver un error

  Escenario: paginación

    Dado un usuario michael que tiene 100 microposts
    Cuando el usuario se loguea
    Entonces debería ver su lista de posts paginada

  Escenario: creación de micropost

    Dado un usuario michael
    Cuando el usuario se loguea y crea un micropost correctamente
    Entonces el micropost se crea