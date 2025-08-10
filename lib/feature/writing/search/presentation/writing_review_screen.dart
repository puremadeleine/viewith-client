import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:viewith/app/route/app_route.dart';
import 'package:viewith/feature/writing/search/controller/writing_image_provider.dart';
import 'package:viewith/feature/writing/search/controller/writing_seat_infos_controller.dart';
import 'package:viewith/feature/writing/search/presentation/widget/upload_photo_button.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:viewith/ui/widgets/button/vi_button.dart';
import 'package:viewith/ui/widgets/button/vi_button_type.dart';

class WritingReviewScreen extends ConsumerStatefulWidget {
  const WritingReviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritingVenuesState();
}

class _WritingVenuesState extends ConsumerState<WritingReviewScreen> {
  final _textEditingController = TextEditingController();
  bool _isNextButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _isNextButtonEnabled = _textEditingController.text.length >= 20;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle('후기를 작성해주세요.'),
            _buildSubTitle('보다 생생한 시야 후기를 위해 사진을 첨부해주면 더 좋아요.\n다른 관람객분들의 얼굴이 나온 사진은 꼭 가려주세요!'),
            AppDesign.spacing.h12,
            Row(
              children: [
                _buildUploadButton(),
                AppDesign.spacing.w8,
                Expanded(child: _buildPhotoList()),
              ],
            ),
            AppDesign.spacing.h12,
            TextField(
              controller: _textEditingController,
              maxLines: 6,
              maxLength: 300,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.5),
                ),
                hintText: '내용을 입력하세요',
              ),
              buildCounter: (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                int? maxLength,
              }) {
                return null;
              },
            ),
            AppDesign.spacing.h4,
            _buildCounter(300),
            const Spacer(),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(text, style: AppDesign.typo.title1());
  }

  Widget _buildSubTitle(String text) {
    return Text(text, style: AppDesign.typo.body2(color: AppDesign.colors.gray600));
  }

  Widget _buildUploadButton() {
    return UploadPhotoButton(
      maxCount: 5,
      onUploaded: (files) {
        if (files.isNotEmpty) {
          ref.read(writingImageProviderProvider.notifier).addImages(files);
        }
      },
    );
  }

  Widget _buildPhotoList() {
    return const SelectedImagesRow();
  }

  Widget _buildNextButton() {
    return VIButton(
      onTap: () {
        ref
            .read(writingSeatInfosControllerProvider.notifier)
            .updateSeatInfo(content: _textEditingController.text);
        context.pushNamed(AppRoute.writingRating.name);
      },
      type: VIButtonType.primary,
      text: '다음',
      isEnabled: _isNextButtonEnabled,
    );
  }

  Widget _buildCounter(int maxLength) {
    return ValueListenableBuilder(
      valueListenable: _textEditingController,
      builder: (context, TextEditingValue value, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('최소 20자 이상 입력해주세요.', style: AppDesign.typo.body2(color: AppDesign.colors.gray600)),
            AppDesign.spacing.h2,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${_textEditingController.text.length} ',
                  style: AppDesign.typo.body2Bold(),
                ),
                Text(
                  ' / $maxLength ',
                  style: AppDesign.typo.body2(color: AppDesign.colors.gray600),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class SelectedImagesRow extends ConsumerWidget {
  const SelectedImagesRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(writingImageProviderProvider);

    return SizedBox(
      height: 65,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(images[index].path),
                  width: 65,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    ref.read(writingImageProviderProvider.notifier).removeImage(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
