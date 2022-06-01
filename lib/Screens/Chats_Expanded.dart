// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables, camel_case_types, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_jobs_center/Screens/widget/chatRecFileWidget.dart';
import 'package:my_jobs_center/Screens/widget/chatRecieveJobWidget.dart';
import 'package:my_jobs_center/Screens/widget/chatSendJobWidget.dart';
import 'package:my_jobs_center/Screens/widget/chatWidgetRecieved.dart';
import 'package:my_jobs_center/Screens/widget/chatWidgetSend.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_jobs_center/globalVariables.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import 'widget/chatSendFileWidget.dart';

class Chats_Expanded extends StatefulWidget {
  final String opponId;
  Chats_Expanded({
    Key? key,
    required this.opponId,
  }) : super(key: key);

  @override
  State<Chats_Expanded> createState() => _Chats_ExpandedState();
}

class _Chats_ExpandedState extends State<Chats_Expanded> {
  var fromId;
  var oponId;
  var msgResponse;
  String chatProfImg = 'default_user.png';
  String chatUserName = 'loading';
  String chatPhoneNum = '';
  bool isSpin = true;
  Map data = {};
  Map dataInit = {};
  String msg = '';
  final f = new DateFormat('yyyy-MM-dd hh:mm:ss');
  var _controller = TextEditingController();
  List recList = [];
  bool isBlockedByMe = false;
  bool isBlockedMe = false;

  TextEditingController fileNameController = TextEditingController(text: "");
  ScrollController _controllerChat = ScrollController();

  File? file;
  Map resumeUploadResponse = {};
  // Map data = {};
  String fileName = "";
  String dispName = "";
  Dio dio = new Dio();
  // bool isSpin = false;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      dispName = result.files.single.name;
      uploadFile();
    });
  }

  Future uploadFile() async {
    String uploadurl = defaultUrl + "mob_add_resume";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(file!.path,
          filename: basename(file!.path)
          //show only filename from path
          ),
      "name": fileName,
      "id": userDetailsResponse["id"]
      // "name": fileName,
    });

    print(formdata.fields);

    var response = await dio.post(
      uploadurl,
      data: formdata,
      // onSendProgress: (int sent, int total) {
      //   String percentage = (sent / total * 100).toStringAsFixed(2);
      //   setState(() {
      //     progress = "$sent" +
      //         " Bytes of " "$total Bytes - " +
      //         percentage +
      //         " % uploaded";
      //     //update the progress
      //   });
      // },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      data["message"] = msg;
      data["date"] = f.format(DateTime.now());
      data["to_id"] = widget.opponId;
      data["from_id"] = userDetailsResponse['id'];
      setState(() {
        isSpin = true;
        recList.clear();
        messagesFetched();
      });
      //print response from server
    } else {
      print("Error during connection to server.");
    }
  }

  @override
  void initState() {
    checkBlockedByMe();
    checkBlockedMe();
    getOpUserData().then((value) {
      messagesFetched();

      messageMarkAsRead();
    });
    // _controllerChat.jumpTo(_controllerChat.position.maxScrollExtent);
  }

  void _scrollDown() {
    _controllerChat.jumpTo(_controllerChat.position.maxScrollExtent);
  }

  Future messagesFetched() async {
    var url = Uri.parse(defaultUrl + 'mob_message');
    setState(() {
      dataInit['id'] = userDetailsResponse['id'];
      dataInit['opId'] = widget.opponId;
    });
    try {
      var response = await http.post(url, body: json.encode(dataInit));
      msgResponse = jsonDecode(response.body);
      print(msgResponse);
      recList = msgResponse.entries.map((entry) => entry.value).toList();
      // print("AAAAAAAAAA");
      // // print(json.decode(recList[0]['message_content']["file_name"]));
      // print(json.decode(recList[0]['message_content'].toString())["file_name"]);
      // // print(recList[0]);
      // print("AAAAAAAAAA");
      // Future.delayed(Duration(seconds: 1));

      setState(() {
        isSpin = false;
      });

      // messageMarkAsRead();
    } catch (e) {
      print("object");
      setState(() {
        isSpin = false;
      });
    }
  }

  Future msgSend() async {
    var url = Uri.parse(defaultUrl + 'mob_new_message');
    var response = await http.post(url, body: json.encode(data));
    if (response.body == 'Successfully sent') {
      messagesFetched();
    }
  }

  messageMarkAsRead() async {
    var url = Uri.parse(defaultUrl + 'mob_message_markasread');
    var response = await http.post(url,
        body: json.encode(
            {'to_id': userDetailsResponse['id'], "from_id": widget.opponId}));
    print(response.statusCode);

    if (response.statusCode != 200) {
      Fluttertoast.showToast(
          msg: "Something went wrong : ${response.statusCode}");
    }
    print("--------------------------------");
    print(response.body);
  }

  Future getOpUserData() async {
    var url = Uri.parse(defaultUrl + 'mob_get_chat_users');
    var response =
        await http.post(url, body: json.encode({'user_id': widget.opponId}));
    var chatUserData;
    setState(() {
      chatUserData = jsonDecode(response.body);
    });
    if (response.statusCode == 200) {
      setState(() {
        chatProfImg = chatUserData["image"].toString();
        chatPhoneNum = chatUserData["phone"].toString();
        chatUserName = chatUserData["name"].toString();
      });
      // print(chatUserData);
    }
  }

  Future checkBlockedByMe() async {
    var url = Uri.parse(defaultUrl + 'mob_check_blocked_by_me');
    var response = await http.post(url,
        body: json.encode({
          "userid": userDetailsResponse['id'],
          "blocked_userid": widget.opponId
        }));
    print(response.body.runtimeType);
    if (int.parse(response.body) > 0) {
      setState(() {
        isBlockedByMe = true;
      });
    } else {
      isBlockedByMe = false;
    }
  }

  Future checkBlockedMe() async {
    var url = Uri.parse(defaultUrl + 'mob_check_blocked_me');
    var response = await http.post(url,
        body: json.encode({
          "userid": userDetailsResponse['id'],
          "blocked_userid": widget.opponId
        }));
    print(response.body.runtimeType);
    if (int.parse(response.body) > 0) {
      setState(() {
        isBlockedMe = true;
      });
    } else {
      isBlockedMe = false;
    }
  }

  Future unblockUser() async {
    setState(() {
      isBlockedByMe = false;
    });
    var url = Uri.parse(defaultUrl + 'mob_block_user');
    var response = await http.post(url,
        body: json.encode({
          "userId": userDetailsResponse['id'],
          "blocked_userid": widget.opponId,
          "isBlock": false
        }));
    print(response.body);
    if (response.statusCode != 200) {
      setState(() {
        isBlockedByMe = true;
      });
      Fluttertoast.showToast(msg: "Failed unblocking. Try again later");
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    messagesFetched();
    messageMarkAsRead();
    await Future.delayed(Duration(milliseconds: 5000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void afterBuild() {
    // executes after build is done
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollDown());
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        backgroundColor: Color(0xffC41800),
        elevation: 0,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            // color: Colors.black,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "https://myjobscentre.com/storage/profile/$chatProfImg",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatUserName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    // color: const Color(0xff132144),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
                // Text(
                //   'Sauce Recruitment Ltd',
                //   style: TextStyle(
                //     fontFamily: 'Poppins',
                //     fontSize: 10,
                //     color: const Color(0xff1a2234),
                //     fontWeight: FontWeight.w300,
                //   ),
                //   textAlign: TextAlign.left,
                // ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (chatPhoneNum != null) {
                launch('tel:' + chatPhoneNum);
              } else {
                Fluttertoast.showToast(msg: "No Phone Number Provided");
              }
            },
            icon: Icon(
              FontAwesomeIcons.phone,
              // color: const Color(0xff132144),
              color: Colors.white,
              size: 15,
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff7f9fc),
      body: isSpin
          ? Center(
              child: CupertinoActivityIndicator(
              radius: 20,
            ))
          : SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  // constraints:
                  //     BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _controllerChat,
                        child: Column(
                          children: [
                            ListView.builder(
                              // controller: _controllerChat,
                              itemCount: recList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return (recList[index]['from_id'] !=
                                        userDetailsResponse['id'])
                                    ? (recList[index]['message_type'] ==
                                            'shortlist')
                                        ? ChatRecieveJob(
                                            date: recList[index]
                                                ["message_date"],
                                            title: 'title',
                                            description: 'description',
                                            jobId: recList[index]["post_id"],
                                            toWhere: 'applied',
                                            msg: recList[index]
                                                ["message_content"],
                                          )
                                        : (recList[index]['message_type'] ==
                                                'applyjob')
                                            ? ChatRecieveJob(
                                                date: recList[index]
                                                    ["message_date"],
                                                title: 'title',
                                                description: 'description',
                                                jobId: recList[index]
                                                    ["post_id"],
                                                toWhere: 'aplicants',
                                                msg: recList[index]
                                                    ["message_content"],
                                              )
                                            : (recList[index]['message_type'] ==
                                                    'reject')
                                                ? ChatRecieveJob(
                                                    date: recList[index]
                                                        ["message_date"],
                                                    title: 'title',
                                                    description: 'description',
                                                    jobId: recList[index]
                                                        ["post_id"],
                                                    toWhere: 'applied',
                                                    msg: recList[index]
                                                        ["message_content"],
                                                  )
                                                : (recList[index]
                                                            ['message_type'] ==
                                                        'file')
                                                    ? ChatRecFileWidget(
                                                        date: recList[index]
                                                            ["message_date"],
                                                        title: json.decode(recList[
                                                                        index][
                                                                    'message_content']
                                                                .toString())[
                                                            "file_name"],
                                                        path: json.decode(recList[
                                                                        index][
                                                                    'message_content']
                                                                .toString())[
                                                            "file_path"],
                                                      )
                                                    : ChatWidgetRecieved(
                                                        date: recList[index]
                                                            ["message_date"],
                                                        msg: recList[index]
                                                            ["message_content"],
                                                      )
                                    : (recList[index]['message_type'] ==
                                            'shortlist')
                                        ? ChatSendJob(
                                            date: recList[index]
                                                ["message_date"],
                                            title: 'title',
                                            description: 'description',
                                            jobId: recList[index]["post_id"],
                                            toWhere: 'aplicants',
                                            msg: recList[index]
                                                ["message_content"],
                                            recd: recList[index]["recd"],
                                            seen: recList[index]["seen"],
                                          )
                                        : (recList[index]['message_type'] ==
                                                'applyjob')
                                            ? ChatSendJob(
                                                date: recList[index]
                                                    ["message_date"],
                                                title: 'title',
                                                description: 'description',
                                                jobId: recList[index]
                                                    ["post_id"],
                                                toWhere: 'applied',
                                                msg: recList[index]
                                                    ["message_content"],
                                                recd: recList[index]["recd"],
                                                seen: recList[index]["seen"],
                                              )
                                            : (recList[index]['message_type'] ==
                                                    'reject')
                                                ? ChatSendJob(
                                                    date: recList[index]
                                                        ["message_date"],
                                                    title: 'title',
                                                    description: 'description',
                                                    jobId: recList[index]
                                                        ["post_id"],
                                                    toWhere: 'aplicants',
                                                    msg: recList[index]
                                                        ["message_content"],
                                                    recd: recList[index]
                                                        ["recd"],
                                                    seen: recList[index]
                                                        ["seen"],
                                                  )
                                                : (recList[index]
                                                            ['message_type'] ==
                                                        'file')
                                                    ? ChatSendFileWidget(
                                                        date: recList[index]
                                                            ["message_date"],
                                                        title: json.decode(recList[
                                                                        index][
                                                                    'message_content']
                                                                .toString())[
                                                            "file_name"],
                                                        path: json.decode(recList[
                                                                        index][
                                                                    'message_content']
                                                                .toString())[
                                                            "file_path"],
                                                        recd: recList[index]
                                                            ["recd"],
                                                        seen: recList[index]
                                                            ["seen"],
                                                      )
                                                    : ChatWidgetSend(
                                                        date: recList[index]
                                                            ["message_date"],
                                                        msg: recList[index]
                                                            ["message_content"],
                                                        recd: recList[index]
                                                            ["recd"],
                                                        seen: recList[index]
                                                            ["seen"],
                                                      );
                              },
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      isBlockedByMe
                          ? Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        "Unblock User?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            unblockUser().then((value) {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            'UNBLOCK',
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'CANCEL',
                                            style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 20, top: 10),
                                    child: Text(
                                      "You blocked this contact. Unblock to send a message",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : isBlockedMe
                              ? Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, bottom: 20, top: 10),
                                      child: Text(
                                        "You don't have permission to send messages for this user",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, bottom: 10, top: 10),
                                    height: 60,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            // selectFile();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: Icon(
                                              FontAwesomeIcons.paperclip,
                                              color: Colors.black54,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: _controller,
                                            onChanged: (value) {
                                              setState(() {
                                                msg = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText:
                                                    "Type Your Message Here",
                                                hintStyle: TextStyle(
                                                    color: Colors.black54),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              recList.add({
                                                "message_content": msg,
                                                'message_date':
                                                    f.format(DateTime.now()),
                                                'from_id':
                                                    userDetailsResponse['id'],
                                                'to_id': widget.opponId,
                                                'message_type': 'text',
                                                'recd': '0',
                                                'seen': '0',
                                              });

                                              data["message"] = msg;
                                              data["date"] =
                                                  f.format(DateTime.now());
                                              data["to_id"] = widget.opponId;
                                              data["from_id"] =
                                                  userDetailsResponse['id'];

                                              msgSend().then((value) {});
                                            });
                                            msg = '';
                                            _controller.clear();
                                          },
                                          child: Container(
                                            child: Icon(
                                              Icons.send,
                                              color: Color(0xff788198),
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                    ],
                  ),

                  // SingleChildScrollView(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  //     child: Column(
                  //       children: [
                  //         for (int i = 0; i < msgResponse.length; i++)
                  // (msgResponse[i]['from_id'] == fromId)
                  //     ? ChatWidgetRecieved(
                  //         date: msgResponse[i]["message_date"],
                  //         msg: msgResponse[i]["message_content"],
                  //       )
                  //     : ChatWidgetSend(
                  //         date: msgResponse[i]["message_date"],
                  //         msg: msgResponse[i]["message_content"],
                  //       ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ),
    );
  }
}

const String _svg_v141r =
    '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#000000" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ltg2cz =
    '<svg viewBox="315.7 17.3 15.3 11.0" ><path transform="translate(315.69, 17.33)" d="M 7.41510009765625 10.87290000915527 L 5.417099952697754 8.856900215148926 C 5.355900287628174 8.796600341796875 5.321700096130371 8.712900161743164 5.323500156402588 8.626500129699707 C 5.325300216674805 8.54010009765625 5.363100051879883 8.458200454711914 5.427000045776367 8.400600433349609 C 6.702300071716309 7.321500301361084 8.570700645446777 7.321500301361084 9.846000671386719 8.400600433349609 C 9.910799980163574 8.458200454711914 9.947700500488281 8.54010009765625 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712900161743164 9.917099952697754 8.796600341796875 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799400329589844 10.93230056762695 7.720200061798096 10.96560001373291 7.636500358581543 10.96560001373291 C 7.553699970245361 10.96560001373291 7.473600387573242 10.93230056762695 7.41510009765625 10.87290000915527 Z M 10.93050003051758 7.343100070953369 C 10.02780055999756 6.525900363922119 8.85420036315918 6.073200225830078 7.636500358581543 6.073200225830078 C 6.419700145721436 6.073200225830078 5.247000217437744 6.525900363922119 4.345200061798096 7.343100070953369 C 4.222800254821777 7.458300113677979 4.030200004577637 7.456500053405762 3.911400079727173 7.336800098419189 L 2.757600069046021 6.170400142669678 C 2.696400165557861 6.109200000762939 2.662199974060059 6.026400089263916 2.663100004196167 5.940000057220459 C 2.664000034332275 5.853600025177002 2.699100017547607 5.771699905395508 2.761199951171875 5.711400032043457 C 5.509799957275391 3.154500007629395 9.765900611877441 3.154500007629395 12.51360034942627 5.711400032043457 C 12.5757007598877 5.771699905395508 12.6117000579834 5.853600025177002 12.61260032653809 5.940000057220459 C 12.61350059509277 6.026400089263916 12.57929992675781 6.109200000762939 12.51900005340576 6.170400142669678 L 11.36430072784424 7.336800098419189 C 11.30341243743896 7.397687435150146 11.22391605377197 7.428067684173584 11.14436626434326 7.428062438964844 C 11.06752777099609 7.428057193756104 10.99063968658447 7.399701595306396 10.93050003051758 7.343100070953369 Z M 13.59000015258789 4.655700206756592 C 11.98350048065186 3.129300117492676 9.852300643920898 2.276999950408936 7.636500358581543 2.276999950408936 C 5.420700073242188 2.276999950408936 3.289499998092651 3.128400087356567 1.683000087738037 4.655700206756592 C 1.562399983406067 4.773600101470947 1.368900060653687 4.77180004119873 1.249199986457825 4.652100086212158 L 0.09360000491142273 3.485700130462646 C 0.0333000011742115 3.424499988555908 -0.0009000000427477062 3.342600107192993 0 3.257100105285645 C 0.0009000000427477062 3.171600103378296 0.03510000184178352 3.089699983596802 0.09630000591278076 3.029400110244751 C 4.310999870300293 -1.00980007648468 10.96110057830811 -1.00980007648468 15.17670059204102 3.029400110244751 C 15.23700046539307 3.089699983596802 15.2721004486084 3.171600103378296 15.2721004486084 3.257100105285645 C 15.27300071716309 3.342600107192993 15.23880004882812 3.424499988555908 15.17850017547607 3.485700130462646 L 14.02290058135986 4.652100086212158 C 13.96281909942627 4.712636947631836 13.88365459442139 4.743017196655273 13.80445384979248 4.743010520935059 C 13.72704887390137 4.743004322052002 13.64960861206055 4.713973522186279 13.59000015258789 4.655700206756592 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_renyrk =
    '<svg viewBox="293.7 17.7 17.0 10.7" ><path transform="translate(293.67, 17.67)" d="M 15.00030040740967 10.6668004989624 C 14.44770050048828 10.6668004989624 14.00040054321289 10.21860027313232 14.00040054321289 9.666900634765625 L 14.00040054321289 0.9999000430107117 C 14.00040054321289 0.4473000168800354 14.44770050048828 0 15.00030040740967 0 L 16.00020027160645 0 C 16.55190086364746 0 17.00010108947754 0.4473000168800354 17.00010108947754 0.9999000430107117 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.21860027313232 16.55190086364746 10.6668004989624 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 Z M 10.33290004730225 10.6668004989624 C 9.781200408935547 10.6668004989624 9.333000183105469 10.21860027313232 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600044250488 C 9.333000183105469 2.781000137329102 9.781200408935547 2.333699941635132 10.33290004730225 2.333699941635132 L 11.33370018005371 2.333699941635132 C 11.88539981842041 2.333699941635132 12.33360004425049 2.781000137329102 12.33360004425049 3.333600044250488 L 12.33360004425049 9.666900634765625 C 12.33360004425049 10.21860027313232 11.88539981842041 10.6668004989624 11.33370018005371 10.6668004989624 L 10.33290004730225 10.6668004989624 Z M 5.666399955749512 10.6668004989624 C 5.114700317382812 10.6668004989624 4.666500091552734 10.21860027313232 4.666500091552734 9.666900634765625 L 4.666500091552734 5.666399955749512 C 4.666500091552734 5.114700317382812 5.114700317382812 4.666500091552734 5.666399955749512 4.666500091552734 L 6.666300296783447 4.666500091552734 C 7.218900203704834 4.666500091552734 7.667099952697754 5.114700317382812 7.667099952697754 5.666399955749512 L 7.667099952697754 9.666900634765625 C 7.667099952697754 10.21860027313232 7.218900203704834 10.6668004989624 6.666300296783447 10.6668004989624 L 5.666399955749512 10.6668004989624 Z M 0.9999000430107117 10.6668004989624 C 0.4473000168800354 10.6668004989624 0 10.21860027313232 0 9.666900634765625 L 0 7.667099952697754 C 0 7.114500045776367 0.4473000168800354 6.666300296783447 0.9999000430107117 6.666300296783447 L 1.999800086021423 6.666300296783447 C 2.5524001121521 6.666300296783447 2.99970006942749 7.114500045776367 2.99970006942749 7.667099952697754 L 2.99970006942749 9.666900634765625 C 2.99970006942749 10.21860027313232 2.5524001121521 10.6668004989624 1.999800086021423 10.6668004989624 L 0.9999000430107117 10.6668004989624 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vaojpw =
    '<svg viewBox="16.0 64.0 9.3 16.2" ><path transform="translate(4.75, 57.81)" d="M 14.0435905456543 14.29483032226562 L 20.17609024047852 8.167134284973145 C 20.62966156005859 7.713561058044434 20.62966156005859 6.980021953582764 20.17609024047852 6.531252384185791 C 19.7225170135498 6.07767915725708 18.98897743225098 6.082482814788818 18.53540420532227 6.531252384185791 L 11.58770942687988 13.47483253479004 C 11.14854526519775 13.91399383544922 11.13893890380859 14.61802864074707 11.55408477783203 15.07159996032715 L 18.53060150146484 22.06252670288086 C 18.75704574584961 22.28896903991699 19.05622673034668 22.40013313293457 19.35060119628906 22.40013313293457 C 19.64497756958008 22.40013313293457 19.94415664672852 22.28896903991699 20.17060089111328 22.06252670288086 C 20.62417221069336 21.60895347595215 20.62417221069336 20.87541389465332 20.17060089111328 20.42664337158203 L 14.0435905456543 14.29483032226562 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_c6uo16 =
    '<svg viewBox="0.0 0.0 33.0 33.0" ><path  d="M 0 0 L 33 0 L 33 33 L 0 33 L 0 0 Z" fill="none" fill-opacity="0.0" stroke="none" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(3.4, 3.4)" d="M 18.59183120727539 0 L 7.61229944229126 0 C 2.843147754669189 0 0 2.843147754669189 0 7.61229944229126 L 0 18.5787296295166 C 0 23.36098098754883 2.843147754669189 26.20413208007812 7.61229944229126 26.20413208007812 L 18.5787296295166 26.20413208007812 C 23.34787750244141 26.20413208007812 26.1910285949707 23.36098098754883 26.1910285949707 18.59183120727539 L 26.1910285949707 7.61229944229126 C 26.20413208007812 2.843147754669189 23.36098098754883 0 18.59183120727539 0 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(2.75, 2.75)" d="M 19.51125144958496 0 L 7.988750457763672 0 C 2.983749866485596 0 0 2.983749866485596 0 7.988750457763672 L 0 19.49750137329102 C 0 24.51625061035156 2.983749866485596 27.50000190734863 7.988750457763672 27.50000190734863 L 19.49750137329102 27.50000190734863 C 24.50250053405762 27.50000190734863 27.48624992370605 24.51625061035156 27.48624992370605 19.51125144958496 L 27.48624992370605 7.988750457763672 C 27.50000190734863 2.983749866485596 24.51625061035156 0 19.51125144958496 0 Z M 8.497501373291016 20.30875015258789 C 8.470000267028809 20.30875015258789 8.428750038146973 20.30875015258789 8.401249885559082 20.30875015258789 C 7.067499160766602 20.18500137329102 5.816250324249268 19.56625175476074 4.881250381469727 18.57625007629395 C 2.681250333786011 16.26625061035156 2.681250333786011 12.51250076293945 4.881250381469727 10.20250034332275 L 7.892499923706055 7.040000438690186 C 8.965000152587891 5.912499904632568 10.4087495803833 5.280000686645508 11.94874954223633 5.280000686645508 C 13.48875045776367 5.280000686645508 14.93250179290771 5.898750305175781 16.00500106811523 7.040000438690186 C 18.20500183105469 9.34999942779541 18.20500183105469 13.10375022888184 16.00500106811523 15.41375160217285 L 14.50625133514404 16.9950008392334 C 14.10750007629395 17.40750122070312 13.46125030517578 17.42125129699707 13.04875087738037 17.03625106811523 C 12.63624954223633 16.63750076293945 12.6225004196167 15.99125099182129 13.00750064849854 15.57874965667725 L 14.50625133514404 13.9975004196167 C 15.96375179290771 12.47125053405762 15.96375179290771 9.982500076293945 14.50625133514404 8.470000267028809 C 13.14500141143799 7.040000438690186 10.7524995803833 7.040000438690186 9.377499580383301 8.470000267028809 L 6.366250514984131 11.63250064849854 C 4.908750534057617 13.15875053405762 4.908750534057617 15.64749908447266 6.366250514984131 17.15999984741211 C 6.957500457763672 17.79250144958496 7.755000114440918 18.17749977111816 8.593750953674316 18.26000022888184 C 9.157500267028809 18.31500053405762 9.570000648498535 18.82375144958496 9.515000343322754 19.38750267028809 C 9.473750114440918 19.91000175476074 9.020001411437988 20.30875015258789 8.497501373291016 20.30875015258789 Z M 22.61875152587891 17.31125068664551 L 19.60750007629395 20.4737491607666 C 18.53500175476074 21.60124969482422 17.09125137329102 22.23375129699707 15.55125141143799 22.23375129699707 C 14.01125144958496 22.23375129699707 12.56750011444092 21.61499977111816 11.49499988555908 20.4737491607666 C 9.295000076293945 18.16374969482422 9.295000076293945 14.41000080108643 11.49499988555908 12.10000038146973 L 12.99375057220459 10.51875019073486 C 13.39249992370605 10.10624980926514 14.03875064849854 10.09249973297119 14.45125102996826 10.47749996185303 C 14.86375045776367 10.87625026702881 14.8774995803833 11.52250099182129 14.4925012588501 11.9350004196167 L 12.99375057220459 13.51624965667725 C 11.53625011444092 15.04249954223633 11.53625011444092 17.53125 12.99375057220459 19.04375076293945 C 14.35500049591064 20.47375106811523 16.74750137329102 20.48750114440918 18.12250137329102 19.04375076293945 L 21.13375282287598 15.88125038146973 C 22.59125137329102 14.35500144958496 22.59125137329102 11.86625003814697 21.13375282287598 10.35375022888184 C 20.54250144958496 9.721249580383301 19.7450008392334 9.336250305175781 18.90625 9.253749847412109 C 18.34250068664551 9.198750495910645 17.93000221252441 8.689999580383301 17.98500061035156 8.126250267028809 C 18.04000091552734 7.562500476837158 18.53500175476074 7.136249542236328 19.11250114440918 7.204999446868896 C 20.44625091552734 7.34250020980835 21.6974983215332 7.947499752044678 22.63249969482422 8.9375 C 24.81875038146973 11.23375034332275 24.81875228881836 15.00125026702881 22.61875152587891 17.31125068664551 Z" fill="#f7f9fc" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dq98jz =
    '<svg viewBox="342.0 808.5 13.2 14.0" ><path transform="translate(342.0, 773.4)" d="M 12.37942695617676 40.6530647277832 L 1.759385824203491 35.23119735717773 C 1.311980485916138 35.00275802612305 0.8065249919891357 35.10324859619141 0.4403069317340851 35.49332427978516 C 0.07408878207206726 35.88346099853516 -0.07908265292644501 36.48457717895508 0.04061626642942429 37.06206130981445 L 0.9858932495117188 41.62300109863281 L 5.61409854888916 41.62300109863281 C 5.827067852020264 41.62300109863281 5.999752521514893 41.83543395996094 5.999752521514893 42.09749603271484 C 5.999752521514893 42.35952758789062 5.827094078063965 42.57199096679688 5.61409854888916 42.57199096679688 L 0.9858932495117188 42.57199096679688 L 0.04061626642942429 47.13289642333984 C -0.07908265292644501 47.71041870117188 0.07406307011842728 48.31153106689453 0.4403067827224731 48.70164108276367 C 0.8072704076766968 49.09250259399414 1.312777280807495 49.1917610168457 1.759411573410034 48.96376419067383 L 12.3794527053833 43.54192352294922 C 12.86297798156738 43.29507827758789 13.163330078125 42.74159622192383 13.163330078125 42.09749603271484 C 13.163330078125 41.45339584350586 12.86297798156738 40.89988327026367 12.37942695617676 40.6530647277832 Z" fill="#788198" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_xxqrd =
    '<svg viewBox="0.0 0.0 14.5 12.6" ><path transform="translate(0.0, -96.51)" d="M 12.10926532745361 96.51200103759766 L 2.342217683792114 96.51200103759766 C 1.053997993469238 96.51200103759766 0 97.56600189208984 0 98.85421752929688 L 0 106.7474975585938 C 0 108.0357131958008 1.053997993469238 109.0897064208984 2.342217683792114 109.0897064208984 L 12.10926532745361 109.0897064208984 C 13.39748573303223 109.0897064208984 14.45148372650146 108.0357131958008 14.45148372650146 106.7474975585938 L 14.45148372650146 98.85421752929688 C 14.45148277282715 97.54257965087891 13.39748573303223 96.51200103759766 12.10926532745361 96.51200103759766 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_wm63v =
    '<svg viewBox="0.0 0.0 5.8 10.0" ><path transform="translate(-341.5, -123.85)" d="M 345.5559997558594 123.8850326538086 C 345.4154663085938 123.9084548950195 345.2749328613281 123.9787216186523 345.1578369140625 124.0489883422852 L 341.5039672851562 126.156982421875 L 341.5039672851562 131.5909271240234 L 345.1812438964844 133.6989288330078 C 345.8605041503906 134.0971069335938 346.7037048339844 133.8628845214844 347.1018676757812 133.1836395263672 C 347.218994140625 132.9728393554688 347.2892456054688 132.7386169433594 347.2892456054688 132.4809722900391 L 347.2892456054688 125.2435150146484 C 347.2892456054688 124.3768997192383 346.469482421875 123.6742324829102 345.5559997558594 123.8850326538086 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_dg79 =
    '<svg viewBox="0.0 0.0 15.5 15.5" ><path transform="translate(-0.54, 0.0)" d="M 15.5982780456543 11.37337303161621 L 13.43560123443604 9.210696220397949 C 12.66321563720703 8.438311576843262 11.3501615524292 8.747295379638672 11.04120635986328 9.751365661621094 C 10.80949211120605 10.44654273986816 10.03710651397705 10.83273506164551 9.341959953308105 10.67822742462158 C 7.797190189361572 10.29203510284424 5.711750984191895 8.283834457397461 5.325558662414551 6.66182804107666 C 5.093843936920166 5.966651439666748 5.557274341583252 5.194266796112061 6.252420902252197 4.962581157684326 C 7.256521224975586 4.653626918792725 7.565475463867188 3.340573310852051 6.793090343475342 2.568188667297363 L 4.630412578582764 0.4055114984512329 C 4.012504577636719 -0.1351577639579773 3.08564281463623 -0.1351577639579773 2.544973134994507 0.4055114984512329 L 1.077442169189453 1.873042345046997 C -0.3900890350341797 3.417811870574951 1.231919050216675 7.511451244354248 4.862127780914307 11.1416597366333 C 8.492336273193359 14.77186679840088 12.58597660064697 16.47114372253418 14.13074684143066 14.92634391784668 L 15.59827709197998 13.45881271362305 C 16.13897705078125 12.84090423583984 16.13897705078125 11.91404247283936 15.5982780456543 11.37337303161621 Z" fill="#132144" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
