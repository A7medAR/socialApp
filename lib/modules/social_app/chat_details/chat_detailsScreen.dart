import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/messeage_screen.dart';
import 'package:untitled/models/social_app/social_user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
SocialUserModel? userModel;
ChatDetailsScreen({
   this.userModel,
});
var messageController= TextEditingController();
var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (BuildContext context){
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!,);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener:(context,state){

          },
          builder: (context,state){
            return   Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        '${userModel?.image}',
                      ),

                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${userModel?.name}',
                    ),
                  ],
                ),
              ),
              body:
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                              reverse: true,
                              itemBuilder: (context,index)
                              {
                                var message=SocialCubit.get(context).messages[index];
                                if(SocialCubit.get(context).userModel?.uId==message.senderId)
                                    return buildMyMessage(message);
                                return  buildMessage(message);
                              },
                              separatorBuilder: (context,index)=>SizedBox(
                                height: 15.0,
                              ),
                              itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0,),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (String? value) {
                                            if(value!.isEmpty)
                                            {
                                            return '';
                                            }
                                            },
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'write your messege here ...',
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  minWidth: 1.0,
                                  onPressed: ()
                                  {
                                    if(formKey.currentState!.validate())
                                    { SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                    messageController.clear();
                                    };



                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },


        );
      },

    );
  }
  Widget buildMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding:  const EdgeInsets.symmetric(horizontal: 10.0,
        vertical: 5.0,),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      child: Text(
        model.text!,
      ),
    ),
  );
  Widget buildMyMessage(MessageModel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding:  const EdgeInsets.symmetric(horizontal: 10.0,
        vertical: 5.0,),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(.2),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      child: Text(
          model.text!,
      ),
    ),
  );
}
