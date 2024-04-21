


import 'package:flutter/material.dart';

import '../businessObj/tag.dart';
import '../generate/businessObj/tagGen.dart';


class TagPage extends StatefulWidget {
  
  final Tag tag ; 

  TagPage({super.key, Tag? tag}):this.tag=tag ?? TagGen.newObj();

  @override
  State<TagPage> createState() => _TagPageState();
}


class _TagPageState extends State<TagPage> {
  TextEditingController nameController = TextEditingController();


  
  @override
  void initState() {
    super.initState();
    nameController.text = widget.tag.name.toString();    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Text("Tag"),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
        child:Column(
          
          children: [       
            Row(
              children: [
                Text("Nom : "),
                Flexible(
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: "Nom"), 
                    )
                )              
              ],
            ),            
            Expanded(child: Container()),
            Row(children: [
              ElevatedButton(onPressed: (){
                save();
              }, 
              child: Text("Save")),

              Expanded(child: Container()),
              
              ElevatedButton(onPressed: (){
                delete();
              }, 
              child: Text("Delete")),
              ElevatedButton(onPressed: () {
                cancel();
              },
              child: Text("Cancel")),
            ],)
          ],
        )
      )
    );
  }

  save()
  {
    widget.tag.name = nameController.text;
    widget.tag.save().then((value){
      Navigator.pop(context);
    });
  }

  delete()
  {
    widget.tag.delete();
    widget.tag.save().then((value){
      Navigator.pop(context);
    });
  }

  cancel(){
    Navigator.pop(context);
  }

}
