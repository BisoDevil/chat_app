import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:chat_app/app/util/strings.dart';
import 'package:chat_app/index.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final Users user;

  const UserCardWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT, arguments: user);
      },
      child: Card(
        elevation: 9,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Stack(
          children: [
            SizedBox.expand(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: user?.profilePhoto ?? noImageAvailable,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  Container(
                    color: Colors.black12,
                  )
                ],
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Constants.mainColor,
                    ),
                    padding: EdgeInsets.all(
                      8,
                    ),
                    child: Text(
                      "13",
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${user.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/double_check_mark.svg",
                      width: 40.w,
                      color: Constants.mainColor,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "adasdasa",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.caption,
                      ),
                    ),
                    Text(
                      "WED",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.caption.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Constants.mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(
              horizontal: 8,
              vertical: 10,
            )
          ],
        ),
      ),
    );
  }
}
