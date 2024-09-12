import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/modules/social_app/search/search_screen.dart';
import 'package:untitled/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState)
          {
            navigatorTo(context, NewPostScreen(),);
          }
      },
      builder: (context,state){
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification,)
              ),
              if(cubit.currentIndex==3)
                IconButton(
                  onPressed: (){
                    navigatorTo(context, Search_Screen(),);
                  },
                  icon: Icon(IconBroken.Search,)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
              label: 'Home',),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Setting',),
            ],

          ),
        );
      },
    );
  }
}
