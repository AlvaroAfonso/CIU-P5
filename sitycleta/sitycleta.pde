//import gifAnimation.*;


import java.util.Iterator;
import java.util.Map.Entry;

PGraphics pg;
PGraphics mapa;

float minLat, maxLat, minLon, maxLon;

Table estaciones;
XML estacionesXML;

HashMap<String, PVector> coordenadas = new HashMap<String, PVector>();

PImage mapaPNG;

String[] start;
String[] end;
String[] minutos;
String[] rental;
String[] returnPlace;

float latOrigen;
float lonDest;
float lonOrigen;
float latDest;

boolean change = true;

boolean mapaOption = false;

//posicion de la estacion en pantalla
int actual = 0;

//GifMaker gifExport;


void setup() {
  size(1000, 800, P3D);
  pg = createGraphics(750, 500);
  mapa = createGraphics(width, height);
  
  mapaPNG = loadImage("map.png");
  
  estacionesXML = loadXML("map.xml");
  estaciones = loadTable("sitycleta2021.csv", "header");
  
  start = new String[estaciones.getRowCount()];
  end = new String[estaciones.getRowCount()];
  minutos = new String[estaciones.getRowCount()];
  rental = new String[estaciones.getRowCount()];
  returnPlace = new String[estaciones.getRowCount()];
  
  int pos = 0;
  
  for(TableRow row : estaciones.rows()){
    
    //datos para fichas
    start[pos] = row.getString("Start");
    end[pos] = row.getString("End");
    minutos[pos] = row.getString("Minutos");
    rental[pos] = row.getString("Rental place");
    returnPlace[pos] = row.getString("Return place");
    
    String estacion = rental[pos];
    
    //si es una estacion nueva la guardamos para posteriormente insertar sus coordenadas con el xml
    if(!coordenadas.containsKey(estacion)){
      coordenadas.put(estacion, new PVector());
    }
    
    estacion = returnPlace[pos];
    
    //si es una estacion nueva la guardamos para posteriormente insertar sus coordenadas con el xml
    if(!coordenadas.containsKey(estacion)){
      coordenadas.put(estacion, new PVector());
    }
    pos++;
  }
  
  
  println("Listo");
  
  XML limites = estacionesXML.getChildren("bounds")[0];
    
    minLat = limites.getFloat("minlat");
    minLon = limites.getFloat("minlon");
    maxLat = limites.getFloat("maxlat");
    maxLon = limites.getFloat("maxlon");
    
    for(XML nodo : estacionesXML.getChildren("node")){
      for (XML tag : nodo.getChildren("tag")) {
        for (String coord : coordenadas.keySet()) {
          //if (coordenadas.get(coord).x != 0) continue;
          if (tag.getString("v").contains(coord)) {
            coordenadas.put(coord, new PVector(nodo.getFloat("lat"), nodo.getFloat("lon")));
          }
        }
      }
    }
  
  Iterator<Entry<String, PVector>> it = coordenadas.entrySet().iterator();
    
    while(it.hasNext()){
      Entry<String, PVector> value = it.next();
      
      if(value.getValue().x == 0.0){
        it.remove();
      }
    }
    
    
   it = coordenadas.entrySet().iterator();
    
    while(it.hasNext()){
      Entry<String, PVector> value = it.next();
      println(value.getKey() + "------" + coordenadas.get(value.getKey()));
    }
    
}

void draw() {
  background(50);
  
  //camera();
  
  //directionalLight(255,255,255, -1, 0, -1);
  
  pg.beginDraw();
  pg.background(102);
  pg.stroke(255);
  pg.textSize(40);
  //pg.textAlign(CENTER);
  pg.fill(255);
  pg.text("Inicio: " + start[actual], 20, 40);
  pg.text("Fin: " + end[actual], 20, 90);
  pg.text("Minutos: " + minutos[actual], 20, 140);
  pg.text("Recogida: \n    " + rental[actual], 20, 190);
  pg.text("Devuelta: \n    " + returnPlace[actual], 20, 320);
  pg.endDraw();
  image(pg, width/2 - pg.width/2, height/2 - pg.height/2);
  
  
  
  if(mapaOption){

    textureMode(NORMAL);
    beginShape();
    texture(mapaPNG);
    vertex(0, 0, 0,   0);
    vertex(width, 0, 1, 0);
    vertex(width, height, 1, 1);
    vertex(0, height, 0,   1);
    endShape();
    
    boolean random = true;
    
    if(change){
      //coordenadas de prueba por si las coordinadas reales no estan en el xml
      latOrigen = random(height);
      lonDest = random(width);
      lonOrigen = random(width);
      latDest = random(height);
      change = false;
    }
    
    if(coordenadas.containsKey(rental[actual])){
        println(rental[actual]  + " Origen");

      random = false;
      latOrigen = map(coordenadas.get(rental[actual]).y, maxLat, minLat, 0, height);                //MOSTRAR LINEAS EN EL MAPA
      lonOrigen = map(coordenadas.get(rental[actual]).x, minLon, maxLon, 0, width);
    }
    
    if(coordenadas.containsKey(returnPlace[actual])){
        println(returnPlace[actual] + " Destino");

      random = false;
      latDest = map(coordenadas.get(returnPlace[actual]).y, maxLat, minLat, 0, height);                //MOSTRAR LINEAS EN EL MAPA
      lonDest = map(coordenadas.get(returnPlace[actual]).x, minLon, maxLon, 0, width);
    }
   
    
    fill(0);
    strokeWeight(5);
    textSize(50);
    if(random){
      text("Random", 10, 60);
    }
    println("\n\nLatOrigen " + latOrigen, "\nLonOrigen " + lonOrigen, "\nLatDest " + latDest, "\nLonDest " + lonDest);

    line(lonOrigen, latOrigen, lonDest, latDest);
    
  }
}

void keyReleased(){
  
  if(keyCode == ENTER){
    mapaOption = !mapaOption;
  }
  
  if(keyCode == RIGHT && actual < estaciones.getRowCount()){
    actual += 1;
    change = true;
  }
  
  if(keyCode == LEFT && actual > 0){
    actual -= 1;
    change = true;
  }
}
