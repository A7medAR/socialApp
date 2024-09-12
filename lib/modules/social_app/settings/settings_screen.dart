import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/modules/social_app/comments/comment_screen.dart';
import 'package:untitled/modules/social_app/edit_post/edit_posts_screen.dart';
import 'package:untitled/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/modules/social_app/social_login/social_login_screen.dart';
import 'package:untitled/modules/social_app/social_register/social_register_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var posts = SocialCubit.get(context).posts
            .where((post) => post.uId == userModel?.uId)
            .toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                // User profile section
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userModel?.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage('${userModel?.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Text('${userModel?.name}',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('${userModel?.bio}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '${posts.length}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '20k',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Add other stats for followers and followings
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigatorTo(context, NewPostScreen());
                        },
                        child: Text('Add post'),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    OutlinedButton(
                      onPressed: () {
                        navigatorTo(
                          context,
                          EditProfileScreen(),
                        );
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPostItem(posts[index], context, index);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8.0),
                  itemCount: posts.length,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
        );
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }

}
