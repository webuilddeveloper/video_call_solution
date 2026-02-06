import 'package:flutter/material.dart';

appBarHome(
    {String? name = "",
    String? memberType = "",
    String? imageUrl = "",
    Widget? rightWidget,
    Function? rightAction,
    Function? profileAction}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(130),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 17,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              GestureDetector(
                onTap: () => profileAction,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFDBDBDB),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                            image: AssetImage(imageUrl!),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            memberType!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF000000).withOpacity(0.6),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),
              
              rightWidget!
              
            ],
          ),
        ),
      ),
    ),
  );
}

appBar(
    {String? title = "",
    bool backBtn = true,
    bool rightBtn = true,
    Function? rightAction,
    Function? backAction}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80), // 🔻 ลดความสูง
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 17,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔹 LEFT
              backBtn
                  ? GestureDetector(
                      onTap: () => backAction!(),
                      child: Container(
                        width: 40,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 12,
                        //   vertical: 10,
                        // ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          // borderRadius: BorderRadius.circular(22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFDBDBDB),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 15,
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: Text(
                    title!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              /// 🔔 RIGHT
              // ignore: unrelated_type_equality_checks
              rightBtn
                  ? GestureDetector(
                      onTap: () => rightAction!(),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 12,
                        //   vertical: 10,
                        // ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          // borderRadius: BorderRadius.circular(22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFDBDBDB),
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          size: 15,
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                    ),
            ],
          ),
        ),
      ),
    ),
  );
}

appBarCustom(
    {String? title = "",
    bool backBtn = true,
    bool isRightWidget = true,
    Widget? rightWidget,
    Function? backAction}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80), // 🔻 ลดความสูง
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 17,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 🔹 LEFT
              backBtn
                  ? GestureDetector(
                      onTap: () => backAction!(),
                      child: Container(
                        width: 40,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.symmetric(
                        //   horizontal: 12,
                        //   vertical: 10,
                        // ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAFAFA),
                          // borderRadius: BorderRadius.circular(22),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFDBDBDB),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 15,
                        ),
                      ),
                    )
                  : Container(
                      width: 40,
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: Text(
                    title!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              /// 🔔 RIGHT
              // ignore: unrelated_type_equality_checks
              isRightWidget
                  ? rightWidget! : Container(
                      width: 40,
                    ),
            ],
          ),
        ),
      ),
    ),
  );
}
