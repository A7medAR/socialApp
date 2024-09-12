import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/shared/cubit/states.dart';
import 'package:untitled/shared/network/local/cahce_helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

static AppCubit get(context)=> BlocProvider.of(context);
  int currentIndex=0;
  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archivedTasks=[];
  bool isBottomSheetShown =false;
  IconData fabIcon=Icons.edit;
  bool isDark=true;

  void changeAppMode( {bool? fromShared})
  {
    if(fromShared !=null)
    {
      isDark=fromShared ;
      emit(AppChangeModeStates());
    }

    else{
      isDark=!isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      emit(AppChangeModeStates());
    }
    );

  }
  }
  List<String>titles=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
 void changeIndex(int index)
 {
   currentIndex=index;
   emit(AppChangeBottomNavBarState());

  }
  void changeBottomSheetState({required bool isShow,required IconData icon})
  {
    isBottomSheetShown= isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetBarState());
  }
  void createDatabase()
  {

     openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database,version)
      {
        print('database created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY , title TEXT , data TEXT, time TEXT , status TEXT)').then((value) {
          print('table created');
        }).catchError((error){print('Error when Create ${error.toString()}');});
      },

      onOpen: (database){
        print('database opened');
        getDataFormDatabase(database);
      },
    ).then((value) {
      database=value;
      emit(AppCreateDatabaseState());
     });
  }
 void  insertDatabase({
    required title,
    required date,
    required time,
  })
  {
      database.transaction((txn) async {
      txn.rawInsert('INSERT INTO tasks(title,date,time,status)VALUES("$title","$date","$time","new")'
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFormDatabase(database);
      }).catchError((error){
        print('Error when inserting record ${error.toString()}');

      });

    });
  }
void getDataFormDatabase(database)
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
     database.rawQuery('SELECT * FROM tasks').then((value)
     {

       value.forEach((element)
       {
         if(element['status']=='new')
           newTasks.add(element);
         if(element['status']=='done')
           doneTasks.add(element);
         else
           archivedTasks.add(element);
       }
       );
       emit(AppGetDatabaseState());
     });
  }


  void updateData({
    required String status,
    required int id,
})
{  database.rawUpdate(
'UPDATE tasks SET status = ? WHERE id = ?',
[' $status', id]).then((value) {
  getDataFormDatabase(database);
  emit(AppUpdateDatabaseState());
});


}

}