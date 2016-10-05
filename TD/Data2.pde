DATA data = new DATA();

class DATA {
  int startPosX = -25, startPosY = 75;
  //{ ENEMY ID , AMT , DELAY (MILLIS) }
  String waves[][][] = {
    {{"1000"}, {"basic", "5", "1000"}},
    //{},
  };
  TOWER tower = new TOWER();
  class TOWER {
    String name[] = {"Basic Turret", "Laser Turret", "Twin Turret"};
    int txtSize[] = {15, 15, 15};
    PImage baseP[] = {loadImage("")};
    PImage barlP[] = {loadImage("")};
    STATS stats = new STATS();
    class STATS {
      int cost[] = {150, 250, 400};
      int range[] = {400, 750, 350};
      float reload[] = {70, 20, 35};
      float damage[] = {20, 5, 20};
      boolean AoE[] = {false, false, false};
      boolean DoT[] = {false, false, false};
    }
  }
}