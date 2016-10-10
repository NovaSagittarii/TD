DATA data = new DATA();
class DATA {
  int startPosX = -25, startPosY = 75;
  //{ ENEMY ID , AMT , DELAY (MILLIS) }
  String waves[][][] = {
    {{"1000"}, {"basic1", "5", "1000"}},
    {{"5000"}, {"basic1", "10", "500"}},
    {{"5000"}, {"basic2", "4", "1250"}, {"basic", "5", "500"}},
    {{"5000"}, {"basic3", "2", "2000"}},
    {{"5000"}, {"heavy1", "3", "1500"}, {"basic9", "1", "2000"}},
    {{"5000"}, {"heavy1", "3", "2500"}, {"heavy2", "1", "2500"}},
    {{"5000"}, {"heavy2", "3", "2500"}, {"basic", "5", "500"}, {"heavy3", "4", "2500"}},
    {{"5000"}, {"heavy3", "3", "2500"}, {"basic3", "5", "1000"}, {"heavy2", "4", "2500"}},
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
      float reload[] = {70 /*should be 70*/, 2 /*should be 10*/, 35};
      float damage[] = {20, 1 /*should be 5*/, 20};
      boolean AoE[] = {false, false, false};
      boolean DoT[] = {false, false, false};
    }
  }
  class ESTAT {
    String name[] = {"basic1", "basic2", "basic3", "basic9", "heavy1", "heavy2", "heavy3"};
    int maxhp[] = {100, 250, 200, 2500, 850, 1000, 1400};
    int maxsh[] = {0, 200, 400, 500, 150, 200, 200};
    float sp[] = {2, 1, 1.5, 1, 0.7, 0.5, 0.4};
    float def[] = {0, 0, 0, 10, 5, 5, 7};
    int value[] = {5, 10, 15, 500, 20, 25, 35};
    int hitbox[] = {14, 17, 17, 24, 15, 17, 18};
    int dmg[] = {1, 1, 1, 10, 2, 2, 2};
  }
}