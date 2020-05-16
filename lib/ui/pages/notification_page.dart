import 'package:corona_tracker/services/navigate_services.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_back_ios,size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.only(top: 3),
                      decoration:  BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius:  BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Material(
              elevation: 3.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.info_outline),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("ABc",style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                          Text("jvdvvdnddsvnvsdndvssdsnjnjdsjvjk")
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text("20/5"),
                        Text("44")
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
