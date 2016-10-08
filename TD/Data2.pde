DATA data = new DATA();
class DATA {
  int startPosX = -25, startPosY = 75;
  //{ ENEMY ID , AMT , DELAY (MILLIS) }
  String waves[][][] = {
    {{"1000"}, {"basic1", "5", "1000"}},
    {{"5000"}, {"basic1", "10", "500"}},
    {{"5000"}, {"basic2", "4", "1250"}, {"basic", "5", "500"}},
    {{"5000"}, {"basic3", "2", "2000"}},
    {{"5000"}, {"basic9", "1", "2000"}},
  };
  TOWER tower = new TOWER();
  ESTAT enemyStats = new ESTAT();
  class TOWER {
    String name[] = {"Basic Turret", "Laser Turret", "Twin Turret"};
    int txtSize[] = {15, 15, 15};
    PImage baseP[] = {loadImage("")};
    PImage barlP[] = {loadImage("")};
    STATS stats = new STATS();
    class STATS {
      int cost[] = {150, 250, 400};
      int range[] = {400, 750, 350};
      float reload[] = {70 /*should be 70*/, 20, 35};
      float damage[] = {20, 5, 20};
      boolean AoE[] = {false, false, false};
      boolean DoT[] = {false, false, false};
    }
  }
  class ESTAT {
    String name[] = {"basic1", "basic2", "basic3", "basic9"};
    int maxhp[] = {100, 250, 200, 2500};
    int maxsh[] = {0, 200, 400, 500};
    float sp[] = {2, 1, 1.5, 1};
    int def[] = {0, 0, 0, 0};
    int value[] = {1, 2, 4, 50};
    int hitbox[] = {14, 17, 17, 24};
    int dmg[] = {1, 1, 1, 10};
    int CS[] = {50, 50, 65, 50};
  }
}