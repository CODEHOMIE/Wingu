

import '../../../util/export_files.dart';

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Container(
        //   width: Get.width* .9,
        //   height: Get.height * .35,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(
        //           slideList[index].imageUrl,
        //         ),
        //         fit: BoxFit.fill),
        //   ),
        // ),
        // const SizedBox(
        //   height: 50,
        // ),
        // Text(
        //   slideList[index].headingStr,
        //   textAlign: TextAlign.center,
        //   style: KTextStyle.headerTextStyle,
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Text(
        //   slideList[index].subHeadingStr,
        //   textAlign: TextAlign.center,
        //   maxLines: 2,
        //   style: KTextStyle.normalText,
        // ),
      ],
    );
  }
}
