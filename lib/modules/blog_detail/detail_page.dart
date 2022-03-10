import 'package:blogapp/constant/text_style.dart';
import 'package:blogapp/data/controller/controller.dart';
import 'package:blogapp/data/controller/get_account_controller.dart';
import 'package:blogapp/constant/ui_helper.dart';
import 'package:blogapp/modules/blog_detail/detail_controller.dart';
import 'package:blogapp/modules/bottomnavigation/bottom_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class DetailPage extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DetailController());
    final ApiController apiController = Get.put(ApiController());

    return WillPopScope(
      onWillPop: () async {
        Get.find<BottomController>().pageindex(1);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.7),
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.withOpacity(0.7),
            title: const Text('Blog Detail', style: titleStyle,),
            centerTitle: true,
            leading:  IconButton(
              icon: const Icon(Icons.chevron_left_rounded,
                  color: Colors.white, size: 35),
              onPressed: () => Get.find<BottomController>().pageindex(1),
            ),
            actions: [
             IconButton(
                icon: const Icon(Icons.favorite_rounded, color: Colors.white),
               onPressed: () async {await apiController.toggleFav(controller.selectedArticle.value.id!);},
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                    flex: 5,
                    child: Image.network(controller.selectedArticle.value.image.toString())),

                UIHelper.verticalSpace(16),

                Text(controller.selectedArticle.value.title.toString(),
                    style: titleStyle),

                UIHelper.verticalSpace(16),

                Expanded(
                    flex: 6,
                    child: HtmlWidget(controller.selectedArticle.value.content.toString(), textStyle: subtitleStyle)),
              ],
            ),
          )),
    );
  }
}