void mouseDragged(){
  if(game.state != 5){
    return;
  }
  if(game.buyY2 != 100 && mouseY < (height - 100)){
    game.camXs += (mouseX - pmouseX) / 5 * pref.sensitivity;
    game.camYs += (mouseY - pmouseY) / 5 * pref.sensitivity;
  }
}
void mousePressed(){
  mp = true;
  game.notifs.add(new Notif(mouseX-game.camX, mouseY-game.camY, 5, "You clicked!", 255, 255, 255));
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