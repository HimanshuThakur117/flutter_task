import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/get_detail_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/api_url.dart';
import 'data_bloc_event.dart';
import 'data_bloc_state.dart';



class DataBloc extends Bloc<DataEvent, DataState> {
  final List<Details> _tempList = [] ;
  int page = 1;
  int currentIndex = 0;
  bool isLoadingdata = false;
  DataBloc() : super(InitialDataState());
  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {

    if (event is FetchDataEvent) {
      page = event.page;

      yield LoadingDataState();

      try {
        final response = await http.post(
          Uri.parse(ApiUrls.getBaseUrl()+ApiUrls.details),
          headers: {
            'Content-type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"pageNumber": page}),
        );
        print('Response status: ${response.statusCode}');


        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print(data.toString());

          for(int i =0; i<data.length; i++)
          {
            _tempList.add(Details.fromJSON(data["result"][i])) ;
            print("---------------list----------$i");
          }

          yield LoadedDataState( fetchedData: _tempList, currentPage: page,
            isLoadingMore: isLoadingdata);
        } else {
          yield ErrorDataState('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        yield ErrorDataState('Error: $e');
      }

    }else{

    }
  }
}