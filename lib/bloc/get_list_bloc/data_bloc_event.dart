// Events

abstract class DataEvent {}

class FetchDataEvent extends DataEvent {
  final int page;

  FetchDataEvent({required this.page});
}
class FetchMoreDataEvent extends DataEvent {

}

