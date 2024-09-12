import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/layout/social_app/cubit/states.dart';
import 'package:untitled/models/social_app/comment_model.dart';
import 'package:untitled/models/social_app/messeage_screen.dart';
import 'package:untitled/models/social_app/post_model.dart';
import 'package:untitled/models/social_app/social_user_model.dart';
import 'package:untitled/modules/social_app/chats/chats_screen.dart';
import 'package:untitled/modules/social_app/feeds/feeds_screen.dart';
import 'package:untitled/modules/social_app/new_post/new_post_screen.dart';
import 'package:untitled/modules/social_app/settings/settings_screen.dart';
import 'package:untitled/modules/social_app/users/users_screen.dart';
import 'package:untitled/shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context)=>BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
            (value) {
            //  print(value.data());
              userModel=SocialUserModel.fromJson(value.data()!);
              emit(SocialGetUserSuccessState());
            }).catchError(
            (error){

              emit(SocialGetUserErrorState(error.toString()));

            });
  }

  int currentIndex =0;
  List<Widget> screens=
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),

  ];

  List<String> titles=
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',

  ];

  void changeBottomNav(int index)
  {

    if(index==2)
      {
        emit(SocialNewPostState());
      }
    else {
      currentIndex=index;

      emit(SocialChangeBottomNavState());
    }
  }

   File? profileImage;
  var picker =ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else
    {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }

  }

   File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else
    {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }

  }
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,

  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value)
    {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadProfileImagePickedSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error){
        print('object1');
        print(error.toString());
        emit(SocialUploadProfileImagePickedErrorState(error.toString()));


      });
    }).catchError((error){
      print('object2');

      emit(SocialUploadProfileImagePickedErrorState(error.toString()));
      print(error.toString());

    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,

  })
  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!).then((value)
    {
      value.ref.getDownloadURL().then((value) {

     //   emit(SocialUploadCoverImagePickedSuccessState());
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error){
        print(error.toString());
        emit(SocialUploadCoverImagePickedErrorState(error.toString()));

      });
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadCoverImagePickedErrorState(error.toString()));
    });
  }



  void updateUser({
    required String name,
    required String phone,
    required String bio,
     String? cover,
     String? image,

  })
  {
    emit(SocialUserUpdateLoadingState());
    SocialUserModel model =SocialUserModel(
      name: name,
      uId:userModel?.uId ,
      bio: bio,
      image:image?? userModel?.image,
      phone: phone,
      cover: cover??userModel?.cover,
      email: userModel?.email,
      isEmailVerified:false,
    );
    FirebaseFirestore.instance.collection('users').doc(userModel?.uId).update(model.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(SocialUserUpdateErrorState());
    });
  }


  File? postImage;
  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else
    {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }

  }

  // void uploadPostImage({
  //   required String text,
  //   required String dateTime,
  //
  // })
  // {
  //   emit(SocialCreatePostLoadingState());
  //   firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  //       .putFile(postImage!).then((value)
  //   {
  //     value.ref.getDownloadURL().then((value) {
  //
  //         createNewPost(
  //         text: text,
  //         dateTime: dateTime,
  //         postImage: value,
  //   );
  //     }).catchError((error){
  //       print(error.toString());
  //       emit(SocialCreatePostErrorState());
  //
  //     });
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(SocialCreatePostErrorState());
  //   });
  // }
  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    if (postImage == null) {
      print("Error: No image selected.");
      emit(SocialCreatePostErrorState());
      return;
    }

    emit(SocialCreatePostLoadingState());

    String fileName = Uri.file(postImage!.path).pathSegments.last;

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/$fileName')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageUrl) {
        createNewPost(
          text: text,
          dateTime: dateTime,
          postImage: imageUrl,
        );
      }).catchError((error) {
        print("Failed to get download URL: ${error.message}");
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print("Failed to upload image: ${error.message}");
      if (error.code == 'object-not-found') {
        print("The specified file was not found on the server.");
      }
      emit(SocialCreatePostErrorState());
    });
  }

  void createNewPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance.collection('posts').add(model.toMap()).then((value) {
      // تحديث postId بعد إنشاء الوثيقة
      FirebaseFirestore.instance.collection('posts').doc(value.id).update({
        'postId': value.id,
      }).then((_) {
        model.postId = value.id; // تعيين postId في النموذج
        emit(SocialCreatePostSuccessState());
        getPosts();
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void updatePost({
    required String text,
    String? postImage,
    String? dateTime,
    required String postId,

  })
  {
    emit(SocialPostUpdateLoadingState());
    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      postId: postId,
      dateTime: dateTime,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance.collection('posts').doc(postId).update(model.toMap()).
    then((value) {
      getPosts();
      emit(SocialPostUpdateSuccessState());
    }).catchError((error){
      emit(SocialPostUpdateErrorState());
    });
  }

  void updateComment({
    required String text,
    required String postId,
    required String dateTime,
    required String commentId,


  }) {
    emit(SocialCreateCommentLoadingState());

    CommentModel model = CommentModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,
      commentId: commentId,

    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments').doc(commentId)
        .update(model.toMap())
        .then((value) {
     emit(SocialCommentUpdateSuccessState());
    }).catchError((error) {
      emit(SocialCommentUpdateErrorState());
    });
  }
  void removePostImage()
  {
    postImage= null;
    emit(SocialRemovePostImagePickedState());
  }

List<PostModel>posts=[];
List<String>postsId=[];
List<int>likes=[];
List<int>comment=[];
List<SocialUserModel>users=[];
void getPosts() {
    emit(SocialGetPostLoadingState());

    FirebaseFirestore.instance.collection('posts').orderBy('dateTime',descending: true).get().then((value) {
      posts.clear();
      postsId.clear();
      likes.clear();
      comment.clear();

      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((commentValue) {
          comment.add(commentValue.docs.length);
          emit(SocialGetCommentCountsSuccessState());

          element.reference.collection('likes').get().then((likeValue) {
            likes.add(likeValue.docs.length);

            posts.add(PostModel.fromJson(element.data())..postId = element.id);
            postsId.add(element.id);

            emit(SocialGetLikeSuccessState());
          }).catchError((error) {
            emit(SocialGetLikeErrorState(error.toString()));
          });

        }).catchError((error) {
          emit(SocialGetCommentErrorState(error.toString()));
        });
      });

      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void deletePost(int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId[index])
        .collection('comments')
        .get()
        .then((value) {
      // ابدأ بحذف جميع التعليقات المرتبطة بالبوست
      WriteBatch batch = FirebaseFirestore.instance.batch();

      value.docs.forEach((element) {
        batch.delete(element.reference);
      });

      // بعد حذف جميع التعليقات، احذف البوست نفسه
      batch.commit().then((_) {
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postsId[index])
            .delete()
            .then((_) {
          posts.removeAt(index);
          emit(SocialDeletePostSuccessState());
          getPosts();
        }).catchError((error) {
          emit(SocialDeletePostErrorState());
        });
      }).catchError((error) {
        emit(SocialDeleteCommentPostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialDeleteCommentPostErrorState(error.toString()));
    });
  }

  void deleteComment(String postId, String commentId, int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete()
        .then((_) {
      emit(SocialDeleteCommentPostSuccessState());
      getPosts();

    }).catchError((error) {
      print(error.toString());
      emit(SocialDeleteCommentPostErrorState(error.toString()));
    });
  }


  
  void likePost(String postId)
  {
    FirebaseFirestore.instance.
    collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId)
        .set(
        {'like':true,})
        .then((value) {
          emit(SocialLikePostSuccessState());
          getPosts();

    })
        .catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
    });
  }
  void createComment({
    required String text,
    required String postId,
    required String dateTime,

  }) {
    emit(SocialCreateCommentLoadingState());

    CommentModel model = CommentModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image: userModel?.image,
      text: text,
      dateTime: dateTime,

    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('posts').doc(postId)
          .collection('comments').doc(value.id).update({
        'commentId': value.id,
      }).then((_) {
        model.commentId = value.id;
        emit(SocialCommentPostSuccessState());
        getPosts();

      }).catchError((error) {
        emit(SocialCommentPostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }
List<bool>userSelected=[];
  void getUsers()
  {
    if(users.length==0)
      FirebaseFirestore.instance.collection('users').get().then((value)
      {
        emit(SocialGetAllUserLoadingState());

        value.docs.forEach((element) {
          if(element.data()['uId'] !=userModel?.uId)
            users.add(SocialUserModel.fromJson(element.data()));
          if(userSelected.length!=users.length)
            users.forEach((element) {
           userSelected.add(false);
          },);


        });
        emit(SocialGetAllUserSuccessState());

      })
          .catchError((error){
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void selectUserItem(int index) {
    userSelected[index] = !userSelected[index];  // تبديل القيمة الحالية
    emit(SocialChangeIsGridState());
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
})
{
  MessageModel model=MessageModel(
    receiverId: receiverId,
    senderId: userModel?.uId,
    dateTime: dateTime,
    text: text,
  );
  //set my chats
  FirebaseFirestore.instance.
  collection('users').
  doc(userModel?.uId).
  collection('chats').
  doc(receiverId).
  collection('messages').
  add(model.toMap()).
  then((value)
  {
    emit(SocialSendMessageSuccessState());
  }).
  catchError((error)
  {
    emit(SocialSendMessageErrorState(error));
  });
//set receiver chats
  FirebaseFirestore.instance.
  collection('users').
  doc(receiverId).
  collection('chats').
  doc(userModel?.uId).
  collection('messages').
  add(model.toMap()).
  then((value)
  {
    emit(SocialSendMessageSuccessState());
  }).
  catchError((error)
  {
    emit(SocialSendMessageErrorState(error));
  });
}
List<MessageModel>messages=[];
void getMessages({
    required String receiverId,
})
{
  FirebaseFirestore.instance.
  collection('users').doc(userModel?.uId).
  collection('chats').doc(receiverId).
  collection('messages').orderBy('dateTime').snapshots().listen((event)
  {
    messages=[];
    event.docs.forEach((element)
    {
      messages.add(MessageModel.fromJson(element.data()));
    });

    emit(SocialGetMessagesSuccessState());
  }
  );
}
  List<CommentModel> comments = [];
  List<String>commentId=[];

  void getComments(String postId) {
    emit(SocialGetCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments.clear();
      event.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data())..commentId = element.id);
        commentId.add(element.id);

      });

      emit(SocialGetCommentSuccessState());

    }).onError((error) {
      emit(SocialGetCommentErrorState(error.toString()));
    });
  }




}