# CIU-P5
Proyecto de "Creando interfaces de usuario", asignatura de la ULPGC (Universidad de Las Palmas de Gran Canaria) hecho por **Álvaro Javier Afonso López**

### Introducción
El objetivo de esta práctica es obtener unos datos de una zona de un mapa, y con los nombres y coordenadas ser capaz de ubicarlos en una imagen de esa misma zona.

![Gif de una prueba del proyecto](https://github.com/AlvaroAfonso/CIU-P5/blob/main/sitycleta/data/export.gif)

### Desarrollo
Lo primero era conseguir la imagen y los datos de una zona geolóca, sacada de https://www.openstreetmap.org, que nos aportaba algunos de los nombres y coordenadas de ciertos lugares. Esos lugares sería obtenidos de un csv proporcionado por la web de sitycleta, aportándonos un seguimiento de las bicis, hora y lugar de recogida hasta hora y lugar de entrega. Con esos datos transpolariamos las coordenadas reales a lo equivalente en el contexto de la imagen del mapa. Dada la inconsistencia de los datos, he puesto coordenadas aletatorias cuando no se encontraban las originales para al menos ver la funcionalidad.

### Controles
Flechas izquierda y derecha para cambiar de alquiler de bici, ENTER para visualizarlo en el mapa.

### Dificultades
La primera dificulad encontrada fue que en processing hace la separación de datos por comas, y el csv viene separado por defecto por punto y coma.
La segunda dificultad es que al ser los datos de distintas fuentes, es dificil manejarlos conjuntamente, en este caso el archivo csv nos proporcionaba los nombres de una zona, pero no sus coordenadas, y al buscarlas en otra fuente con los nombres del csv podian coincidir o no, dado que esta segunda fuente carecía de tildes o de la letra "ñ" o incluso si encontraba un nombre vacío lo daba por aceptado. Por ese motivo de la cantidad de datos que tenemos del csv, solo se ha podido ubicar correctamente 9.

### Bibliografía
* Documentos de la propia práctica
* Página oficial de Proccesing
* http://planetpixelemporium.com/planets.html
