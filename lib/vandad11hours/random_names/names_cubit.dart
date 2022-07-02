import 'package:bloclearning/vandad11hours/helpers/custom_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamesCubit extends Cubit<String?> {
  // It needs a initial state
  NamesCubit() : super(null);

  final List<String> names = [
    'Waqar',
    'Ahmed',
    'Usama',
    'Uzair',
  ];

  void pickRandomName() => emit(names.getRandomElement());
}
