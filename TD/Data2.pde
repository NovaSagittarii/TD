DATA data = new DATA();
class DATA {
  int startPosX = -25, startPosY = 75;
  //First { LEVEL DELAY (MILLIS), LEVEL COMPLETION REWARD }
  //{ ENEMY ID , AMT , DELAY (MILLIS) }
  String waves[][][] = {
    {{"1000", "100"}, {"start", "20", "1500"}},
    {{"5000", "120"}, {"basic1", "5", "1000"}},
    {{"5000", "140"}, {"basic1", "15", "900"}},
    {{"5000", "160"}, {"basic2", "4", "900"}, {"basic1", "14", "1000"}},
    {{"5000", "180"}, {"basic2", "4", "1250"}, {"basic1", "5", "500"}},
    {{"5000", "350"}, {"basic3", "2", "2000"}, {"basic1", "5", "500"}},
    {{"5000", "200"}, {"heavy1", "3", "1500"}, {"basic9", "1", "2000"}, {"TINY", "5", "2000"}},
    {{"5000", "220"}, {"heavy1", "3", "2500"}, {"heavy2", "1", "2500"}},
    {{"5000", "240"}, {"heavy2", "3", "2500"}, {"basic", "5", "500"}, {"heavy3", "4", "2500"}},
    {{"5000", "260"}, {"heavy3", "3", "2500"}, {"basic3", "5", "1000"}, {"heavy2", "4", "2500"}},
  };
  TOWER tower = new TOWER();
  ESTAT enemyStats = new ESTAT();
  class TOWER {
    //DMG POWER:         286              571            856              1250
    String name[] = {"Basic Turret", "Advanced Turret", "Gatling Turret", "Sniper Turret"};
    String desc[] = {"Your average cheapo turret.", "Upgraded basic turret\nwith more upgrades", "Rapid-fire bullet\nsprayer, low damage", "Slow long-range, high damage"};
    int txtSize[] = {15, 12, 13, 13};
    PImage baseP[] = {loadImage("")};
    PImage barlP[] = {loadImage("")};
    STATS stats = new STATS();
    class STATS {
      int cost[] = {40, 100, 240, 450};
      int range[] = {400, 350, 450, 800};
      int pierce[] = {1, 1, 3, 5};
      float accuracy[] = {0, 0, 15, 0}; //Degrees of offset
      float reload[] = {70, 35, 7, 400};
      float damage[] = {20, 25, 2, 100};
      float bspeed[] = {7, 7, 10, 12};
      boolean AoE[] = {false, false, false, false};
      boolean DoT[] = {false, false, false, false};
    }
  }
  class ESTAT {
    String name[] = {"TINY", "start", "basic1", "basic2", "basic3", "basic9", "heavy1", "heavy2", "heavy3"};
    int maxhp[] = {100, 50, 100, 250, 200, 2500, 850, 1000, 1400};
    int maxsh[] = {100, 10, 0, 200, 400, 500, 150, 200, 200};
    float sp[] = {2, 1.5, 2, 1, 1.5, 1, 0.7, 0.5, 0.4};
    float def[] = {0, 0, 0, 0, 0, 10, 5, 5, 7};
    int value[] = {25, 3, 5, 10, 20, 500, 20, 30, 45};
    int hitbox[] = {8, 12, 14, 17, 17, 24, 15, 17, 18};
    int dmg[] = {1, 1, 1, 1, 1, 10, 2, 2, 2};
  }
}