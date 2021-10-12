import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp/components/done_button.dart';
import 'package:noteapp/components/skip_button.dart';
import 'package:noteapp/constant/constant.dart';
import 'package:get/get.dart';
import 'package:noteapp/controllers/notes_list_controller.dart';
import 'package:noteapp/controllers/reports_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final notesListController = Get.find<NotesListController>();
    final reportsController = Get.put(ReportsController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Text(
          "Report",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GetX<NotesListController>(
          initState: (state) {
            print('Inited');
          },
          init: NotesListController(),
          builder: (notesListController) => ListView.builder(
            itemCount: notesListController.completedNotes.length,
            itemBuilder: (BuildContext context, int index) {
              // return Container();
              return Obx(
                () {
                  return ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    dividerColor: kPrimaryColor.withOpacity(0.5),
                    elevation: 2,
                    children: [
                      ExpansionPanel(
                        canTapOnHeader: true,
                        body: Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              WidgetButtonDone(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: notesListController
                                    .completedNotes[index].todoItemList
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            e.taskName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              notesListController.completedNotes[index].title!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                        isExpanded: reportsController.isExpandedList[index],
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      reportsController.isExpandedList[index] =
                          !reportsController.isExpandedList[index];
                      print('toggled $item $status');
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  getBody() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: Color(0xffFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Title",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              WidgetButtonDone(),
            ],
          ),
          Column(
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}
