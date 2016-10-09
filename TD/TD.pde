import ddf.minim.*;

Minim minim;
AudioPlayer track1, track2, track3;

void mousePressed(){
  mp = true;
}

void setup() {
  minim = new Minim(this);
  track1 = minim.loadFile("Rocket.mp3");
  track2 = minim.loadFile("Rising.mp3");
  track3 = minim.loadFile("Kick Shock.mp3");
  game.state = 5;
  game.enemies = new ArrayList<Enemy>();
  game.notifs = new ArrayList<Notif>();
  game.bullets = new ArrayList<Bullet>();
  size(700, 400);
  //fullScreen();
  surface.setResizable(true);
  surface.setTitle("Work-In-Progress TD");
  //surface.setIcon(loadImage("icon.png"));
  textFont(loadFont("Ubuntu-48.vlw"), 48);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
}
float[] waves = new float[135];
float last = 0;
void draw(){
  switch(game.state){
    case 0:
      /** LOGO? */
    break;
    case 1:
      /** MENU */
    break;
    case 2:
      /** CREDITS */
    break;
    case 3:
      /** UPGRADES */
    break;
    case 4:
      /** ACHIEVEMENTS */
    break;
    case 5:
      /** GAMEPLAY */
      loopMusic(track1);
      doWaves();
      game.camX += game.camXs;
      game.camY += game.camYs;
      game.camXs /= 1.2;
      game.camYs /= 1.2;
      noStroke();
      translate(game.camX, game.camY);
      background(0);
      int xloc = 25;
      int yloc = 75;
      for(int i = 1; i < game.levelPath.length; i ++){
        fill(80);
        rect(xloc, yloc, 50, 50);
        switch(game.levelPath[i]){
          case "L":
            xloc -= 50;
          break;
          case "U":
            yloc -= 50;
          break;
          case "R":
            xloc += 50;
          break;
          case "D":
            yloc += 50;
          break;
        }
      }
      fill(255);
      for(int i = game.bullets.size() - 1; i >= 0; i --){
        Bullet bullet = game.bullets.get(i);
        fill(150);
        ellipse(bullet.x, bullet.y, 10, 10);
        bullet.x += cos(bullet.a) * bullet.v;
        bullet.y += sin(bullet.a) * bullet.v;
      }
      strokeWeight(2);
      for(int i = 0; i < game.layout[0].length; i ++){
        for(int j = 0; j < game.layout.length; j ++){
          switch(game.layout[j][i]){
            case 0: /*Empty Space*/ break;
            case 1: /*Enemy Path*/ break;
            case 2: /*Enemy Path [2]*/ break;
            case 3: /*Enemy Path [3]*/ break;
            case 4: /*Enemy Path [4]*/ break;
          }
          if(game.layout[j][i] < 5){
            continue;
          }
          pushMatrix();
          int TowerID = (game.layout[j][i] - 5);
          float TowerR = 0;
          for(int k = game.enemies.size()-1; k > -1; k --){
            Enemy enemy = game.enemies.get(k);
            if(dist(enemy.x, enemy.y, i * 50 + 25, j * 50 + 25) > (data.tower.stats.range[TowerID] / 2)){
              continue;
            }
            TowerR = atan2(enemy.y - (j * 50 + 12.5), enemy.x - (i * 50 + 12.5));
          }
          translate(i * 50, j * 50);
          noFill();
          stroke(255, 100);
          ellipse(25, 25, (i * 4 + j * 10 + frameCount) % data.tower.stats.range[TowerID], (i * 4 + j * 10 + frameCount) % data.tower.stats.range[TowerID]);
          fill(255);
          //image(data.tower.baseP[TowerID], 25, 25);
          ellipse(25, 25, 30, 30);
          fill(255);
          translate(25, 25);
          rotate(TowerR + PI/2);
          rect(0, -10, 10, 25);
          fill(0, 100);
          arc(0, 0, 20, 20, 0, (round(noise(i*3, j*6) * 69 + frameCount) / data.tower.stats.reload[TowerID]) * PI % PI*2);
          popMatrix();
          if((round(noise(i*3, j*6) * 69 + frameCount) % data.tower.stats.reload[TowerID]) == 0 && TowerR != 0){
            game.bullets.add(new Bullet(i * 50 + 25, j * 50 + 25, TowerR, 7, data.tower.stats.damage[TowerID], false, false));
          }
        }
      }
      for(int i = game.enemies.size() - 1; i >= 0; i --){
        Enemy enemy = game.enemies.get(i);
        enemy.display();
        enemy.checkCollision();
        if(enemy.dead()){
          game.enemies.remove(i);
        }
      }
      pushMatrix();
      resetMatrix();
      translate(0, -game.buyY);
      fill(150, 100 + game.buyY/2);
      if((abs(mouseY - ((height-25) - game.buyY)) < 25) && ((abs(mouseX - 425) < 75 || mouseX > (width-350)-mouseY))){
        fill(175, 100 + game.buyY/2);
        if(mp){
          if(game.buyY > 50){
            game.buyY2 = 0;
            game.buySel = -1;
          }else{
            game.buyY2 = 100;
          }
        }
      }
      game.buyY -= (game.buyY - game.buyY2) / 7;
      stroke(255);
      strokeWeight(2);
      beginShape();
      vertex(width, height);
      vertex(width, height-50);
      vertex(width-200, height-50);
      vertex(width-250, height);
      vertex(-10, height);
      vertex(-10, height+200);
      vertex(width, height+200);
      endShape();
      fill(255);
      textSize(45);
      text("Build", width - 125, height - 25);
      fill(0, 255, 0);
      textSize(14);
      text("$" + game.money, width - 40, height - 35);
      fill(255, 0, 0);
      text("HP: " + round(game.health), width - 40, height - 15);
      translate(game.buyX, 0);
      for(int i = 0; i < 3; i ++){//12 turrets needed
        fill(255);
        textSize(data.tower.txtSize[i]);
        text(data.tower.name[i], i * 100, height + 80);
        if(abs(mouseX - i * 100 - game.buyX) < 40 && mouseY > (height - 100) || game.buySel == i){
          fill(255, 50);
          stroke(255, 50);
          if(game.buySel == i){
            stroke(255, 100);
            if(mp){
              //build whatever
            }
          }
          strokeWeight(10);
          rect(i * 100, height + 50, 80, 80);
          if(mp && abs(mouseX - i * 100 - game.buyX) < 40 && mouseY > (height - 100)){
            if(game.buySel == i){
              game.buySel = -1;
            }else{
              game.buySel = i;
            }
          }
        }
      }
      game.buyX += game.buyXs;
      game.buyXs /= 1.05;
      if(game.buyX > 150){
        game.buyXs -= 4;
        game.buyXs /= 2;
      }
      if(game.buyX < -500){
        game.buyXs += 4;
        game.buyXs /= 2;
      }
      if(game.buyY2 == 100 && mouseY > (height - 100) && mousePressed){
        game.buyXs += (pmouseX - mouseX) / -5;
      }
      popMatrix();
      for(int i = game.notifs.size() - 1; i >= 0; i --){
        Notif notif = game.notifs.get(i);
        notif.display();
        if(notif.requestRemoval()){
          game.notifs.remove(i);
        }
      }
    break;
  }
  mp = false;
  resetMatrix();
}