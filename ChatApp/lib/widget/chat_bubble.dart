import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final String counterPartUsername;
  final bool isCurrentUserMessage;
  String? currentUserImageUrl;
  String? counterPartImageUrl;

  ChatBubble({
    required this.text,
    required this.counterPartUsername,
    required this.isCurrentUserMessage,
    this.currentUserImageUrl,
    this.counterPartImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCurrentUserMessage
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildProfileImage(),
        const SizedBox(
          width: 5,
        ),
        isCurrentUserMessage ? Container() : Text(counterPartUsername),
        const SizedBox(
          width: 5,
        ),
        _buildChatBubble(),
      ],
    );
  }

  Widget _buildProfileImage() {
    if (isCurrentUserMessage) {
      return Container();
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey,
      backgroundImage: counterPartImageUrl != null
          ? NetworkImage(counterPartImageUrl!)
          : null,
    );
  }

  Widget _buildChatBubble() {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUserMessage ? Colors.yellow : Colors.grey,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isCurrentUserMessage
              ? const Radius.circular(16)
              : const Radius.circular(0),
          bottomRight: isCurrentUserMessage
              ? const Radius.circular(0)
              : const Radius.circular(16),
        ),
      ),
      width: 140,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
