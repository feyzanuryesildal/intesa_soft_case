import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/data_view_model.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  var size,height,width;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: buildAppBar(),
          body: context.watch<DataViewModel>().state == DataState.BUSY
              ? buildLoadingWidget()
              : context.watch<DataViewModel>().state == DataState.ERROR
              ? buildErrorWidget()
              : buildListView(context))
    ;
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
    size = MediaQuery.of(context).size*0.05;
    height = size.height;
    width = size.width;
    bool num= false;
    final data = context.read<DataViewModel>().dataList[index];
    return Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(data.authorName.toString()),
              subtitle: Text(data.authorName.toString()),
              leading:CircleAvatar(backgroundImage: NetworkImage("${data.authorProfileImage}"),) ,
            ),
            Text("${data.description}"),
            SizedBox(
              height: height/5,
            ),
            Container(
              child: Image.network("${data.media}"),
            ),
            SizedBox(
              height: height/5,
            ),
            Row(children: [ // like and dislike count
              Column(
                children: [
                  Icon(Icons.handshake_outlined, color: Colors.yellow,),
                  Text("${data.likeCount}"),
                ],
              ),
              SizedBox(
                width: width,
              ),
              Column(children: [
                Icon(Icons.front_hand, color: Colors.yellow,),
                Text("${data.disLikeCount}"),
              ],),
              SizedBox(
                width: width,
              ),
              Column(
                children: [
                  Icon(Icons.comment, color: Colors.yellow,),
                  Text("${data.comments!.length}"),
                ],
              ),
            ],),
            SizedBox(
              height: height/5,
            ),
            Container(
              height: height*2,
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage("${data.comments![1].authorProfileImage}"),),
                subtitle: Text("${data.comments![1].description}"),
                title: Text("${data.comments![1].authorName}"),
              ),
            ),
            Text("diğer yorumları gör...",style: TextStyle(color: Colors.grey),),
            SizedBox(
              height: height/5,
            ),
            Container(
              height: height*5/3,
              width: width*17,
              child: InputDecorator(
                decoration: InputDecoration(


                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(


                        backgroundImage: NetworkImage("${data.comments![1].authorProfileImage}",)),
                    Text('Konu hakkında bir şeyler yaz...', style: TextStyle( fontSize: 13) ,),
                  ],
                ),
              ),

            ),
            SizedBox(
              height: height/2,
            )



          ],
        )
    );
  }
}
