import 'package:flutter/material.dart';
import 'week_one_ful_body_beginner.dart';

class CheckWorkout {
  WeekOneLowerBodyBeginnerGym weekOneLowerBodyBeginnerGym =
      WeekOneLowerBodyBeginnerGym();
  List getExercise(
      {@required level,
      @required workoutType,
      @required place,
      @required week}) {
    List filterExcercises = [];
    List levelFilter = [];
    List workoutTypeFilter = [];

    List placeFilter = [];
    List weekFilter = [];
    filterExcercises = weekOneLowerBodyBeginnerGym.exerciseData[1]['exercises'];
    levelFilter =
        filterExcercises.where((element) => element['level'] == level).toList();
    workoutTypeFilter = levelFilter
        .where((element) => element['workoutType'] == workoutType)
        .toList();
    placeFilter = workoutTypeFilter
        .where((element) => element['place'] == place)
        .toList();
    weekFilter =
        placeFilter.where((element) => element['week'] == week).toList();

    weekFilter.sort((a, b) => a['circuit'].compareTo(b['circuit']));
    // weekFilter.sort((a, b) => (b.age).compareTo(a.age));
    print(weekFilter.length);
    return weekFilter;
  }

  List getEquipments(
      {@required level,
      @required workoutType,
      @required place,
      @required week}) {
    List filterExcercises = [];
    List levelFilter = [];
    List workoutTypeFilter = [];

    List placeFilter = [];
    List weekFilter = [];
    // List orderByFilter = [];
    filterExcercises =
        weekOneLowerBodyBeginnerGym.exerciseData[0]['equipments'];
    levelFilter =
        filterExcercises.where((element) => element['level'] == level).toList();
    workoutTypeFilter = levelFilter
        .where((element) => element['workoutType'] == workoutType)
        .toList();
    placeFilter = workoutTypeFilter
        .where((element) => element['place'] == place)
        .toList();
    weekFilter =
        placeFilter.where((element) => element['week'] == week).toList();
    // weekFilter.forEach(( element) {});

    print('${weekFilter.length}' + 'Equipments');
    return weekFilter;
  }

  List getActivations(
      {@required level,
      @required workoutType,
      @required place,
      @required week}) {
    List filterExcercises = [];
    List levelFilter = [];
    List workoutTypeFilter = [];

    List placeFilter = [];
    List weekFilter = [];
    // List orderByFilter = [];
    filterExcercises =
        weekOneLowerBodyBeginnerGym.exerciseData[2]['activations'];
    levelFilter =
        filterExcercises.where((element) => element['level'] == level).toList();
    workoutTypeFilter = levelFilter
        .where((element) => element['workoutType'] == workoutType)
        .toList();
    placeFilter = workoutTypeFilter
        .where((element) => element['place'] == place)
        .toList();
    weekFilter =
        placeFilter.where((element) => element['week'] == week).toList();
    // weekFilter.forEach(( element) {});

    print('${weekFilter.length}' + 'Equipments');
    return weekFilter;
  }
}
