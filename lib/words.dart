
import 'word20k.dart';
// generate all possible combinations of the input

bool isWord(String wordToCheck) {
  int min = 0;
  int max = word20k.length;
  while (min < max) {
    int mid = min + ( (max - min) >> 1);
    var element = word20k[mid];
    int comp =  element.compareTo(wordToCheck);
    if (comp == 0) {
      return true;
    }
    if (comp < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return false ;
}


class Unscramble
{
  String word = "";
  List<int> letters;
  int wordLength = 0;

  void setWord(String newWord)
  {
    word = newWord;
    letters = word.runes.toList();
    letters.sort((int a, int b) => a.compareTo(b));
  }

  int getLength()
  {
    return this.word.length;
  }

  List<int> getLetters()
  {
    return letters;
  }

  int matchLetter(int possibleChar, List<int> allLetters ) {
    int min = 0;
    int max = allLetters.length;
    while (min < max) {
      int mid = min + ( (max - min) >> 1);
      var element = allLetters[mid];
      int comp =  element.compareTo(possibleChar);
      if (comp == 0) {
        return mid;
      }
      if (comp < 0) {
        min = mid + 1;
      } else {
        max = mid;
      }
    }
    return -1 ;
  }

  bool contain(List<int> words) {
      List<int> lettersCopy = new List<int>.from(letters);
      bool allMatch = true;
      for(var c in words) {
        var indexOfLetter = matchLetter(c, lettersCopy);
        if ( indexOfLetter == -1 ) {
          allMatch = false;
          break;
        } else {
          lettersCopy.removeAt(indexOfLetter);
        }
      }
      return allMatch;
  }
}


class Unscrambler
{
  static List<String> run(String inputWord) {
    List<String> foundWords  = [];
    List<String> groupedWords = [];
    Unscramble unscramble = new Unscramble();
    unscramble.setWord(inputWord);
    for (int i = 0; i < word20k.length; i++) {
      if (word20k[i].length > 2) {
        List<int> dictLetters = word20k[i].runes.toList();
        dictLetters.sort((a, b) => a.compareTo(b));
        if (unscramble.contain(dictLetters)) {
          foundWords.add(word20k[i]);
        }
      }
    }


    if (foundWords.length > 0) {
      foundWords.sort((a, b) => a.length.compareTo(b.length));
      int length = foundWords[0].length;
      String group = "";
      foundWords.forEach((el) {
        if (el.length > length) {
          length = el.length;
          groupedWords.add(group);
          group = el + " ";
        } else {
          group += el + " ";
        }
      });
      groupedWords.add(group);
    }
    return groupedWords;
  }
}

Iterable<String> getWords(String letters)  {

  List<String> c = [];
  String chars = "";
  letters.runes.forEach((int rune) {
    if ((rune >=97) && (rune <= 122)) {
      var character = new String.fromCharCode(rune);
      chars += character;
    }
  });
  c = Unscrambler.run(chars);
  return c;

}






