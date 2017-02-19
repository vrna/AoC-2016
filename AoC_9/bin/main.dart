import 'dart:io';
import 'dart:async';

main(List<String> args) {
  var inputfile = new File("input.txt");
  String input = inputfile.readAsStringSync();
  //String input = "X(8x2)(3x3)ABCY";
  input = input.replaceAll(" ","");

  //print(output);
  print("part 1: " + part1(input).toString());
  print("part 2: " + part2(input).toString());
}

int part1 (String input) {
  input = input.replaceAll(" ","");
  String output = "";

  RegExp markerSyntax = new RegExp(r"\([0-9]+x[0-9]+\)");
  bool endOfInput = false;

  while( !endOfInput) {

    Match match = markerSyntax.firstMatch(input);

    if( match != null ) {
      String before = input.substring(0, match.start);
      output += before;

      String marker = input.substring(match.start, match.end);
      int selectionLength = int.parse(marker.split("x")[0].replaceAll("(", ""));
      int repetition = int.parse(marker.split("x")[1].replaceAll(")", ""));
      String selection = input.substring(
          match.end, match.end + selectionLength);
      String sequenced = selection * repetition;
      output += sequenced;
      input = input.substring(match.start + marker.length + selectionLength);
      //print( "repeat " + selection + " for " + repetition.toString() + " times");
    }
    else {
      output += input;
      endOfInput = true;
    }

    //print(output);
  }

    return output.length;
}


int part2 (String input) {
  int length = lengthOfAnArea(input );
  return length;
}

int lengthOfAnArea(String input)
{
  RegExp markerSyntax = new RegExp(r"\([0-9]+x[0-9]+\)");
  bool endOfInput = false;
  int length = 0;
  while( !endOfInput) {
    Match match = markerSyntax.firstMatch(input);

    if( match != null) {
      String before = input.substring(0, match.start);
      length += before.length;

      String marker = input.substring(match.start, match.end);
      int selectionLength = int.parse(marker.split("x")[0].replaceAll("(", ""));
      int repetition = int.parse(marker.split("x")[1].replaceAll(")", ""));
      String selection = input.substring(
          match.end, match.end + selectionLength);

      length = length + repetition * lengthOfAnArea(selection);
      input = input.substring(match.start + marker.length + selectionLength);
    }
    else
    {
      length += input.length;
      endOfInput = true;
    }
  }
  return length;

}