import 'package:flutter/material.dart';
import 'package:viewith/ui/app_design.dart';

class VenueItem extends StatelessWidget {
  final String name;
  final String address;
  final List<String> images;
  final List<String> artists;

  const VenueItem({
    super.key,
    required this.name,
    required this.address,
    required this.images,
    required this.artists,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildVenueInfo()),
        AppDesign.spacing.w16,
        _buildImages(),
      ],
    );
  }

  Widget _buildVenueInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(name),
        _buildAddress(address),
        AppDesign.spacing.h12,
        _buildArtist(),
      ],
    );
  }

  Widget _buildImages() {
    if (images.isEmpty) return const SizedBox();

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        images.first,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: AppDesign.typo.title1(),
    );
  }

  Widget _buildAddress(String address) {
    return Text(
      "📍 $address",
      style: AppDesign.typo.body4(),
    );
  }

  Widget _buildArtist() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('공연 예정인 아티스트', style: AppDesign.typo.h3()),
        AppDesign.spacing.h4,
        Row(
          children: artists
              .map(
                (text) => Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppDesign.colors.gray900,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: AppDesign.spacing.chipPadding,
                      child: Text(text, style: AppDesign.typo.body4Bold(color: AppDesign.colors.white)),
                    ),
                    AppDesign.spacing.w4,
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
