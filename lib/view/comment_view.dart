import 'package:flutter/material.dart';
import 'package:intesa_soft_case/model/model_data.dart';

class CommentView extends StatefulWidget {
  var comments;


  CommentView(this.comments);


  
  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  var size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size*0.05;
    height = size.height;
    width = size.width;
//Container( child: Text("${widget.comments![1].description}"),)
    return Scaffold(
      appBar: AppBar(
        title: Text('Sosyal Duvar',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
          itemCount:widget.comments.length,
          itemBuilder: (contex,index){
            return Container(
              height: height*2,
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage("${widget.comments![index].authorProfileImage}"),),
                subtitle: Text("${widget.comments![index].description}"),
                title: Text("${widget.comments![index].authorName}"),
              ),
            );
      }),
    );
  }
}
