import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/comments/comment_screen.dart';
import 'package:untitled/shared/components/components.dart';

class EditCommentScreen extends StatelessWidget {
  final String text;
  final String dateTime;
  final String postId;
  final String commentId;

  EditCommentScreen({
    required this.text,
    required this.commentId,
    required this.dateTime,
    required this.postId,
  });

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
          if(state is SocialCommentUpdateSuccessState)
          {
            navigatorTo(context, CommentScreen(postId: postId,));
          }

        },
        builder: (context,state){
          textController.text =text;

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Comment',
              actions: [
                TextButton(
                  onPressed: (){

                      SocialCubit.get(context).updateComment(text:textController.text, postId: postId ,dateTime: dateTime , commentId: commentId, );

                  },
                  child: Text('Update Comment'),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialPostUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialPostUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel?.image!}'
                        ),
                      ),
                      SizedBox(
                        width: 15.0,),
                      Expanded(
                        child:  Text(
                          '${SocialCubit.get(context).userModel?.name!}',
                          style: TextStyle(
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,


                    ),
                  ),


                ],
              ),
            ),
          );
        }
    );
  }
}
