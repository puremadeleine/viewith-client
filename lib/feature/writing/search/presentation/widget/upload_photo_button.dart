import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viewith/feature/writing/search/controller/writing_image_provider.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/gen/assets.gen.dart';

class UploadPhotoButton extends ConsumerWidget {
  const UploadPhotoButton({super.key, required this.maxCount, required this.onUploaded});

  final int maxCount;
  final Function(List<XFile>) onUploaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(writingImageProviderProvider);
    final uploadedCount = images.length;

    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final remainingSlots = maxCount - uploadedCount;
        if (remainingSlots <= 0) return;
        
        final List<XFile> files = await picker.pickMultiImage(limit: remainingSlots);
        onUploaded.call(files);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppDesign.colors.gray900,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.0), // border 둥글기
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            children: [
              Assets.images.cameraFill.svg(),
              _buildText(uploadedCount),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(int uploadedCount) {
    return Text('$uploadedCount / $maxCount', style: AppDesign.typo.body2Bold(),);
  }
}