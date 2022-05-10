import 'package:chatting_app/bottomNavBar_%20screens/new_post_screen.dart';
import 'package:chatting_app/shared/components.dart';
import 'package:chatting_app/shared/icon_broken.dart';
import 'package:chatting_app/social_layout/cubit/cubit.dart';
import 'package:chatting_app/social_layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialNewPostState) {
        navigateTo(context, NewPostScreen());
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);

      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconBroken.Notification,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                IconBroken.Search,
              ),
            ),
          ],
          title: Text(
            cubit.titles[cubit.currentIndex],
          ),
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Chat,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Paper_Upload,
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.User,
              ),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Setting,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeBottomNav(index);
          },
        ),
      );
    });
  }
}

/*

ConditionalBuilder(
              condition: SocialCubit.get(context).model != null,
              builder: (context) {
                var model = FirebaseAuth.instance.currentUser!.emailVerified;

                return Column(
                  children: [
                    if (!model)
                      Container(
                        color: Colors.amber.withOpacity(0.6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              const Expanded(
                                child: Text(
                                  'Plz verify your email',
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              defaultTextButton(
                                text: 'send',
                                function: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                      text: 'Check your email',
                                      state: ToastStates.SUCCESS,
                                    );
                                  }).catchError(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),

* */
