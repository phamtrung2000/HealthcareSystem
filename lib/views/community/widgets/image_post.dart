import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mental_health/configs/color_configs.dart';
import 'package:flutter_mental_health/views/community/photoview_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_mental_health/configs/text_configs.dart';
import 'package:intersperse/intersperse.dart';

class PostImageArgument {
  final int index;
  final List<String> image;
  PostImageArgument(
    this.index,
    this.image,
  );
}

class PostImage extends StatelessWidget {
  final List<String> images;

  const PostImage({
    Key? key,
    required this.images,
  }) : super(key: key);

  Widget _buildImage(String image, int index, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            PhotoViewer.id,
            arguments: PostImageArgument(index, images),
          );
        },
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  size: 45.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Error loading image",
                  style: TextConfigs.kText18w400Black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMultiImage(String image, int index, BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
            PhotoViewer.id,
            arguments: PostImageArgument(index, images),
          );
        },
        child: Stack(children: [
          Positioned.fill(
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Padding(
                padding: EdgeInsets.all(10.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      size: 45.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Error loading image",
                      style: TextConfigs.kText18w400Black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.kBlack54Color.withOpacity(0.5),
              child: SizedBox.expand(),
            ),
          ),
          Center(
            child: Text(
              "+ " + (images.length - 3).toString(),
              style: TextConfigs.kText24w700Black
                  .copyWith(color: AppColors.kPopupBackgroundColor),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (images.length) {
      case 0:
        {
          return SizedBox.shrink();
        }
      case 1:

      case 2:
        {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: intersperse(
                SizedBox(
                  width: 4.w,
                ),
                [
                  ...images.asMap().entries.map(
                      (entry) => _buildImage(entry.value, entry.key, context))
                ]).toList(),
          );
        }
      case 3:
        {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(images[0], 0, context),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildImage(images[1], 1, context),
                      SizedBox(
                        height: 4.h,
                      ),
                      _buildImage(images[2], 2, context)
                    ]),
              ),
            ],
          );
        }

      default:
        {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImage(images[0], 0, context),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildImage(images[1], 1, context),
                      SizedBox(
                        height: 4.h,
                      ),
                      _buildMultiImage(images[2], 2, context),
                    ]),
              ),
            ],
          );
        }
    }
  }
}
