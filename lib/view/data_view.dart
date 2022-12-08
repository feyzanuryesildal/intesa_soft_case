import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intesa_soft_case/services/fetch_services.dart';
import 'package:provider/provider.dart';
import '../view_model/data_view_model.dart';
import 'comment_view.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  var size,height,width;
  WebService httpService = WebService();
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
      title: Text('Sosyal Duvar',style: TextStyle(color: Colors.black),),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: BackButton(
        color: Colors.black,
      ),
    );
  }

  Center buildErrorWidget() => Center(child: Text('Something went wrong!'));

  Center buildLoadingWidget() => Center(child: CircularProgressIndicator());


  SingleChildScrollView buildListView(BuildContext context) {
    size = MediaQuery.of(context).size*0.05;
    height = size.height;
    width = size.width;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, index) {
              var data = context.read<DataViewModel>().dataList[index];
              return Container(
                width: width*15 ,
                height: height *5,
                child: Column(
                  children: [
                    ListTile(
                title: Text(data.authorName.toString()),
                      leading:CircleAvatar(backgroundImage: NetworkImage("${data.authorProfileImage}"),) ,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: ' Bir şey yaz...',
                           ),

                          minLines: 2,
                          maxLines: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          OutlinedButton(
                          onPressed: null,
                          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
              ),
              child: const Text("Foto/Video ekle"),
              ),
                            OutlinedButton(
                              onPressed: null,
                              style: ButtonStyle(

                                  backgroundColor:MaterialStateProperty.all(
                                    Colors.yellow,
                                  ) ,

                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                              ),
                              child: const Text("Paylaş"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (_, index) => buildListItem(context, index)),
        ],
      ),
    );
  }
  Widget buildListItem(BuildContext context, int index) {
    size = MediaQuery.of(context).size*0.05;
    height = size.height;
    width = size.width;
    var data = context.read<DataViewModel>().dataList[index];
    return Card (
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
            commentCard(data.comments!.length, data), // Eğer yorum yoksa bu widget ile onun kontrolünü sayğlayarak yorumlar listelenir.
            InkWell(child: Text("diğer yorumları gör...",style: TextStyle(color: Colors.grey),),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentView(data.comments)));
              },
            ),
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
                        backgroundImage: NetworkImage("${data.authorProfileImage}",)),
                    Text('Konu hakkında bir şeyler yaz...', style: TextStyle( fontSize: 13) ,),
                  ],
                ),
              ),

            ),
            SizedBox(
              height: height/2,
            ),
          ],
        )
    );
  }



 Widget commentCard(var data1, var data){
    if (data1 == 0){
      return Text("Henüz yorum yapılmamış");
    }else{
      return Container(
        height: height*2,
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage("${data.comments![0].authorProfileImage}"),),
          subtitle: Text("${data.comments![0].description}"),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${data.comments![0].authorName}"),
              InkWell(child: Icon(Icons.restore_from_trash, color: Colors.yellow,), onTap: ()  {
                httpService.deletePost(1,1);
              },),
            ],
          ),
        ),
      );
    }
  }
}