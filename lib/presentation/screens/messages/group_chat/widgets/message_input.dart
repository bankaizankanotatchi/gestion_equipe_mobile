// lib/presentation/screens/messages/group_chat/components/message_input.dart
import 'package:flutter/material.dart';
import 'package:team_manager_app/core/constants/colors.dart';
import 'package:team_manager_app/core/constants/text_styles.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSendMessage;

  const MessageInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSendMessage,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      decoration: InputDecoration(
                        hintText: 'Écrivez un message...',
                        hintStyle: AppTextStyles.body2.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      maxLines: null,
                      onSubmitted: (_) => widget.onSendMessage(),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  if (widget.controller.text.isEmpty)
                    IconButton(
                      icon: Icon(Icons.emoji_emotions, color: Colors.grey.shade500),
                      onPressed: () {},
                    ),
                  if (widget.controller.text.isEmpty)
                    IconButton(
                      icon: Icon(Icons.attach_file, color: Colors.grey.shade500),
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: widget.controller.text.isEmpty
                  ? null
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              color: widget.controller.text.isEmpty
                  ? Colors.grey.shade300
                  : null,
            ),
            child: IconButton(
              icon: Icon(
                widget.controller.text.isEmpty ? Icons.mic : Icons.send,
                color: Colors.white,
                size: 20,
              ),
              onPressed: widget.controller.text.isEmpty ? null : widget.onSendMessage,
            ),
          ),
        ],
      ),
    );
  }
}