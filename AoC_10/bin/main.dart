//import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:collection';

bool debug = false;
bool debug_containes = false;
HashMap<String, Bot> bots_ = new HashMap<String, Bot> ();
HashMap<String, Output> outputs_ = new HashMap<String, Output> ();

main(List<String> args) {

    //init();
    var path = "input.txt";

    var config = new File(path);
    List<String> lines = config.readAsLinesSync();
    for (var l in lines) handleLine (l);

    if (debug || debug_containes) {
      bots_.forEach(printBot);
      outputs_.forEach(printOutput);
    }

    // part 2
    print ( multiply());
}

// used for demo part, wasn't sure first if required in the final
void init() {
  getContainer("bot","1").addChip(3);
  getContainer("bot","2").addChip(2);
  getContainer("bot","2").addChip(5);
}

void printBot(key, value) {
  print ("Bot " + bots_[key].contents());
}
void printOutput(key, value) {
  print ("Output " + outputs_[key].contents());
}

handleLine( String line) {

  // bot 2 gives low to bot 1 and high to bot 0
  //value 3 goes to bot 1
  //bot 1 gives low to output 1 and high to bot 0
  //bot 0 gives low to output 2 and high to output 0
  //value 2 goes to bot 2
  if( debug ) {
    print("Handling: " + line);
  }
  if( line.startsWith("value")) {
    // value 5 goes to bot 2
    List<String> words = line.split(" ");

    int chipValue = int.parse(words[1]);
    String botID = words[5];
    Container bot = getContainer("bot",words[5]);

    bot.addChip(chipValue);

  }
  else if( line.startsWith("bot")) {
    //bot 1 gives low to output 1 and high to bot 0
    // 0  1  2     3   4   5    6  7   8    9  10  11
    List<String> words = line.split(" ");
    Bot giver = getContainer("bot",words[1]);
    Container target1 = getContainer(words[5],words[6]);
    bool high1 = words[3] == "high";
    Container target2 = getContainer(words[10],words[11]);
    bool high2 = words[8] == "high";

    List<Transaction> actions = new List<Transaction>();
    actions.add(new Transaction(target1,high1));
    actions.add(new Transaction(target2,high2));

    giver.handout(actions);
  }
  else
  {
    throw new Exception("Please write an implementation for line like: " + line);
  }

}

int multiply( ){
  int sum = 1;
  if(outputs_.containsKey("0")) {
    sum *= outputs_["0"].multiply();
  }
  if(outputs_.containsKey("1")) {
    sum *= outputs_["1"].multiply();
  }
  if(outputs_.containsKey("2")) {
    sum *= outputs_["2"].multiply();
  }

  return sum;
}

Container getContainer(String type, String id) {
  if( type == "bot") {
    bots_.putIfAbsent(id, () => new Bot(id));
    return bots_[id];
  }
  else if( type == "output") {
    outputs_.putIfAbsent(id, () => new Output(id));
    return outputs_[id];
  }
}

abstract class Container {
  List<int> chips_ = new List<int>();
  String id_ = null;

  Container(this.id_) {
  }

  void handOut( List< Transaction> transactions) {

  }

  void addChip( int chip) {
    chips_.add(chip);
    chips_.sort();
    if( debug ) {
      print("Added chip " + chip.toString() + " to " + id_);
    }
  }

  int takeHigh() {
    int high = chips_.last;
    chips_.remove(chips_.last);
    return high;
  }

  int takeLow() {
    int low = chips_.first;
    chips_.remove(chips_.first);
    return low;

  }

  String contents() {
    return id_ + ": " + chips_.join(", ");
  }


}



class Bot extends Container {
  int requiredNumberOfChips_ = 2;
  List<Transaction> queue_ = new List<Transaction>();

  Bot(String id) : super(id) {

  }

  handout( List< Transaction> transactions)
  {
    queue_.addAll(transactions);
    if( chips_.length == requiredNumberOfChips_) {
      clearQueue();
    }
  }

  void clearQueue() {
    if(debug) {
      print ("bot " + id_ + " clears its queue");
    }

    for( int i = 0; i < queue_.length; ++i) {
      Transaction currentTransaction = queue_[i];

      int chip = null;

      if( currentTransaction.high_) {
        chip = takeHigh();
      }
      else {
        chip = takeLow();
      }

      currentTransaction.target_.addChip(chip);
    }

    queue_.clear();

  }

  void addChip( int chip) {
    super.addChip(chip);
    if( chips_.contains(61) && chips_.contains(17)) {
      print ("bot " + id_ + " is responsible!");
    }
    if( chips_.length == requiredNumberOfChips_) {
      clearQueue();
    }



  }
}
class Output extends Container {

  Output(String id) : super(id) {

  }

  handout( List<Transaction> transaction) {
    throw new Exception("Output shouldn't be handing anything!");
  }

  int multiply()
  {
    int basis = 1;
    for( int chip in chips_) {
      basis *= chip;
    }

    return basis;
  }
}

class Transaction {
  Container target_ = null;
  bool high_ = null;

  Transaction(this.target_, this.high_) {
  }
}