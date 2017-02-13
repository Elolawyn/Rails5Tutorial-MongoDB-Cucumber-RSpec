#language: es
Característica: Following

  Escenario: página de seguidores
  
    Dado dos usuarios michael y archer
    Y ambos se siguen mutuamente
    Cuando michael accede a su lista de seguidores
    Entonces ve que lo sigue archer

  Escenario: página de personas que sigo
  
    Dado dos usuarios michael y archer
    Y ambos se siguen mutuamente
    Cuando michael accede a su lista de personas que sigue
    Entonces ve que sigue a archer

  Escenario: seguir a alguien
  
    Dado dos usuarios michael y archer
    Cuando michael sigue a archer
    Entonces la relación se establece

  Escenario: dejar de seguir a alguien
  
    Dado dos usuarios michael y archer
    Cuando michael deja de seguir a archer
    Entonces la relación se rompe