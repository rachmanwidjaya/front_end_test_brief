import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class ImageScreen extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final Map<String, String>? header;
  final FilterQuality? filterQuality;
  final double? height;
  final double? width;

  const ImageScreen(
    this.url, {
    Key? key,
    this.fit,
    this.header,
    this.filterQuality,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url.startsWith('assets')
        ? ExtendedImage.asset(
            url,
            cacheHeight: height != null ? (height!.toInt() * 2) : null,
            cacheWidth: width != null ? (width!.toInt() * 2) : null,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  {
                    return const SizedBox();
                  }
                case LoadState.completed:
                  {
                    return _buildImage(state, height: height, width: width);
                  }
                case LoadState.failed:
                  {
                    return const SizedBox();
                  }
              }
            },
          )
        : ExtendedImage.network(
            url,
            cacheHeight: height != null ? (height!.toInt() * 2) : null,
            cacheWidth: width != null ? (width!.toInt() * 2) : null,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  {
                    return _buildLoading(height: height, width: width);
                  }
                case LoadState.completed:
                  {
                    return _buildImage(state, height: height, width: width);
                  }
                case LoadState.failed:
                  {
                    return _buildFailed();
                  }
              }
            },
          );
  }

  Widget _buildImage(ExtendedImageState state,
          {double? height, double? width}) =>
      ExtendedRawImage(
        height: height,
        width: width,
        fit: fit ?? BoxFit.fill,
        image: state.extendedImageInfo?.image,
      );

  Widget _buildFailed() => ImageScreen(
        'assets/images/error_image.png',
        height: height,
        width: width,
      );

  Widget _buildLoading({double? height, double? width}) => SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: LoadingWidget(),
        ),
      );
}
