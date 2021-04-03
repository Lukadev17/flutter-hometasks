import 'dart:io';
import 'dart:math';

void main() {
  print("Welcome to dice game!");
  diceGame();
}

  diceGame() {
    final random = Random();
    int userScore = 0;
    int computerScore = 0;

    while (true) {
      print("type 'exit' to stop the game, or type 'roll' to start Rolling the dice: ");
      String userChoice = stdin.readLineSync()!.toLowerCase();
      if (userChoice == "exit") {
        print("\nBye Bye!\nYou: $userScore Computer: $computerScore");
        if (userScore > computerScore) {
          print("User won with score $userScore");
          break;
        }
        else if (computerScore > userScore) {
          print("Computer won with score $computerScore");
          break;
        } else {
          print("match over with tie");
          break;
        }
      }

      int userTry = (random.nextInt(6) + 1) + (random.nextInt(6) + 1);
      int computerTry = (random.nextInt(6) + 1) + (random.nextInt(6) + 1);

      if (userTry > computerTry) {
        print("User win : $userTry > $computerTry ");
        userScore += 1;
      } else if (computerTry > userTry) {
        print("computer wins : $computerTry > $userTry ");
        computerScore += 1;
      } else {
        print("tie:$userTry = $computerTry ");
      }
    }
}
