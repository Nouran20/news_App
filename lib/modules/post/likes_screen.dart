import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/models/posts/post_model.dart';
import 'package:newsapp/models/users/users_model.dart';
import 'package:newsapp/modules/profile/user_profile_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/components/constants.dart';
import 'package:newsapp/shared/cubit/app_cubit/cubit.dart';
import 'package:newsapp/shared/cubit/post_cubit/cubit.dart';
import 'package:newsapp/shared/cubit/post_cubit/state.dart';
import 'package:newsapp/shared/cubit/theme_cubit/cubit.dart';
import 'package:newsapp/shared/style/colors.dart';

class LikesScreen extends StatelessWidget {

  List<UserModel> users = [];
  List<LikeModel> likes = [];

  LikesScreen(this.likes);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit,PostStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if(users.isEmpty)
        {
          likes.forEach((element)
          {
            if(element.uId != uId)
              users.add(AppCubit.get(context).users.firstWhere((user) => user.uId == element.uId));
            else
              users.add(AppCubit.get(context).userModel);
          });
        }
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                  'likes'
              ),
            ),
            body: ListView.separated(
              itemCount: users.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: ()
                  {
                    if(AppCubit.get(context).isUserScreen == false)
                    {
                      AppCubit.get(context).openUserScreen();
                      PostCubit.get(context).getUserPosts(userModel:users[index]);
                      navigateTo(context, UserProfileScreen(users[index]));
                    }
                  },
                  child: Container(
                    height: 80,
                    child: Row(
                      children:
                      [
                        buildNetworkProfileImage(
                            imageUrl: users[index].profileImage,
                            radius: 25.0
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          users[index].name,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        if(users[index].uId == 'ff5Nc8LOWIPi6UZfxTDXlRc6lTs1')
                          myVerification(),

                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => myDivider(context),
            ),
          ),
        );
      },
    );
  }
}
