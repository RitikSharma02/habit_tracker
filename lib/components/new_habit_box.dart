import 'package:flutter/material.dart';

class EnterNewHabitBox extends StatelessWidget {
  const EnterNewHabitBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
backgroundColor: Colors.grey[900],
      content: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white) )
        ),


      ),
      actions: [
        MaterialButton(onPressed: (){},
        color: Colors.black,
          child: const Text('save',style: TextStyle(color: Colors.white),),),
        MaterialButton(onPressed: (){},
          color: Colors.black,
          child: const Text('cancel',style: TextStyle(color: Colors.white),),)
      ],
    );
  }
}
