//int sizeX = 500, sizeY = 650;
boolean mp = false;

GAME game = new GAME();
PREF pref = new PREF();

class GAME {
  //Give myself too much money because i'm awesome, and testing purposes. :3
  int state = 0, buyY2 = 0, money = 9999999, health = 10;
  float camX = 0, camY = 0, camXs = 0, camYs = 0, buyX = 100, buyXs = 0, buyY = 0, buySel = -1;
  //Turret ID + 5 on MapLayout to register. 2-4 are 'undefined'
  int layout[][] = {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 1, 1, 1, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0},
    {0, 0, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 5, 5},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  };
  //Use || to signal end.
  String levelPath[] = "RRRDDDRRDDDRUUUURRRRDDRDDDDDDDDDLLLLLLDDDRRRRRRRRRRRRRR||".split("");
  ArrayList<Enemy> enemies;
  ArrayList<Notif> notifs;
  ArrayList<Bullet> bullets;
  STAT stat = new STAT();
}
class STAT {
  int kills = 0;
}
class Enemy {
  int maxhp, maxsh, value, progress, dmgValue;
  float x, y, hp, sh, sp, HB, distLeft, distTraveled, chunkSize = 50, def; //hp- hitpoints, sh-sheild, sp-speed, HB- hitbox
  String type, dir = game.levelPath[0];
  Enemy(float tx, float ty, String ttype){
    progress = 0;
    distTraveled = 0;
    x = tx;
    y = ty;
    type = ttype;
    for(int l = 0; l < data.enemyStats.name.length; l ++){
      if(type == data.enemyStats.name[l]){
        maxhp = data.enemyStats.maxhp[l];
        maxsh = data.enemyStats.maxsh[l];
        sp = data.enemyStats.sp[l];
        def = (100 - data.enemyStats.def[l]) / 100;
        value = data.enemyStats.value[l];
        HB = data.enemyStats.hitbox[l];
        dmgValue = data.enemyStats.dmg[l];
      }
    }
    hp = maxhp;
    sh = maxsh;
    distLeft = chunkSize;
  }
  boolean dead() {
    if(hp == -420.1337){
      game.notifs.add(new Notif((-game.camX + width - 40), (-game.camY + height - 15 - game.buyY), 5, "-" + dmgValue + " HP", 255, 0, 0, -100, 20));
      return true;
    }
    if(hp <= 0){
      game.stat.kills ++;
      game.money += value;
      game.notifs.add(new Notif((-game.camX + width - 40), (-game.camY + height - 35 - game.buyY), 5, "+$" + value, 0, 255, 0, 0));
      return true;
    }else{
      return false;
    }
  }
  void move(String direction, float amount){
    switch(direction){
      case "R":
        x += amount;
      break;
      case "U":
        y -= amount;
      break;
      case "L":
        x -= amount;
      break;
      case "D":
        y += amount;
      break;
      default:
      hp = -420.1337;
      game.health -= dmgValue;
    }
  }
  void display() {
    switch(type){
      case "basic1":
        Nellipse(x, y, 20, 20, 8, 3, color(255, 0, 0), 2);
      break;
      case "basic2":
        Nellipse(x, y, 24, 24, 8, 3, color(0, 255, 255), 2);
      break;
      case "basic3":
        Nellipse(x, y, 24, 24, 8, 3, color(0, 255, 0), 2);
      break;
      case "basic9":
        Nellipse(x, y, 34, 34, 8, 3, color(255, 150, 0), 2);
      break;
      case "heavy1":
        Nrect(x, y, 20, 20, 8, 3, color(255, 0, 0), 2);
      break;
      case "heavy2":
        Nrect(x, y, 24, 24, 8, 3, color(0, 255, 255), 2);
      break;
      case "heavy3":
        Nrect(x, y, 26, 26, 8, 3, color(0, 255, 0), 2);
      break;
    }
    fill(255, 0, 0);
    noStroke();
    rect(x, y - 22, hp / maxhp * 20, 3);
    fill(0, 255, 255);
    rect(x, y - 19, sh / maxsh * 20, 3);
    distTraveled += sp;
    distLeft -= sp; //<>//
    if(distLeft < 0){
      if(dir != "|"){
        String nextDir = game.levelPath[progress + 1];
        move(dir, distLeft);
        distTraveled += distLeft;
        dir = nextDir;
        move(dir, sp);
        distLeft = chunkSize;
        progress ++;
      }
    }else{
      move(game.levelPath[progress], sp);
    }
  }
  void checkCollision(){
    for(int m = 0; m < game.bullets.size(); m ++){
      Bullet bullet = game.bullets.get(m);
      if(dist(bullet.x, bullet.y, x, y) < HB){
        float adjustedDmg = bullet.dmg * def;
        String shownDmg;
        if(adjustedDmg == round(adjustedDmg)){
          shownDmg = "-" + round(adjustedDmg);
        }else{
          shownDmg = "-" + floor(adjustedDmg) + "." + floor((adjustedDmg - floor(adjustedDmg)) * 10);
        }
        if(sh > 0){
          sh -= adjustedDmg;
          if(sh < 0){
            sh = 0;
          }
          game.notifs.add(new Notif(bullet.x, bullet.y, 5, shownDmg, 0, 255, 255, 0, round(7+constrain(adjustedDmg/5, 5, 20))));
        }else{
          hp -= adjustedDmg;
          game.notifs.add(new Notif(bullet.x, bullet.y, 5, shownDmg, 255, 0, 0, 0, round(7+constrain(adjustedDmg/5, 5, 20))));
        }
        bullet.pierce --;
        if(bullet.pierce <= 0){
          game.bullets.remove(m);
        }
      }
    }
  }
}
class Bullet {
  int ID; //bulletID
  float x, y, a, v, dmg, pierce; //[a]ngle, [v]elocity
  boolean AoE;
  boolean DoT;
  Bullet(float tx, float ty, float ta, float tv, float tdmg, boolean tAoE, boolean tDoT, int tPIR){
    x = tx;
    y = ty;
    a = ta;
    v = tv;
    dmg = tdmg;
    AoE = tAoE;
    DoT = tDoT;
    pierce = tPIR;
  }
  Bullet(float tx, float ty, float ta, float tv, float tdmg, boolean tAoE, boolean tDoT){
    x = tx;
    y = ty;
    a = ta;
    v = tv;
    dmg = tdmg;
    AoE = tAoE;
    DoT = tDoT;
    pierce = 1;
  }
}
class Notif {
  int tl, s, r, g, b, a, ts = 12;
  float x, y;
  String txt;
  Notif(float Tx, float Ty, int Ts, String Ttxt, int Tr, int Tg, int Tb, int Ta){
    tl = 250;
    s = Ts;
    r = Tr;
    g = Tg;
    b = Tb;
    a = Ta;
    x = Tx;
    y = Ty;
    txt = Ttxt;
  }
  Notif(float Tx, float Ty, int Ts, String Ttxt, int Tr, int Tg, int Tb, int Ta, int Tts){
    tl = 250;
    s = Ts;
    r = Tr;
    g = Tg;
    b = Tb;
    a = Ta;
    x = Tx;
    y = Ty;
    txt = Ttxt;
    ts = Tts;
  }
  boolean requestRemoval() {
    if(tl < 0){
      return true;
    }else{
      return false;
    }
  }
  void display() {
    fill(r, g, b, tl - a);
    textSize(ts);
    text(txt, x, y);
    y += 2 - tl/50;
    tl -= 5;
  }
}

class PREF {
  float sensitivity = 1;
}