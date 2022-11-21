import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/data_view_model.dart';

class DataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: context.watch<DataViewModel>().state == DataState.BUSY
            ? buildLoadingWidget()
            : context.watch<DataViewModel>().state == DataState.ERROR
            ? buildErrorWidget()
            : buildListView(context));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Github Jobs'),
    );
  }

  Center buildErrorWidget() => Center(child: Text('Something went wrong!'));

  Center buildLoadingWidget() => Center(child: CircularProgressIndicator());

  ListView buildListView(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, index) => buildListItem(context, index));
  }

  Widget buildListItem(BuildContext context, int index) {
    final data = context.read<DataViewModel>().dataList[index];
    return Card(
      child: ListTile(
        title: Text(data.authorName.toString()),
      ),
    );
  }
}
