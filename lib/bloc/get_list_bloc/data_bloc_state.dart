

import 'package:flutter_task/models/get_detail_model.dart';

abstract class DataState {}

class InitialDataState extends DataState {}

class LoadingDataState extends DataState {}

class LoadedDataState extends DataState {
  List<Details> fetchedData;
  final int currentPage;
  final bool isLoadingMore;
  LoadedDataState( {required this.fetchedData, required this.currentPage,  required this.isLoadingMore, });
}
class ErrorDataState extends DataState {
  final String error;

  ErrorDataState(this.error);
}