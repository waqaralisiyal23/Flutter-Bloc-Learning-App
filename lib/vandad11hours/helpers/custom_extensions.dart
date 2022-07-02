import 'dart:math' as math;

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

extension IsEqualIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

// extension UrlString on PersonUrl {
//   String get urlString {
//     switch (this) {
//       case PersonUrl.persons1:
//         return 'http://127.0.0.1:5500/api/persons1.json';
//       case PersonUrl.persons2:
//         return 'http://127.0.0.1:5500/api/persons2.json';
//     }
//   }
// }
