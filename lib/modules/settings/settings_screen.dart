import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:newsapp/modules/login/login_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/app_cubit/cubit.dart';
import 'package:newsapp/shared/cubit/post_cubit/cubit.dart';
import 'package:newsapp/shared/cubit/theme_cubit/cubit.dart';
import 'package:newsapp/shared/cubit/theme_cubit/state.dart';
import 'package:newsapp/shared/style/colors.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit,ThemeStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Row(
                  children:
                  [
                    Icon(Icons.dark_mode, color: ThemeCubit.get(context).isDark ? appLightColor : appDarkColor ,),
                    SizedBox(width: 5.0,),
                    Text('Dark mood: ',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18)
                    ),
                    Spacer(),
                    Switch(
                      value: ThemeCubit.get(context).isDark,
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.black,
                      onChanged: (value)=> ThemeCubit.get(context).changeAppTheme(),
                    )
                  ],
                ),
                SizedBox(height: 5.0,),
                myDivider(context),
                SizedBox(height: 10.0,),
                InkWell(
                onTap: () {
                  showDefaultDialog(
                    context: context,
                    title: 'About Us',
                    buttonText: 'Close !',
                    widget: Container(
                      height: 150,
                      child: Column(
                        children:
                        [
                          Text('The creator of Friends \' Ahmed Samy \' send his regards and wish you have liked the app.',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),);
                },
                child: Row(
                  children:
                  [
                    Icon(Icons.info,size: 30.0,color: ThemeCubit.get(context).isDark ? appLightColor : appDarkColor,),
                    SizedBox(width: 5.0,),
                    Text('About Us?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),),
                  ],
                ),
              ),
                SizedBox(height: 5.0,),
                myDivider(context),
                SizedBox(height: 10.0,),
                InkWell(
                  onTap: () {
                    AppCubit.get(context).userModel.clear();
                    AppCubit.get(context).users = [];
                    PostCubit.get(context).homePosts = [];
                    navigateAndDelTo(context, LoginScreen());
                    AppCubit.get(context).logOut();
                  },
                  child: Row(
                    children:
                    [
                      Icon(Icons.logout,size: 30.0,color: ThemeCubit.get(context).isDark ? appLightColor : appDarkColor,),
                      SizedBox(width: 5.0,),
                      Text('Logout',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),),
                    ],
                  ),
                ),
                SizedBox(height: 5.0,),
                myDivider(context),
                SizedBox(height: 10.0,),
                Row(
                  children:
                  [
                    Text('Rate our App',
                        style: Theme.of(context).textTheme.bodyText2
                    ),
                    SizedBox(width: 5.0,),
                    RatingBar.builder(
                      initialRating: AppCubit.get(context).userModel.rate.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        AppCubit.get(context).updateUser(
                            name: AppCubit.get(context).userModel.name,
                            bio: AppCubit.get(context).userModel.bio,
                            phone: AppCubit.get(context).userModel.phone,
                          rate: rating
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 5.0,),
              ],
            ),
        );
      },
    );
  }
}
