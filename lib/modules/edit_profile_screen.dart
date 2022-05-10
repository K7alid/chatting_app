import 'package:chatting_app/shared/components.dart';
import 'package:chatting_app/shared/icon_broken.dart';
import 'package:chatting_app/social_layout/cubit/cubit.dart';
import 'package:chatting_app/social_layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        passwordController.text = userModel.password;
        phoneController.text = userModel.phone;

        return Scaffold(
          appBar: AppBar(
            actions: [
              defaultTextButton(
                text: 'update',
                function: () {
                  SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                    password: passwordController.text,
                  );
                },
              ),
              const SizedBox(
                width: 15,
              ),
            ],
            titleSpacing: 5,
            title: const Text(
              'Edit profile',
            ),
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 170,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    topRight: Radius.circular(7.0),
                                  ),
                                  image: coverImage == null
                                      ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            userModel.coverImage,
                                          ),
                                        )
                                      : DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(coverImage),
                                        ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              radius: 64,
                              child: profileImage == null
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                        userModel.image,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage: FileImage(profileImage),
                                    ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                      password: passwordController.text,
                                    );
                                  },
                                  text: 'Upload Profile',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                      password: passwordController.text,
                                    );
                                  },
                                  text: 'Upload Cover',
                                ),
                                if (state is SocialUserUpdateLoadingState)
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUserUpdateLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultTextFormField(
                    text: 'Name',
                    prefix: IconBroken.User,
                    textInputType: TextInputType.name,
                    controller: nameController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Name mus\'nt be empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                    text: 'Bio',
                    prefix: IconBroken.Info_Circle,
                    textInputType: TextInputType.text,
                    controller: bioController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Bio mus\'nt be empty';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                    text: 'Password',
                    prefix: IconBroken.Lock,
                    onSuffixPressed: () {
                      SocialCubit.get(context).changeIcon();
                    },
                    textInputType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      }
                    },
                    isPassword: SocialCubit.get(context).isNotShown,
                    suffix: SocialCubit.get(context).isNotShown
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'please enter your phone number';
                      }
                    },
                    text: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
