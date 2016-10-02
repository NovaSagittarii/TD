DATA data = new DATA();

class DATA {
  TOWER tower = new TOWER();
  class TOWER {
    String name[] = {"Basic Turret", "Laser Turret", "Twin Turret"};
    int txtSize[] = {15, 15, 15};
    PImage baseP[] = {loadImage("")};
    PImage barlP[] = {loadImage("")};
    STATS stats = new STATS();
    class STATS {
      int cost[] = {150, 250, 400};
      float reload[] = {100, 40, 50};
      float damage[] = {50, 20, 50};
      boolean AoE[] = {false, false, false};
    }
  }
}