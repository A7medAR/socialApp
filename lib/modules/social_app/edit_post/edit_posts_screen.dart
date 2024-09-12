import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/shared/components/components.dart';

class EditPostScreen extends StatelessWidget {
  final String text;
  final String dateTime;
  final String postId;
  final String postImage;

  EditPostScreen({
    required this.text,
    required this.postImage,
    required this.dateTime,
    required this.postId,
  });

  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
            if(state is SocialPostUpdateSuccessState)
              {
                navigatorTo(context, SocialLayout());
              }

        },
        builder: (context,state){
          textController.text =text;

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Post',
              actions: [
                TextButton(
                  onPressed: (){
                    if(SocialCubit.get(context).postImage == null)
                    {
                      SocialCubit.get(context).updatePost(text:textController.text, postId: postId ,dateTime: dateTime ,postImage: postImage, );


                    }
                    // else
                    // {
                    //   SocialCubit.get(context).uploadPostImage(text: textController.text, dateTime: now.toString(),);
                    //
                    // }
                  },
                  child: Text('Update Post'),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  if(SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0,),
                            image: DecorationImage(
                              image:FileImage(SocialCubit.get(context).postImage!,) as ImageProvider<Object>,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(onPressed: (){},
                          child: Text(
                            '# tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
