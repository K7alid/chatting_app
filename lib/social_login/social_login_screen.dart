import 'package:chatting_app/shared/cache_helper.dart';
import 'package:chatting_app/shared/components.dart';
import 'package:chatting_app/social_layout/social_layout.dart';
import 'package:chatting_app/social_login/cubit/cubit.dart';
import 'package:chatting_app/social_login/cubit/states.dart';
import 'package:chatting_app/social_register/social_register_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(
                context,
                SocialLayout(),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
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
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          text: 'Email Address',
                          prefix: Icons.email_outlined,
                          textInputType: TextInputType.emailAddress,
                          controller: emailController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFormField(
                          text: 'Password',
                          prefix: Icons.lock_outline,
                          onSuffixPressed: () {
                            SocialLoginCubit.get(context).changeIcon();
                          },
                          onSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              // SocialLoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                            }
                          },
                          textInputType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                          },
                          isPassword: SocialLoginCubit.get(context).isNotShown,
                          suffix: SocialLoginCubit.get(context).isNotShown
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                              text: 'register now',
                              function: () {
                                navigateTo(context, SocialRegisterScreen());
                              },
                            ),
                          ],
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

// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:udemy_flutter/layout/social_app/social_layout.dart';
// import 'package:udemy_flutter/modules/social_app/social_login/cubit/cubit.dart';
// import 'package:udemy_flutter/modules/social_app/social_login/cubit/states.dart';
// import 'package:udemy_flutter/modules/social_app/social_register/social_register_screen.dart';
// import 'package:udemy_flutter/shared/components/components.dart';
// import 'package:udemy_flutter/shared/network/local/cache_helper.dart';
//
// class SocialLoginScreen extends StatelessWidget {
//   var formKey = GlobalKey<FormState>();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => SocialLoginCubit(),
//       child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
//         listener: (context, state) {
//           if (state is SocialLoginErrorState) {
//             showToast(
//               text: state.error,
//               state: ToastStates.ERROR,
//             );
//           }
//           if(state is SocialLoginSuccessState)
//           {
//             CacheHelper.saveData(
//               key: 'uId',
//               value: state.uId,
//             ).then((value)
//             {
//               navigateAndFinish(
//                 context,
//                 SocialLayout(),
//               );
//             });
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(),
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'LOGIN',
//                           style: Theme.of(context).textTheme.headline4.copyWith(
//                                 color: Colors.black,
//                               ),
//                         ),
//                         Text(
//                           'Login now to communicate with friends',
//                           style: Theme.of(context).textTheme.bodyText1.copyWith(
//                                 color: Colors.grey,
//                               ),
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         defaultFormField(
//                           controller: emailController,
//                           type: TextInputType.emailAddress,
//                           validate: (String value) {
//                             if (value.isEmpty) {
//                               return 'please enter your email address';
//                             }
//                           },
//                           label: 'Email Address',
//                           prefix: Icons.email_outlined,
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultFormField(
//                           controller: passwordController,
//                           type: TextInputType.visiblePassword,
//                           suffix: SocialLoginCubit.get(context).suffix,
//                           onSubmit: (value) {
//                             if (formKey.currentState.validate()) {
//                               // SocialLoginCubit.get(context).userLogin(
//                               //   email: emailController.text,
//                               //   password: passwordController.text,
//                               // );
//                             }
//                           },
//                           isPassword: SocialLoginCubit.get(context).isPassword,
//                           suffixPressed: () {
//                             SocialLoginCubit.get(context)
//                                 .changePasswordVisibility();
//                           },
//                           validate: (String value) {
//                             if (value.isEmpty) {
//                               return 'password is too short';
//                             }
//                           },
//                           label: 'Password',
//                           prefix: Icons.lock_outline,
//                         ),
//                         SizedBox(
//                           height: 30.0,
//                         ),
//                         ConditionalBuilder(
//                           condition: state is! SocialLoginLoadingState,
//                           builder: (context) => defaultButton(
//                             function: () {
//                               if (formKey.currentState.validate()) {
//                                 SocialLoginCubit.get(context).userLogin(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                 );
//                               }
//                             },
//                             text: 'login',
//                             isUpperCase: true,
//                           ),
//                           fallback: (context) =>
//                               Center(child: CircularProgressIndicator()),
//                         ),
//                         SizedBox(
//                           height: 15.0,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Don\'t have an account?',
//                             ),
//                             defaultTextButton(
//                               function: () {
//                                 navigateTo(
//                                   context,
//                                   SocialRegisterScreen(),
//                                 );
//                               },
//                               text: 'register',
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
