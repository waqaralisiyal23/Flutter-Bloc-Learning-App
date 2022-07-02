import 'package:bloclearning/vandad11hours/json_files/bloc/bloc_actions.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/person.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const List<Person> mockedPersons1 = [
  Person(name: 'Waqar Ali Siyal', age: 22),
  Person(name: 'Ahmed Ali Siyal', age: 26),
];

const List<Person> mockedPersons2 = [
  Person(name: 'Usama Shaikh', age: 21),
  Person(name: 'Imtiaz Ahmed', age: 16),
];

Future<List<Person>> mockGetPersons1(String _) => Future.value(mockedPersons1);
Future<List<Person>> mockGetPersons2(String _) => Future.value(mockedPersons2);

void main() {
  group('Testing Bloc', () {
    // Write our tests

    late PersonsBloc bloc;

    // Runs before when every test runs
    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test Initial State',
      build: () => bloc,
      verify: (bloc) => expect(bloc.state, null),
    );

    // Fetch mock data (persons1) and compare it with FetchResult
    blocTest(
      'Mock retrieveing persons from first list',
      build: () => bloc,
      act: (PersonsBloc bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_1',
            loader: mockGetPersons1,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_1',
            loader: mockGetPersons1,
          ),
        );
      },
      expect: () => [
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons1, isRetrievedFromCache: true),
      ],
    );

    // Fetch mock data (persons2) and compare it with FetchResult
    blocTest(
      'Mock retrieveing persons from second list',
      build: () => bloc,
      act: (PersonsBloc bloc) {
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_2',
            loader: mockGetPersons2,
          ),
        );
        bloc.add(
          const LoadPersonsAction(
            url: 'dummy_url_2',
            loader: mockGetPersons2,
          ),
        );
      },
      expect: () => [
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: false),
        const FetchResult(persons: mockedPersons2, isRetrievedFromCache: true),
      ],
    );
  });
}
