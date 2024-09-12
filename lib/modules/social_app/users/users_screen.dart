import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/shared/components/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state)
      {
        return SocialCubit.get(context).users.length>0 ?
        ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context,index),
          separatorBuilder: (context,index)=>SizedBox(
            height: 15.0,
          ),
          itemCount: SocialCubit.get(context).users.length,
        ) :
        Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context,index )=>InkWell(
    onTap: ()
    {},
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage:NetworkImage(
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
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              SocialCubit.get(context).selectUserItem(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                border: Border.all(
                  color: Colors.deepPurpleAccent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  SocialCubit.get(context).userSelected[index] ? 'UnFollow' : 'Follow',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    ),

  );
}
