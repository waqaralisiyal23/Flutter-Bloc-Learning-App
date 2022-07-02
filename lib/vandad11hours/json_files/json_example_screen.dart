import 'package:bloclearning/res/constants.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/bloc_actions.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/person.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/persons_bloc.dart';
import 'package:bloclearning/vandad11hours/services/local_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JsonExampleScreen extends StatelessWidget {
  const JsonExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json Exxample'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                              url: Constants.person1Url,
                              loader: LocalApi.getPersons,
                            ),
                          );
                    },
                    child: const Text('Load Json #1'),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      context.read<PersonsBloc>().add(
                            const LoadPersonsAction(
                              url: Constants.person2Url,
                              loader: LocalApi.getPersons,
                            ),
                          );
                    },
                    child: const Text('Load Json #2'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<PersonsBloc, FetchResult?>(
                buildWhen: (previousResult, currentResult) {
                  // return true/false to determine whether or not to rebuild
                  // the widget with the state.
                  return previousResult?.persons != currentResult?.persons;
                },
                builder: (context, fetchResult) {
                  final List<Person>? persons = fetchResult?.persons;
                  if (persons == null) {
                    return const SizedBox();
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        Person person = persons[index];
                        return ListTile(
                          title: Text(person.name),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
