import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/features/presentation/bloc/data_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DataBloc dataBloc;

  @override
  void initState() {
    dataBloc = DataBloc()..add(const DataEvent());
    super.initState();
  }

  String formatDate(String dateTime) {
    if (dateTime.isEmpty) {
      return "";
    }
    return DateFormat("d.MM.y").format(
      DateTime.tryParse(dateTime) ?? DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: dataBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Data"),
        ),
        body: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            print("${state.dataStatus}");
            final data = state.list;
            if (state.dataStatus.isSuccess) {
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0,
                    thickness: 1,
                    color: Colors.red,
                  );
                },
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListTile(
                    title: Text(
                      item.text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(formatDate(
                      item.updatedAt,
                    )),
                  );
                },
              );
            } else if (state.dataStatus.isInProgress) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.black,
                ),
              );
            } else {
              return Center(
                child: Text("Yuklashda Xatolik"),
              );
            }
          },
        ),
      ),
    );
  }
}
