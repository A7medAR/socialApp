import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/social_layout.dart';
import 'package:untitled/modules/social_app/social_register/cubit/cubit.dart';
import 'package:untitled/modules/social_app/social_register/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialCreateUserSuccessState )
          {
             navigatorToAndFinish(context, SocialLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFiled(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'must not be empty';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword: SocialRegisterCubit.get(context).isPassword,
                          OnSubmit: (value)
                          {

                          },
                          suffixPressed:(){
                            SocialRegisterCubit.get(context).changePassword();
                          } ,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFiled(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if(value!.isEmpty)
                            {
                              return 'must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone_android_outlined,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultButton(function: (){
                          if(formKey.currentState!.validate())
                          {
                            SocialRegisterCubit.get(context).userRegister(
                              name:nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone:phoneController.text,
                          );
                          }
                        },
                          text: 'register',
                          isUpperCase: true,
                          radius: 10.0,
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
