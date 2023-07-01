import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskmallow/components/button_component.dart';
import 'package:taskmallow/components/circular_photo_component.dart';
import 'package:taskmallow/components/icon_component.dart';
import 'package:taskmallow/components/text_component.dart';
import 'package:taskmallow/components/text_form_field_component.dart';
import 'package:taskmallow/constants/app_constants.dart';
import 'package:taskmallow/constants/color_constants.dart';
import 'package:taskmallow/constants/string_constants.dart';
import 'package:taskmallow/helpers/ui_helper.dart';
import 'package:taskmallow/localization/app_localization.dart';
import 'package:taskmallow/models/user_model.dart';
import 'package:taskmallow/providers/providers.dart';
import 'package:taskmallow/repositories/project_repository.dart';
import 'package:taskmallow/repositories/user_repository.dart';
import 'package:taskmallow/routes/route_constants.dart';
import 'package:taskmallow/widgets/base_scaffold_widget.dart';
import 'package:taskmallow/widgets/marquee_widget.dart';

class CollaboratorsPage extends ConsumerStatefulWidget {
  const CollaboratorsPage({super.key});

  @override
  ConsumerState<CollaboratorsPage> createState() => _CollaboratorsPageState();
}

class _CollaboratorsPageState extends ConsumerState<CollaboratorsPage> {
  bool isLoading = false;
  List<UserModel> invitedUsers = [];
  final TextEditingController _searchTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(userProvider).filteredUsers.clear();
    ref.read(userProvider).filteredProjects.clear();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = ref.watch(userProvider);
    ProjectRepository projectRepository = ref.watch(projectProvider);
    return BaseScaffoldWidget(
      title: getTranslated(context, AppKeys.collaborators),
      leadingWidget: IconButton(
        splashRadius: AppConstants.iconSplashRadius,
        icon: const IconComponent(iconData: CustomIconData.chevronLeft),
        onPressed: () => isLoading ? null : Navigator.pop(context),
      ),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      widgetList: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ref
                .watch(projectProvider)
                .projectModel!
                .collaborators
                .map(
                  (user) => InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BaseScaffoldWidget(
                              hasAppBar: false,
                              widgetList: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: itemBackgroundLightColor,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: UIHelper.getDeviceWidth(context) / 4,
                                            height: UIHelper.getDeviceWidth(context) / 4,
                                            child: CircularPhotoComponent(
                                              url: user.profilePhotoURL,
                                              hasBorder: false,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          MarqueeWidget(
                                            child: TextComponent(
                                              text: "${user.firstName} ${user.lastName}",
                                              fontWeight: FontWeight.bold,
                                              headerType: HeaderType.h4,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                            ),
                                          ),
                                          MarqueeWidget(
                                            child: TextComponent(
                                              text: user.email,
                                              headerType: HeaderType.h7,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: itemBackgroundLightColor,
                                      ),
                                      child: MarqueeWidget(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: getTranslated(context, AppKeys.completedTasks),
                                                style: const TextStyle(
                                                  color: textPrimaryLightColor,
                                                  fontSize: 18,
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                              const TextSpan(
                                                text: "4",
                                                style: TextStyle(
                                                  color: textPrimaryLightColor,
                                                  fontSize: 18,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                ref.watch(projectProvider).projectModel!.userWhoCreated.email != user.email
                                    ? ButtonComponent(
                                        text: getTranslated(context, AppKeys.deleteCollaborator),
                                        color: dangerDark,
                                        isWide: true,
                                        onPressed: () {},
                                      )
                                    : const SizedBox()
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularPhotoComponent(url: user.profilePhotoURL, hasBorder: false),
                          ),
                          TextComponent(
                            text: user.firstName[0] + user.lastName[0],
                            headerType: HeaderType.h6,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Visibility(
          visible: invitedUsers.isNotEmpty,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextComponent(
                text: getTranslated(context, AppKeys.invitedUsers),
                textAlign: TextAlign.start,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
              Column(
                children: invitedUsers.map((user) => getUserRow(user, projectRepository)).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextComponent(
          text: getTranslated(context, AppKeys.searchUsers),
          textAlign: TextAlign.start,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.fade,
          softWrap: true,
        ),
        TextFormFieldComponent(
          context: context,
          textEditingController: _searchTextEditingController,
          iconData: CustomIconData.magnifyingGlass,
          hintText: getTranslated(context, AppKeys.search),
          onChanged: (text) {
            userRepository.searchUserAndProject(text.trim().toLowerCase());
          },
        ),
        userRepository.isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: LinearProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: userRepository.filteredUsers.map((user) => getUserRow(user, projectRepository)).toList(),
                ),
              ),
        const SizedBox(height: 10),
        const Spacer(),
        Row(
          children: [
            const Expanded(
              child: Divider(color: matchSecondaryColor, thickness: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextComponent(
                text: getTranslated(context, AppKeys.or),
                color: matchSecondaryColor,
              ),
            ),
            const Expanded(
              child: Divider(color: matchSecondaryColor, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ButtonComponent(
          text: getTranslated(context, AppKeys.startMatch),
          color: matchColor,
          icon: CustomIconData.wandMagicSparkles,
          isWide: true,
          onPressed: () {
            Navigator.pushNamed(context, userMatchPageRoute);
          },
        ),
      ],
    );
  }

  Widget getUserRow(UserModel user, ProjectRepository projectRepository) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: listViewItemBackgroundLightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (user.email == ref.watch(userProvider).userModel!.email) {
            Navigator.pushNamed(context, profilePageRoute, arguments: user);
          } else {
            Navigator.pushNamed(context, profileScreenPageRoute, arguments: user);
          }
        },
        child: Row(
          children: [
            SizedBox(
              width: UIHelper.getDeviceWidth(context) / 7,
              height: UIHelper.getDeviceWidth(context) / 7,
              child: CircularPhotoComponent(
                url: user.profilePhotoURL,
                hasBorder: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MarqueeWidget(
                    child: TextComponent(
                      text: "${user.firstName} ${user.lastName}",
                      fontWeight: FontWeight.bold,
                      headerType: HeaderType.h4,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                  ),
                  MarqueeWidget(
                    child: TextComponent(
                      text: user.email,
                      headerType: HeaderType.h7,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            projectRepository.projectModel!.collaborators.any((element) => element.email == user.email)
                ? const SizedBox()
                : ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        tooltip: !invitedUsers.any((element) => element.email == user.email)
                            ? getTranslated(context, AppKeys.invite)
                            : getTranslated(context, AppKeys.removeInvite),
                        onPressed: () {
                          if (!invitedUsers.any((element) => element.email == user.email)) {
                            setState(() {
                              invitedUsers.add(user);
                            });
                          } else {
                            setState(() {
                              invitedUsers.removeWhere((element) => element.email == user.email);
                            });
                          }
                        },
                        icon: IconComponent(
                          iconData: !invitedUsers.any((element) => element.email == user.email) ? CustomIconData.paperPlane : CustomIconData.circleXmark,
                          color: !invitedUsers.any((element) => element.email == user.email) ? primaryColor : dangerDark,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
