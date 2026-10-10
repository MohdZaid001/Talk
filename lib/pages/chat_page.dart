import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk/components/chat_bubble.dart';
import 'package:talk/components/my__textfield.dart';
import 'package:talk/services/auth/auth_service.dart';
import 'package:talk/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String reciverEmail;
  final String reciverId;

  const ChatPage({
    super.key,
    required this.reciverEmail,
    required this.reciverId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  // for textfield  focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to focus mode
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //cuase a delay so that the keyboad has time to show up
        // then the amount of remaining space will be calculated,
        // then scroll down
        Future.delayed(const Duration(microseconds: 500), () => scrollDown());
      }
    });

    // wait a bit to build listview then scroll to bottom
    Future.delayed(const Duration(microseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendMessage() async {
    // check there is something in text box
    if (_messageController.text.isNotEmpty) {
      // send message
      await _chatService.sendMessage(widget.reciverId, _messageController.text);
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        elevation: 0,
      ),
      body: Column(
        children: [
          //  previous chat
          Expanded(child: _buildMessageList()),

          // text field box
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(senderId, widget.reciverId),
      builder: ((context, snapshot) {
        // erros
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // return list view
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      }),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    // is current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    // align message in right if current user else in left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hintText: "Type a message",
              obscureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
