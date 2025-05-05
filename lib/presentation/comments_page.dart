import 'package:flutter/material.dart';
import 'package:task_11/data/models/comment.dart';
import 'package:task_11/data/servicies/comment_api_service.dart';

class CommentsPage extends StatelessWidget {
  final int postId;

  const CommentsPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: FutureBuilder<List<Comment>>(
        future: CommentService().fetchComments(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No comments'));
          }

          final comments = snapshot.data!;
          return ListView.separated(
            itemCount: comments.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return ListTile(
                title: Text(comment.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(comment.body),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}