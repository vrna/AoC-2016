import 'dart:io';
import 'dart:collection';

bool debug = false;

HashMap<String, State> visitedStates_ = new HashMap<String,State>();
Queue<State> queue_ = new Queue<State>();

main(List<String> args) {

  State initial = init("input2.txt");

  queue_.add(initial);
  State finalState = processQueue();

  if(finalState != null) {
    print("Final state, part 1:");
    print(finalState.printState());
    print(finalState.depth_);
  }


}

State processQueue() {
  while( queue_.isNotEmpty) {
    State current = queue_.removeFirst();

    if(debug) {
      print(current.depth_.toString());
      print(current.printState());
    }
    if( current.isFinal()){
      return current;
    }

    String hash = current.hash();
    if( !visitedStates_.containsKey(hash ) ) {
      queue_.addAll(current.possibleStates());
      visitedStates_.putIfAbsent(hash, () => current);
    }
  }
}


State init(String path) {
/*
The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.
 */
  State initial = new State();
  var config = new File(path);
  List<String> lines = config.readAsLinesSync();
  for (var l in lines) createFloor (initial,l);

  initial.floors_[0].elevator_ = new Elevator();

  return initial;
}

void createFloor(State initial, String line) {
  Floor floor = new Floor(null);
  List<String> words = line.split(" a ");

  for( int i = 1; i < words.length; ++i) {
    String word = words[i];

    if( word.contains("microchip")) {
      String material = word.split("-")[0];

      floor.particles_.add(new Microchip(material));
    }
    else if( word.contains("generator")) {
      String material = word.split(" ")[0];

      floor.particles_.add(new Generator(material));
    }

  }

  initial.floors_.add(floor);
}

int shortestFoundPath_ = 999999999;

class State {
  int depth_ = 0;
  List<Floor> floors_ = new List<Floor> ();

  State parent_ = null;
  List<State> children_ = new List<State>();

  State() {
  }

  String hash() {
    String floorDelimiter = "[F]";
    String particleDelimiter = "-";
    String hash = "";

    for(Floor f in floors_) {
      if(f.elevator_ != null) {
        hash += "E";
        hash += particleDelimiter;
      }

      List<String> hashed = new List<String>();
      for(Particle p in f.particles_) {
        hashed.add(p.print());
      }

      hashed.sort();
      hash += hashed.join(particleDelimiter);
      hash += floorDelimiter;
    }

    return hash;
  }

  bool isValid() {
    // "if a chip is ever left in the same area as another RTG, and it's not connected to its own RTG, the chip will be fried"
    for( Floor floor in floors_) {
      for( Particle prt in floor.particles_)
      {
        if( prt.type_ == "microchip") {
          bool containsViciousGenerator = false;
          bool containsFriendlyGenerator = false;
          for (Particle innerPrt in floor.particles_) {
            if(innerPrt.type_ == "generator") {
              if(innerPrt.material_ == prt.material_) {
                containsFriendlyGenerator = true;
              }
              else {
                containsViciousGenerator = true;
              }
            }
          }

          if(containsViciousGenerator && !containsFriendlyGenerator) {
            return false;
          }
        }
      }
    }

    return true;
  }

  bool isFinal() {
    // state is final state if all the chips are in fourth floor
    for(int i = 0; i < floors_.length - 1;++i) {
      if( floors_[i].particles_.length > 0 ) {
        return false;
      }
    }

    return true;
  }

  String printState() {
    String separator = "\t";
    String lineFeed = "\n";
    String wholeOutput = "";
    for(int i = floors_.length - 1; i >= 0; --i) {

      String printed = "F" + (i+1).toString();
      printed += separator;

      if(floors_[i].elevator_ == null) {
        printed += ".";
      }
      else {
        printed += "E";
      }

      for(var p in floors_[i].particles_) {
        printed += separator;
        printed += p.print();
      }

      printed += lineFeed;
      wholeOutput += printed;
    }

    return wholeOutput;
  }

  List<State> possibleStates() {
    // actions are only possible in the floor where elevator is
    // person can take 1-2 particles and move up or down
    // "if a chip is ever left in the same area as another RTG, and it's not connected to its own RTG, the chip will be fried"

    List<State> possibleStates = new List<State>();

    // find current floor
    Floor currentFloor = floors_.firstWhere((f) => f.elevator_ != null);
    int floorIndex = floors_.indexOf(currentFloor);

    // find combos
    List< List< Particle > > combos = new List< List<Particle>>();

    for( Particle prt in currentFloor.particles_) {
      // it's possible to carry just one B)
      List<Particle> lone = new List<Particle>();
      lone.add(prt);
      combos.add(lone);

      for( Particle innerPrt in currentFloor.particles_) {
        if( prt.type_ == "microchip" && innerPrt.type_ == "generator" && prt.type_ != innerPrt.type_) {
          // foo
        }
        else if(prt != innerPrt) {
          List<Particle> pair = new List<Particle> ();
          pair.add(prt);
          pair.add(innerPrt);
          combos.add(pair);
        }
      }
    }

    for( List<Particle> pair in combos) {
      State movingUp = CopyState(floorIndex, 1, pair);
      State movingDown = CopyState(floorIndex, -1,pair);

      if(movingUp != null && movingUp.isValid()) {
        possibleStates.add(movingUp);
      }

      if( movingDown != null && movingDown.isValid()) {
        possibleStates.add(movingDown);
      }
    }

    return possibleStates;
  }

  State CopyState(int floorIndex, int direction, List<Particle> pair) {
    if( floorIndex + direction < 0 || floorIndex + direction >= floors_.length) {
      return null;
    }

    State copy = new State();
    copy.parent_ = this;
    copy.depth_ = this.depth_ + 1;

    for(Floor fl in floors_) {
      copy.floors_.add(fl.copy());
    }

    Floor oldFloor = copy.floors_[floorIndex];
    Floor newFloor = copy.floors_[floorIndex + direction];
    newFloor.elevator_ = oldFloor.elevator_;
    oldFloor.elevator_ = null;

    for(Particle prt in pair) {
      oldFloor.particles_.remove(prt);
      newFloor.particles_.add(prt);
    }

    return copy;
  }


}

class Floor {
  List<Particle> particles_ = new List<Particle>();
  Elevator elevator_ = null;

  Floor( this.elevator_ ) {
  }

  Floor copy() {
    List<Particle> copyOfParticles = new List<Particle>();
    copyOfParticles.addAll(particles_);

    Floor copy = new Floor(elevator_);
    copy.particles_ = copyOfParticles;

    return copy;
  }
}

abstract class Particle {
  String material_ = "";
  String type_ = ""; // yeah could go with enum

  Particle(this.type_,this.material_) {}

  String print() {
    return material_[0].toUpperCase() + material_[1] + type_[0].toUpperCase();
  }

}

class Microchip extends Particle {
  Microchip(String material) : super("microchip",material) { }

}

class Generator extends Particle {
  Generator(String material) : super("generator",material) { }
}

class Elevator {
}