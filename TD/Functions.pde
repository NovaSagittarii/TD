void keyPressed(){
  track1.loop();
}
void mouseDragged(){
  if(game.state != 5){
    return;
  }
  if((mouseY < (height - game.buyY))){
    game.camXs += (mouseX - pmouseX) / 5 * pref.sensitivity;
    game.camYs += (mouseY - pmouseY) / 5 * pref.sensitivity;
  }
}
void loopMusic(AudioPlayer music){
  if(!music.isPlaying()){
    music.loop();
  }
}
void Nellipse(float x, float y, float w, float h, int size, float intensity, int colour, int thickness){
  noFill();
  for(int i = -size; i <= size; i ++){
      stroke(colour, abs(i)*intensity);
      strokeWeight(5);
      ellipse(x, y, w-i, h-i);
  }
  stroke(255, 255, 255);
  strokeWeight(thickness);
  ellipse(x, y, w, h);
}
void Nrect(float x, float y, float w, float h, int size, float intensity, int colour, int thickness){
  noFill();
  for(int i = -size; i <= size; i ++){
      stroke(colour, abs(i)*intensity);
      strokeWeight(5);
      rect(x, y, w-i, h-i, constrain(i/size*-5, 0, 5));
  }
  stroke(255, 255, 255);
  strokeWeight(thickness);
  rect(x, y, w, h);
}
int wave = 0;  //Which wave. []
int waveP = 0; //Which part of the wave. [][]
int waveP2 = 0;//Progress of wave chunk [][][2]
int delay = 0;
void doWaves(){
  if(millis() > delay && wave < data.waves.length){
    if(waveP == 0){
      //Add on delay
      delay += parseInt(data.waves[wave][0][0]); //<>//
      waveP = 1;
    }else{
      if(waveP2 >= parseInt(data.waves[wave][waveP][1])){
        waveP ++;
        waveP2 = 0;
        if(waveP >= data.waves[wave].length){
          wave ++;
          waveP = 0;
          return;
        }
      }
      if(wave >= data.waves.length){
        return;
      }
      game.enemies.add(new Enemy(data.startPosX, data.startPosY, data.waves[wave][waveP][0]));
      waveP2 ++;
      delay += parseInt(data.waves[wave][waveP][2]);
    }
  }
}