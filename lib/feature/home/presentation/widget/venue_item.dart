import 'package:flutter/material.dart';
import 'package:viewith/data/venue/response/venue.dart';
import 'package:viewith/ui/app_design.dart';

class VenueItem extends StatelessWidget {
  final Venue venue;

  const VenueItem({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppDesign.colors.gray200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLeftInfoSection(),
            const SizedBox(width: 16),
            _buildRightImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftInfoSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVenueName(),
          AppDesign.spacing.h4,
          _buildLocationInfo(),
          AppDesign.spacing.h16,
          _buildArtistSectionTitle(),
          AppDesign.spacing.h8,
          _buildArtistList(),
        ],
      ),
    );
  }

  Widget _buildVenueName() {
    return Text(
      venue.name,
      style: AppDesign.typo.title2ExtraBold(),
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      children: [
        Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            venue.location,
            style: AppDesign.typo.body2(),
          ),
        ),
      ],
    );
  }

  Widget _buildArtistSectionTitle() {
    return Row(
      children: [
        Icon(Icons.music_note, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          '공연 예정인 아티스트',
          style: AppDesign.typo.body2Semibold(),
        ),
      ],
    );
  }

  Widget _buildArtistList() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: venue.performances?.isEmpty ?? true
          ? [_buildNoPerformanceChip()]
          : [
              ...venue.performances!.map((e) => _buildArtistChip(e.artist)),
              _buildEtcChip(),
            ],
    );
  }

  Widget _buildNoPerformanceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        '예정된 공연이 없습니다',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildEtcChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        '외 다수',
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildRightImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: venue.performances?.isNotEmpty ?? false
          ? Image.network(
              venue.performances?.first.imageUrl ?? '',
              width: 80,
              height: 110,
              fit: BoxFit.cover,
            )
          : Container(
              width: 80,
              height: 110,
              decoration: BoxDecoration(
                color: AppDesign.colors.gray100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/images/cat_profile.png',
                width: 80,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Widget _buildArtistChip(String artist) {
    Color backgroundColor;
    Color textColor;

    final random = artist.hashCode % 5;
    switch (random) {
      case 0:
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[700]!;
        break;
      case 1:
        backgroundColor = Colors.pink[100]!;
        textColor = Colors.pink[700]!;
        break;
      case 2:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      case 3:
        backgroundColor = Colors.purple[100]!;
        textColor = Colors.purple[700]!;
        break;
      case 4:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        artist,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
