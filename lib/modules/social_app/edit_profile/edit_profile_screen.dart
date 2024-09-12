import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
var nameController=TextEditingController();
var bioController=TextEditingController();
var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit profile',
            actions: [
              TextButton(onPressed: (){
                SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
              },
                child: Text('Update',),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 190.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image:coverImage==null? NetworkImage(
                                      '${userModel.cover}',
                                    ):FileImage(coverImage,) as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}' )
                                    : FileImage(profileImage) as ImageProvider<Object>,

                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16.0,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  Row(
                  children: [
                      if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                              function:(){
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);
                              } ,
                              text: 'upload profile ',
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                    ),

                    SizedBox(
                      width: 5.0,
                    ),
                    if(SocialCubit.get(context).coverImage != null)
                      Expanded(
                      child: Column(
                        children: [
                          defaultButton(
                            function:(){
                              SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);

                            } ,
                            text: 'upload cover ',
                          ),
                          SizedBox(
                            height:10.0,
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
                defaultFormFiled(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value){
                    if(value!.isEmpty)
                      {
                        return 'can\'t be empty';
                      };
                    return null;

                  },
                  label: 'Name',
                  prefix: IconBroken.User,
                ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormFiled(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'can\'t be empty';
                      };
                      return null;

                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormFiled(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return 'can\'t be empty';
                      };
                      return null;

                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
