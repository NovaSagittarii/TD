int sizeX = 500, sizeY = 650;
boolean mp = false;

GAME game = new GAME();
PREF pref = new PREF();

class GAME {
  int state = 0, buyY2 = 0;
  float camX = 0, camY = 0, camXs = 0, camYs = 0, buyX = 0, buyXs = 0, buyY = 0, buySel = -1;
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
    {0, 0, 0, 0, 1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 5, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  };
  String levelPath[] = "RRRDDDRRDDDRUUUURRRRDDRDDDDDDDDDLLLLLLDDDRRRRRRRRRRRRRR".split("");
  ArrayList<Enemy> enemies;
  ArrayList<Notif> notifs;
  ArrayList<Bullet> bullets;
  STAT stat = new STAT();
}
class STAT {
  int kills = 0;
}
class Enemy {
  int maxhp, maxsh, value, def, progress, progress2;
  float x, y, hp, sh, sp; //hp- hitpoints, sh-sheild, sp-speed
  String type;
  Enemy(float tx, float ty, String ttype){
    progress = 0;
    progress2 = 0;
    maxsh = 0;
    def = 0;
    x = tx;
    y = ty;
    type = ttype;
    switch(type){
      case "basic":
        maxhp = 10;
        value = 1;
        sp = 2;
      break;
    }
    hp = maxhp;
    sh = maxsh;
  }
  boolean dead() {
    if(hp < 0){
      game.stat.kills ++;
      return true;
    }else{
      return false;
    }
  }
  void display() {
    switch(type){
      case "basic":
        Nellipse(x, y, 20, 20, 8, 3, color(255, 0, 0), 2);
      break;
    }
    fill(255, 0, 0);
    noStroke();
    rect(x, y - 20, hp / maxhp * 20, 3);
    switch(game.levelPath[progress]){
      case "R":
        x += sp;
      break;
      case "U":
        y -= sp;
      break;
      case "L":
        x -= sp;
      break;
      case "D":
        y += sp;
      break;
    }
    progress2 += sp;
    if(progress2 >= 50){
      progress ++;
      progress2 = 0;
      if(progress >= game.levelPath.length){
        progress = 0;
        hp = -1;
      }
    }
  }
}
class Bullet {
  float x, y, a, v; //[a]ngle, [v]elocity
  int dmg; //Damage
  boolean AoE;
  boolean DoT;
  Bullet(float tx, float ty, float ta, float tv, int tdmg, boolean tAoE, boolean tDoT){
    x = tx;
    y = ty;
    a = ta;
    v = tv;
    dmg = tdmg;
    AoE = tAoE;
    DoT = tDoT;
  }
}
class Notif {
  int tl, s, r, g, b;
  float x, y;
  String txt;
  Notif(float Tx, float Ty, int Ts, String Ttxt, int Tr, int Tg, int Tb){
    tl = 250;
    s = Ts;
    r = Tr;
    g = Tg;
    b = Tb;
    x = Tx;
    y = Ty;
    txt = Ttxt;
  }
  boolean requestRemoval() {
    if(tl < 0){
      return true;
    }else{
      return false;
    }
  }
  void display() {
    fill(r, g, b, tl);
    text(txt, x, y);
    y += 2 - tl/50;
    tl -= 5;
  }
}

class PREF {
  float sensitivity = 1;
}