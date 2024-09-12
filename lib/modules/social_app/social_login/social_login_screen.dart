import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/network/local/cahce_helper.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/social_login/cubit/cubit.dart';
import 'package:untitled/modules/social_app/social_login/cubit/states.dart';
import 'package:untitled/modules/social_app/social_register/cubit/states.dart';
import 'package:untitled/modules/social_app/social_register/social_register_screen.dart';

import '../../../shared/components/components.dart';

class SocialLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
    create: (context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state){
          if(state is SocialLoginErrorState)
          {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if(state is SocialLoginSuccessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigatorToAndFinish(context, SocialLayout());
              });
            }


        },
        builder: (context,state){
          SocialLoginCubit cubit=SocialLoginCubit.get(context);
          return  Scaffold(
              appBar: AppBar(),
              body:Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Login now to communicate with friends',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFiled(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if(value!.isEmpty)
                              {
                                return 'must not be empty';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormFiled(
                            controller: passwordController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if(value!.isEmpty)
                              {
                                return 'must not be empty';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            OnSubmit: (value)
                            {
                              if(formKey.currentState!.validate())
                              {
                                 cubit.userLogin(email: emailController.text, password: passwordController.text);
                              };
                            },
                            suffixPressed:(){
                              cubit.changePassword();
                            } ,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          defaultButton(function: (){
                            if(formKey.currentState!.validate())
                            {
                               cubit.userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                            text: 'login',
                            isUpperCase: true,
                            radius: 10.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Don\'t have an account?'
                              ),
                              TextButton(onPressed: (){
                               navigatorTo(context, SocialRegisterScreen());
                              }, child: Text('REGISTER'),)
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },

      ),
    );

  }
}
