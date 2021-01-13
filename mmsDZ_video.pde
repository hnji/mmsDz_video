//import com.hamoid.*;
import processing.video.*;
Movie film, background;
int brojac, brojPiksela = 640 * 352;
PImage pozadina;
color boja1, boja2;
float razlika1, razlika2, razlika3, najvecaRazlika, dopustenoOdstupanje = 0;
color boje[] = {#FF0000, #00FF00, #0000FF, #000000, #FFFF00, #000000};
color trenutacnaBoja=color(255,0,0);
int indeksBoje;

float brzina = 1;
boolean flag = false; // prikaz menija 
boolean flagPause = false;


void setup() {
  size(640,352);
  film = new Movie(this, "mateaMute.m4v");
  background = new Movie(this, "Oceans-1.m4v");
  //film = new Movie(this, "testVideo.mp4");
  //background = new Movie(this, "background.mp4");
  //film.playbin.setVolume(0);
  //film.play();
  film.loop();
  background.loop();
  //film.volume(0);
  pozadina = loadImage("mateaPozadina.jpeg");
  //pozadina = loadImage("testPozadina.png");

  pozadina.loadPixels();
}
void draw() {
  if(film.available()) film.read();
  if(background.available()) background.read();
  
  film.loadPixels();
  background.loadPixels();
  for (int i = 0; i < brojPiksela; i++) {
    boja1 = film.pixels[i]; boja2 = pozadina.pixels[i];
    razlika1 = abs(red(boja1) - red(boja2));
    razlika2 = abs(green(boja1) - green(boja2));
    razlika3 = abs(blue(boja1) - blue(boja2));
    najvecaRazlika = max(razlika1, razlika2, razlika3);
    // if (film.pixels[i] == pozadina.pixels[i]) {
    if (najvecaRazlika <= dopustenoOdstupanje) {
        film.pixels[i] = background.pixels[i];
      //film.pixels[i] = trenutacnaBoja;
    }
  }
  film.updatePixels();
  //background.updatePixels();
  //image(background,0,0);
  image(film,0,0);
  
  //fill(0); rect(0,0,360,28);
  //fill(255); textSize(24);
  //text("Dopušteno odstupanje = " + dopustenoOdstupanje,10,24);
  
  
  if (flag == true)
  {
    fill(0); rect(0, 0, 170, 70);
    fill(255); textSize(16);
    //text("Dopušteno odstupanje = " + dopustenoOdstupanje,10,24);
    text("Q: quit", 5, 16);
    text("S: change the speed", 5, 32);
    text("J: go to the middle", 5, 48);
    text("P: play/pause", 5, 64);
  }
  
  if (flagPause == true)
  {
        film.pause();
        background.pause();
  }
  
  else
  {
        film.play();
        background.play();
  }
  
  film.speed(brzina);
  background.speed(brzina);
}
// Ova funkcija se poziva svaki puta 
// kad je u videu dostupna nova slika za čitanje
void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  if (key == 'q') {
    exit();
  }
  if (key == 'b') {
    if (++indeksBoje >= boje.length) {
      indeksBoje=0;
    }
    trenutacnaBoja = boje[indeksBoje];
  }
  if (key == '+') {
    ++dopustenoOdstupanje;
  }
  if (key == '-') {
    --dopustenoOdstupanje;
  }
  
  //efekti
   if ( key == 's' )
  {
    if (brzina == 1)
      brzina = 2;
    else if (brzina == 2)
      brzina = 0.5;
    else brzina = 1;
  }
  if ( key == 'j' )
  {
        film.jump(film.duration()/2);
        background.jump(background.duration()/2);

  }
    
  if (key == 'h')
  {
    if(flag  == true) flag = false;
    else     flag = true;
  }
  if ( key == 'p' )
{
    if(flagPause  == true) flagPause = false;
    else     flagPause = true;
  }  
}
