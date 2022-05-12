import 'package:chatting_app/models/message_model.dart';
import 'package:chatting_app/models/social_user_model.dart';
import 'package:chatting_app/shared/constants.dart';
import 'package:chatting_app/shared/icon_broken.dart';
import 'package:chatting_app/social_layout/cubit/cubit.dart';
import 'package:chatting_app/social_layout/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  SocialUserModel userModel;

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel.uId,
        );

        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                leading: IconButton(
                  icon: const Icon(IconBroken.Arrow___Left_2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.name,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocialCubit.get(context).messages[index];
                            if (SocialCubit.get(context).userModel!.uId ==
                                message.senderId) {
                              return buildMyMessage(message);
                            }
                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15.0,
                          ),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: textController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Type your message here....',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    text: textController.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: userModel.uId,
                                  );
                                },
                                minWidth: 1.0,
                                color: defaultColor,
                                child: const Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Text(
            model.text,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.5,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
        ),
      );
  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          child: Text(
            model.text,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.5,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
          ),
        ),
      );
}
