import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/modules/social_app/comments/comment_screen.dart';
import 'package:untitled/modules/social_app/edit_post/edit_posts_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class FeedsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return SocialCubit.get(context).posts.length > 0 &&
            SocialCubit.get(context).userModel != null
            ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 20.0,
                margin: EdgeInsets.all(8.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://img.freepik.com/free-photo/social-media-marketing-concept-marketing-with-applications_23-2150063134.jpg?t=st=1724511680~exp=1724515280~hmac=0e537a1cda6907e86e171fa5ef1c3feadcf5c9fb8865c1d226ad07a2a5f70378&w=900',
                      ),
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black,),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => buildPostItem(
                    SocialCubit.get(context).posts[index],
                    context,
                    index),
                separatorBuilder: (context, index) => SizedBox(
                  height: 8.0,
                ),
                itemCount: SocialCubit.get(context).posts.length,
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) {

    var formKey = GlobalKey<FormState>(); // إنشاء مفتاح جديد لكل نموذج
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
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
                      Text(
                        model.dateTime!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),

                if(SocialCubit.get(context).userModel?.uId==SocialCubit.get(context).posts[index].uId)
                  PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 1) {
                      AwesomeDialog(
                        context: context,
                        desc: 'Do you sure for edit  ',
                        dialogType:DialogType.noHeader,
                        btnOkOnPress: (){

                          navigatorTo(context, EditPostScreen(
                              text: SocialCubit.get(context).posts[index].text!,
                              postImage: SocialCubit.get(context).posts[index].postImage!,
                              dateTime: SocialCubit.get(context).posts[index].dateTime!,
                              postId: SocialCubit.get(context)
                                  .posts[index]
                                  .postId!
                          ),);
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
                          SocialCubit.get(context).deletePost(index);
                          Navigator.of(context).pushReplacementNamed("FeedsScreen");

                        },
                        btnCancelOnPress: (){
                        },

                      ).show();}
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
                if(SocialCubit.get(context).userModel?.uId!=SocialCubit.get(context).posts[index].uId)
                  PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == 1) {
                      AwesomeDialog(
                        context: context,
                        desc: 'Do you sure for delete  ',
                        dialogType:DialogType.noHeader,
                        btnOkOnPress: () {
                          SocialCubit.get(context).deletePost(index);
                        },
                        btnCancelOnPress: (){
                        },

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
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              model.text!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${model?.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        navigatorTo(
                          context,
                          CommentScreen(
                              postId: SocialCubit.get(context)
                                  .posts[index]
                                  .postId!),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).comment[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel?.image}',
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 1.0,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      SocialCubit.get(context).createComment(
                        text: commentController.text,
                        postId: SocialCubit.get(context).postsId[index], dateTime: DateTime.now().toString(),
                      );
                      commentController.clear();
                    }
                  },
                  child: Icon(
                    IconBroken.Send,
                    size: 16.0,
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).postsId[index]);
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     IconButton(onPressed: ()
//     {
//       SocialCubit.get(context).changeShowPosts(grid: true);
//
//     },
//       icon: Icon(
//         Icons.grid_on,
//         color: SocialCubit.get(context).isGrid ? Colors.blue : Colors.grey[400],
//     ),
//     ),
//     IconButton(onPressed: (){
//       SocialCubit.get(context).changeShowPosts(grid: false);
//
//     },
//       icon: Icon(
//           Icons.list,
//         color: !SocialCubit.get(context).isGrid ? Colors.blue : Colors.grey[400],
//
//       ),
//     )
//   ],
// ),

