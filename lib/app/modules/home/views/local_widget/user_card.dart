import 'package:chat_app/app/data/model/user.dart';
import 'package:chat_app/app/util/constant.dart';
import 'package:chat_app/index.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final User user;

  const UserCardWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  imageUrl: user.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                Container(
                  color: Colors.black38,
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
                    "${user.count}",
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
                      "${user.lastMessage}\n${user.lastMessage}",
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
    );
  }
}
