// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_jobs_center/Screens/Chats_Expanded.dart';
import 'package:my_jobs_center/Screens/Component34.dart';
import 'package:my_jobs_center/Screens/Sidemenu.dart';
import 'package:my_jobs_center/Screens/widget/chatPreviewComponent.dart';
import 'package:http/http.dart' as http;
import 'package:my_jobs_center/Screens/widget/connectWIdget.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/endDrawer.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatsPage extends StatefulWidget {
  static const String idScreen = 'chatsPage';
  const ChatsPage({Key? key}) : super(key: key);

  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  var msgPrevResponse;
  bool isSpin = true;
  List recPrevList = [];
  Map data = {};
  bool isConnectEmpty = false;
  Future messagesPreviewFetched() async {
    print("sadfasdfsdf");
    // var url = Uri.parse('http://10.0.2.2/myjobscenter/demo/mob_message_prev');
    var url = Uri.parse(defaultUrl + 'mob_message_prev');

    // Store all data with Param Name.
    // var data = {'email': email, 'password': password};

    // Starting Web API Call.
    setState(() {
      data['id'] = userDetailsResponse['id'];
    });
    var response = await http.post(url, body: json.encode(data));
    // var response = await http.post(url);

    try {
      msgPrevResponse = jsonDecode(response.body);
      print("-------------------------==========================------------------");
      print(msgPrevResponse);
      recPrevList = msgPrevResponse.entries.map((entry) => entry.value).toList();
      print(recPrevList);
      setState(() {
        isSpin = false;
      });
    } on NoSuchMethodError {
      setState(() {
        isSpin = false;
        isConnectEmpty = true;
      });
    } catch (error) {
      print("object");
      setState(() {
        isSpin = false;
        isConnectEmpty = true;
      });
    }

    // Getting Server response into variable.
    // print(userDetailsResponse.body.toString());
    // Map a = jsonDecode(userDetailsResponse.body);
    // print(a["name"]);
  }

  @override
  void initState() {
    print(userDetailsResponse["user_type"]);
    messagesPreviewFetched();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    messagesPreviewFetched();
    await Future.delayed(Duration(milliseconds: 5000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // messagesPreviewFetched();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: (userDetailsResponse["user_type"] == 'user' ||
              userDetailsResponse["user_type"] == null)
          ? Sidemenu()
          : SidemenuEmployer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xffdd312d)),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Connect",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: const Color(0xff1d1d1d),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xfff7f9fc),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xfff7f9fc),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Stack(
            children: [
              isSignedIn
                  ? isSpin
                      ? Center(
                          child: CupertinoActivityIndicator(
                            radius: 20,
                          ),
                        )
                      : isConnectEmpty
                          ? Center(
                              child: Text(
                                "No Chats Available",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: const Color(0xff132144),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 20, left: 20),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: recPrevList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(top: 10, bottom: 10),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Chats_Expanded(
                                                        opponId: recPrevList[index]
                                                            ['to_id']))).then(
                                                (value) => messagesPreviewFetched());
                                          },
                                          child: ChatPreviewComponent(
                                            image:
                                                (recPrevList[index]['userImage'] == null)
                                                    ? "default_user.png"
                                                    : recPrevList[index]['userImage'],
                                            msg: (recPrevList[index]['message_type'] ==
                                                    'file')
                                                ? json.decode(recPrevList[index]
                                                        ['lastMsg']
                                                    .toString())["file_name"]
                                                : recPrevList[index]['lastMsg'],
                                            time:
                                                recPrevList[index]['lastTime'].toString(),
                                            unseen: recPrevList[index]['unseen'],
                                            userName:
                                                recPrevList[index]['name'].toString(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    // for (int i = 0; i < recPrevList.length; i++)
                                    //   ChatPreviewComponent(
                                    //     image: recPrevList[i]['userImage'],
                                    //     msg: recPrevList[i]['lastMsg'],
                                    //     time: recPrevList[i]['lastTime'].toString(),
                                    //     unseen: recPrevList[i]['unseen'],
                                    //     userName: recPrevList[i]['userName'],
                                    //   ),

                                    // Align(
                                    //   alignment: Alignment.bottomCenter,
                                    //   child: Component34(),
                                    // ),
                                  ],
                                ),
                              ),
                            )
                  : ConnectWidget(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: SizedBox(
                    height: 60,
                    child: (userDetailsResponse["user_type"] == 'user' ||
                            userDetailsResponse["user_type"] == null)
                        ? Component34()
                        : EndDrawer(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
