import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
var textController=TextEditingController();
var dateTimeController=TextEditingController();
var now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialCreatePostSuccessState)
          {
            navigatorTo(context, SocialLayout());
          }
      },
      builder: (context,state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Add Post',
            actions: [
              TextButton(
                  onPressed: (){
                    if(SocialCubit.get(context).postImage == null)
                      {
                        SocialCubit.get(context).createNewPost(text: textController.text, dateTime: now.toString(),);
                        print(textController.text);
                        textController.clear();

                      }
                    else
                      {
                        SocialCubit.get(context).uploadPostImage(text: textController.text, dateTime: now.toString(),);

                      }
                  },
                   child: Text('post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
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
                    decoration: InputDecoration(
                      hintText: 'What on your mind ...',
                      border: InputBorder.none,
                    ),
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
