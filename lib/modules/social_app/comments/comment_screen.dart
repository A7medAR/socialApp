import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/comment_model.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/modules/social_app/edit_comments/edit_comment_screen.dart';
import 'package:untitled/shared/components/components.dart';

class CommentScreen extends StatelessWidget {
  final String postId;

  CommentScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getComments(postId);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Comments',
          ),
          body: state is SocialGetCommentLoadingState
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            physics: BouncingScrollPhysics(),

            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildCommentItem(SocialCubit.get(context).comments[index], context,index),
              separatorBuilder: (context, index) => SizedBox(height: 8.0),
              itemCount: SocialCubit.get(context).comments.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildCommentItem(CommentModel model, context,int index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundImage: NetworkImage(
            '${model.image}',
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${model.name}',
                                  style: TextStyle(
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        if(SocialCubit.get(context).userModel?.uId==SocialCubit.get(context).comments[index].uId)
                          PopupMenuButton<int>(
                            onSelected: (value) {
                              if (value == 1) {
                                AwesomeDialog(
                                  context: context,
                                  desc: 'Do you sure for edit  ',
                                  dialogType:DialogType.noHeader,
                                  btnOkOnPress: (){
                                    navigatorTo(
                                        context,
                                        EditCommentScreen(
                                          text: SocialCubit.get(context).comments[index].text!,
                                          commentId: SocialCubit.get(context).comments[index].commentId!,
                                          dateTime: SocialCubit.get(context).comments[index].dateTime!,
                                          postId: postId,
                                        )
                                    );
                                  },
                                  btnCancelOnPress: (){},

                                ).show();

                              }
                              else if (value == 2) {
                                AwesomeDialog(
                                  context: context,
                                  desc: 'Do you sure for delete  ',
                                  dialogType:DialogType.noHeader,
                                  btnOkOnPress: () {
                                    SocialCubit cubit = SocialCubit.get(context);

                                    if (cubit.posts.isNotEmpty && cubit.commentId.isNotEmpty) {
                                      cubit.deleteComment(
                                        postId,
                                        cubit.comments[index].commentId!,  // استخدم الفهرس الصحيح لجلب commentId المناسب
                                        index, // تمرير الفهرس لحذف العنصر الصحيح من القائمة المحلية
                                      );
                                    } else {
                                      print('No comments or posts available to delete.');
                                    }
                                  },                                btnCancelOnPress: (){
                                },
/*deleteComment(postId: SocialCubit.get(context).posts[index].postId!),SocialCubit.get(context).commentId[index]);*/
                                ).show();
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 8.0),
                                    Text(' edit post'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 8.0),
                                    Text('delete post'),
                                  ],
                                ),
                              ),
                            ],
                            icon: Icon(
                              Icons.more_horiz,
                              size: 16.0,
                            ),
                            offset: Offset(0, 0), // لضبط الموقع بالنسبة للأيقونة
                          ),
                        if(SocialCubit.get(context).userModel?.uId!=SocialCubit.get(context).comments[index].uId)
                          PopupMenuButton<int>(
                            onSelected: (value) {
                               if (value == 1) {
                                AwesomeDialog(
                                  context: context,
                                  desc: 'Do you sure for delete  ',
                                  dialogType:DialogType.noHeader,
                                  btnOkOnPress: () {
                                    SocialCubit cubit = SocialCubit.get(context);

                                    if (cubit.posts.isNotEmpty && cubit.commentId.isNotEmpty) {
                                      cubit.deleteComment(
                                        postId,
                                        cubit.comments[index].commentId!,  // استخدم الفهرس الصحيح لجلب commentId المناسب
                                        index, // تمرير الفهرس لحذف العنصر الصحيح من القائمة المحلية
                                      );
                                    } else {
                                      print('No comments or posts available to delete.');
                                    }
                                  },
                                  btnCancelOnPress: (){},
                                ).show();
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 8.0),
                                    Text('delete post'),
                                  ],
                                ),
                              ),
                            ],
                            icon: Icon(
                              Icons.more_horiz,
                              size: 16.0,
                            ),
                            offset: Offset(0, 0), // لضبط الموقع بالنسبة للأيقونة
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${model.text}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '${model.dateTime}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

