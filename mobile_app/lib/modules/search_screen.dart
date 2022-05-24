import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/shared/bloc/search_cubit/cubit.dart';
import 'package:mobile_app/shared/bloc/search_cubit/states.dart';
import 'package:mobile_app/shared/components/components.dart';
import 'package:mobile_app/shared/styles/constant.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var textController;

    return BlocProvider(
      create: (context) => AppSearchCubit(),
      child: BlocConsumer<AppSearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is AppSearchErrorStates) {
            Fluttertoast.showToast(
              msg: "There are no in Search",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          } else {}
        },
        builder: (context, state) {
          var list = AppSearchCubit.get(context).search;
          // var listOfPatient = AppSearchCubit.get(context).patientSearch;
          var cubit = AppSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: scaffoldColor,
              elevation: 0,
              leading: buildPopMenuButton(context),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      textFormField(
                          keyboardType: TextInputType.text,
                          radius: 40,
                          controller: searchController,
                          onChange: (text) {
                            textController = text;
                            cubit.getSearch(text);
                            // cubit.getPatientSearch(text);
                          },
                          hint: 'Search',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'search must not be empty';
                            } else {
                              FocusScope.of(context).unfocus();
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      // if (state is AppSearchLoadingStates)
                      // LinearProgressIndicator(color: pinkColor),
                      Expanded(
                          child: searchBuilder(list, context, isSearch: true)),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
