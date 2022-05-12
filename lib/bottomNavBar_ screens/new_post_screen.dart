import 'package:chatting_app/shared/components.dart';
import 'package:chatting_app/shared/icon_broken.dart';
import 'package:chatting_app/social_layout/cubit/cubit.dart';
import 'package:chatting_app/social_layout/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postImage = SocialCubit.get(context).postImage;

        return ConditionalBuilder(
          condition: SocialCubit.get(context).userModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              titleSpacing: 5,
              title: const Text(
                'Create Post',
              ),
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                defaultTextButton(
                    text: 'Post',
                    function: () {
                      if (SocialCubit.get(context).postImage == null) {
                        SocialCubit.get(context).createPost(
                          dateTime: DateTime.now().toString(),
                          text: textController.text,
                        );
                      } else {
                        SocialCubit.get(context).uploadPostImage(
                          dateTime: DateTime.now().toString(),
                          text: textController.text,
                        );
                      }
                    }),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SocialCreatePostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(
                          SocialCubit.get(context).userModel!.image,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SocialCubit.get(context).userModel!.name,
                              style: const TextStyle(
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind....',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(postImage!),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              IconBroken.Close_Square,
                              size: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                IconBroken.Image,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Add Image',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# Tags',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
