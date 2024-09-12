import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

class Search_Screen extends StatelessWidget {
  Search_Screen({super.key});


  @override
  var searchController =TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context,state){},
        builder:(context,state)
        {


          return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
            ),
            body: Column(
              children:
              [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormFiled(controller: searchController,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'cant be Empty';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    functionChange: (value)
                    {
                    },
                  ),
                ),
              //  Expanded(child: Articlebuilder(context,list)),

              ],
            ),
          );}
    );
  }
}