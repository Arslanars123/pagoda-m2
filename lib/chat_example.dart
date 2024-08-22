import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagoda/views/language.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as Io;
import 'dart:async';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  var senderId;
  var topicId;
  ChatScreen({this.senderId,this.topicId});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Io.Socket socket;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Map<String, dynamic>> messages = [];
  bool isTyping = false;
  Timer? typingTimer;
   ScrollController _scrollController = ScrollController();
Future<void> fetchChatHistory(String userId1, String userId2, String topicId) async {
  final url = 'http://85.31.236.78:3000/get-chat-history';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'userId1': userId1,
      'userId2': userId2,
      'topicId': topicId,
    }),
  );

  if (response.statusCode == 200) {
    List<dynamic> responseData = jsonDecode(response.body);

 
    for (var data in responseData) {
      messages.add({
        'sender': data['senderId'],
        'message': data['message'],
        'image': data['image'],
        'messageId': data['messageId'],
        'seen': false,
      });
    }
setState(() {
  print("between");
  print(messages.length);
  
  
});
    // Use the `messages` list as needed
   
  } else {
    throw Exception('Failed to load chat history');
  }
}

  @override
  void initState() {
    print(widget.senderId);
    print(widget.topicId);
  
    super.initState();
    initSocket();
      fetchChatHistory("66bf8470dd374d270e7249ce", widget.senderId, widget.topicId);
  }
void _scrollToBottom() {
  print('yes');
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  void initSocket() {
    
    
    socket = Io.io('http://85.31.236.78:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.connect();

    socket.on('connect', (_) {
     
      socket.emit('storeSocketId', widget.senderId);
    });

    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    socket.on('connect_error', (data) {
  
    });

    socket.on('privateMessage', (data) {
  
      setState(() {
        messages.add({
          'sender': data['senderId'],
          'message': data['message'],
          
          'image': data['image'],
          'messageId': data['messageId'],
          'seen': false,
        });
      });
      _scrollToBottom();
      if (data['senderId'] != widget.senderId) {
        socket.emit('messageSeen', {'messageId': data['messageId'], 'userId': widget.senderId});
      }
      
    });

    socket.on('typing', (data) {
      if (data['senderId'] != widget.senderId) {
        setState(() {
          isTyping = true;
        });
      }
    });

    socket.on('stop typing', (data) {
      if (data['senderId'] != widget.senderId) {
        setState(() {
          isTyping = false;
        });
      }
    });

    socket.on('update-mid', (data) {
      setState(() {
        int index = messages.indexWhere((msg) => msg['messageId'] == data['tempMessageId']);
        if (index != -1) {
          messages[index]['messageId'] = data['messageId'];
        }
      });
    });

    socket.on('messageSeen', (data) {
      setState(() {
        int index = messages.indexWhere((msg) => msg['messageId'] == data['messageId']);
        if (index != -1) {
          messages[index]['seen'] = true;
        }
      });
    });
  }

  Future<void> sendMessage({String? message, String? image}) async {
    String tempMessageId = 'temp-${DateTime.now().millisecondsSinceEpoch}';

    setState(() {
      messages.add({
        'sender': widget.senderId,
        'message': message,
        'image': image,
        'messageId': tempMessageId,
        'seen': false,
      });
    });

    print("Sending message with image");
    socket.emitWithAck('privateMessage', {
      'senderId': widget.senderId,
      'receiverId': '66bf8470dd374d270e7249ce',
      'topicId': widget.topicId,
      'message': message,
      'tempMessageId': tempMessageId,
      'image': image,
    }, ack: (data) {
    
    });
    _scrollToBottom();
    
  }

  


void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}

  Future<String> convertToBase64(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 50,
      minHeight: 50,
      quality: 10,
      rotate: 0,
    );

    String base64Image = base64Encode(result!);
    return 'data:image/jpeg;base64,$base64Image';
  }

  void pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      String? filePath = result.files.first.path;

      if (filePath != null) {
        File file = File(filePath);
        String data = await convertToBase64(file);
     
      
        await sendMessage(image: data);
      } else {
        print("File path is null!");
      }
    } else {
      print("No file selected or file is empty!");
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
     var height = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
       
        body: Column(
          children: [
                   Container(
                    height: height/7,
              width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: width / 25, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Container(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Container(
                                width: width / 1.5,
                                child: Text(
                                  'Cooking class e show cooking',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Color(0xFF777777),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: width / 25, bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LanguageScreen()),
                                  );
                                },
                            child: Image.asset("assets/images/uk.png",scale: 1,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
       
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  print(messages.length);
                  return MessageTile(
                    message: msg['message'],
                    image: msg['image'],
                    seen: msg['seen'],
                    isSender: msg['sender'] == widget.senderId,
                  );
                },
              ),
            ),
            if (isTyping) Text('Admin is typing...'),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child:TextField(
                    controller: messageController,
                    onChanged: (value) {
                      if (typingTimer?.isActive ?? false) typingTimer!.cancel();
                      socket.emit('typing', {'senderId': widget.senderId, 'receiverId': '66bf8470dd374d270e7249ce'});
                  
                      typingTimer = Timer(Duration(seconds: 1), () {
                        socket.emit('stop typing', {'senderId': widget.senderId, 'receiverId': '66bf8470dd374d270e7249ce'});
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF63697B),
                      ),
                      border: InputBorder.none, // Removes the border
                    ),
                  )
                  
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: pickImage,
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          sendMessage(message: messageController.text.trim());
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatefulWidget {
  final String? message;
  final String? image;
  final bool seen;
  final bool isSender;

  MessageTile({this.message, this.image, required this.seen, required this.isSender});

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
   
    return ListTile(
      title: Column(
        crossAxisAlignment: widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          

   



          widget.message != null
              ? Container(
                decoration: BoxDecoration(
                  color:widget.isSender ?  Color(0xFF001378):Color(0xFFEAECF2),
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width/1.4,
                child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${widget.isSender ? "You" : "Admin"}: ${widget.message}',style: GoogleFonts.montserrat(color: Colors.white),),
                ))
              : Container(),
          widget.image != null
              ? Image.memory(base64Decode(widget.image!.split(',').last), width: 200)
              : Container(),
          Row(
            mainAxisAlignment: widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
            widget.seen == true ?
             Icon(Icons.done,color: Color(0xff001378),): Icon(Icons.done,color: Colors.grey.withOpacity(0.5),)
            ],
          ),
        ],
      ),
    );
  }
}