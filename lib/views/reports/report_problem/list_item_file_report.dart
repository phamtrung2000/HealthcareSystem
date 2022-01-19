import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/view_models/reports/report_problem_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

class ItemFileReport extends StatelessWidget {
  const ItemFileReport({
    Key? key,
    required this.files,
  }) : super(key: key);
  final List<PlatformFile> files;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final eachFile = files[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.image_outlined,
                color: AppColors.kBlackColor,
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Text(
                  eachFile.name,
                  style: TextStyle(
                    color: AppColors.kBlackColor,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.multiply,
                  color: AppColors.kBlackColor,
                ),
                onPressed: () {
                  context.read<ReportProblemProvider>().delete(files[index]);
                },
              ),
            ],
          );
        });
  }
}
