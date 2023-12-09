import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/models/get_detail_model.dart';
import 'package:flutter_task/service/auth_services.dart';

import '../../bloc/get_list_bloc/data_bloc.dart';
import '../../bloc/get_list_bloc/data_bloc_event.dart';
import '../../bloc/get_list_bloc/data_bloc_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleServices googleServices = GoogleServices();
  late ScrollController _scrollController;
  late DataBloc dataBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    dataBloc = BlocProvider.of<DataBloc>(context);
    _scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
      dataBloc.add(FetchDataEvent(page : dataBloc.page + 1));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Show Data',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            googleServices.handleSignOut(context);
          }, icon: Icon( Icons.logout_outlined))
        ],
      ),
      body: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
        if (state is LoadedDataState) {
          return SafeArea(
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics:  ScrollPhysics(),
                itemCount: state.fetchedData.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < state.fetchedData.length) {
                    return Card(state.fetchedData[index]);
                  } else {
                    return state.isLoadingMore ? const Center(
                      child: CircularProgressIndicator(),) : Container();
                  }}
            ),
          );
        } else if (state is ErrorDataState) {
          return const Text('Error: Something went wrong or connection lost');
        } else {
          // Handle other states if needed
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

}



Widget Card( Details showData,) {
  return   Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
    child: Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child:  Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: showData.imgUrl!=''?NetworkImage(showData.imgUrl):NetworkImage("https://www.seiu1000.org/sites/main/files/imagecache/hero/main-images/camera_lense_0.jpeg"),
                  radius: 50,
                  /*child:  ClipRRect(child: Image.network("https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg")
                  ),*/
                ),
              ],
            ),
          const  SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Full Name: ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        showData.fullName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Label: ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        showData.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


