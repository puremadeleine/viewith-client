import 'package:flutter/material.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:viewith/resource/constant.dart';
import 'package:viewith/ui/app_design.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/svg_util.dart';
import '../model/seat_section.dart';
import 'painter/path_painter.dart';
import 'painter/path_printer.dart';
import 'painter/stage_painter.dart';

enum SvgSource { asset, url }

sealed class SeatMapState {
  const SeatMapState();
}

class SeatMapWritable extends SeatMapState {
  const SeatMapWritable();
}

class SeatMapReadOnly extends SeatMapState {
  final Map<String, int> reviewCount;

  const SeatMapReadOnly({required this.reviewCount});
}

class SeatMap extends StatefulWidget {
  final String seatmapSource;
  final String? stageSource;
  final SvgSource sourceType;
  final Map<String, int>? reviewCount;
  final SeatMapState mode;
  final Function(String) onSectionSelected;

  const SeatMap({
    super.key,
    required this.seatmapSource,
    this.stageSource,
    this.sourceType = SvgSource.asset,
    this.reviewCount,
    required this.mode,
    required this.onSectionSelected,
  });

  @override
  State<SeatMap> createState() => _SeatMapState();
}

class _SeatMapState extends State<SeatMap> {
  List<Section> sections = [];
  List<Section> stages = [];

  Map<String, Color> colors = {};
  Map<String, Color> borderColors = {};

  double _svgWidth = 0;
  double _svgHeight = 0;
  final double _initialScale = 1.0;

  final Color defaultColor = AppDesign.colors.gray100;
  final Color selectedColor = AppDesign.colors.gray900;
  final Color disabledColor = AppDesign.colors.gray100;
  final Color defaultBorderColor = AppDesign.colors.gray300;
  final Color selectedBorderColor = AppDesign.colors.gray50;
  final Color defaultTextColor = AppDesign.colors.gray900;
  final Color selectedTextColor = AppDesign.colors.gray50;

  final TransformationController _transformationController = TransformationController();

  @override
  void initState() {
    super.initState();
    _setInitialScale();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _loadSeatMap();
    _loadStages();
    _setInitialColor();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void _setInitialScale() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final x = -size.width / 2 * (_initialScale - 1);
      final y = -size.height / 2 * (_initialScale - 1);
      _transformationController.value = Matrix4.identity()
        ..translate(x, y)
        ..scale(_initialScale);
    });
  }

  Future<String> _fetchSvgFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('Failed to load SVG from URL');
    } catch (e) {
      throw Exception('Error loading SVG: $e');
    }
  }

  Future<XmlDocument> _loadSvg(String source) async {
    String svgString;

    if (widget.sourceType == SvgSource.asset) {
      svgString = await DefaultAssetBundle.of(context).loadString(source);
    } else {
      svgString = await _fetchSvgFromUrl(source);
    }

    final document = XmlDocument.parse(svgString);

    if (mounted) {
      if (widget.sourceType == SvgSource.asset) {
        final size = await SvgUtil.getSize(context, source);
        _svgWidth = size.width;
        _svgHeight = size.height;
      } else {
        // Parse SVG width and height from the document
        final svg = document.findElements('svg').first;
        final viewBox = svg.getAttribute('viewBox')?.split(' ');
        if (viewBox != null && viewBox.length == 4) {
          _svgWidth = double.parse(viewBox[2]);
          _svgHeight = double.parse(viewBox[3]);
        } else {
          _svgWidth = double.parse(svg.getAttribute('width') ?? '0');
          _svgHeight = double.parse(svg.getAttribute('height') ?? '0');
        }
      }
    }

    return document;
  }

  Future<void> _loadSeatMap() async {
    final document = await _loadSvg(widget.seatmapSource);

    final newSections = <Section>[];

    void processElement(XmlElement element, Matrix4 parentTransform) {
      final transformStr = element.getAttribute(Strings.transform);
      final currentTransform = transformStr != null ? SvgUtil.parseTransform(transformStr) : Matrix4.identity();
      final totalTransform = parentTransform.multiplied(currentTransform);

      if (element.name.local == Strings.g) {
        for (var child in element.children.whereType<XmlElement>()) {
          processElement(child, totalTransform);
        }
      } else {
        Path? path;
        final id = element.getAttribute(Strings.id) ?? '';

        bool isBackground = false;
        XmlNode? parent = element.parent;
        while (parent != null && parent is XmlElement) {
          if (parent.getAttribute('id') == 'background') {
            isBackground = true;
            break;
          }
          parent = parent.parent;
        }

        switch (element.name.local) {
          case Strings.rect:
            path = _getRectPath(element);
            break;
          case Strings.path:
            final pathData = element.getAttribute(Strings.pathData) ?? '';
            path = _getPath(pathData);
            break;
          case Strings.circle:
            path = _getCirclePath(element);
            break;
        }

        if (path != null) {
          _setColor(id, isBackground: isBackground);
          newSections.add(Section(id, path.transform(totalTransform.storage)));
        }
      }
    }

    final svgRoot = document.rootElement;
    for (var element in svgRoot.children.whereType<XmlElement>()) {
      processElement(element, Matrix4.identity());
    }

    setState(() {
      sections = newSections;
    });
  }

  Future<void> _loadStages() async {
    final stageSource = widget.stageSource;
    if (stageSource == null) return;
    final document = await _loadSvg(stageSource);

    setState(() {
      stages = document.findAllElements(Strings.path).map((element) {
        final path = element.getAttribute(Strings.pathData) ?? '';
        final id = element.getAttribute(Strings.id) ?? '';
        return Section(id, _getPath(path));
      }).toList();
    });
  }

  void _setInitialColor() {
    switch (widget.mode) {
      case SeatMapWritable():
        return;
      case SeatMapReadOnly(:final reviewCount):
        for (var section in sections) {
          final count = reviewCount[section.id];
          if (count == null) continue;
          if (count < 10) {
            // 갯수에 따라 조정 필요함
            colors[section.id] = AppDesign.colors.gray50;
          }
        }
    }
  }

  Path _getPath(String svgPath) {
    final Path path = Path();
    writeSvgPathDataToPath(svgPath, PathPrinter(path));
    return path;
  }

  Path _getRectPath(XmlElement element) {
    final x = double.tryParse(element.getAttribute(Strings.x) ?? '') ?? 0.0;
    final y = double.tryParse(element.getAttribute(Strings.y) ?? '') ?? 0.0;
    final width = double.tryParse(element.getAttribute(Strings.width) ?? '') ?? 0.0;
    final height = double.tryParse(element.getAttribute(Strings.height) ?? '') ?? 0.0;
    final rx = double.tryParse(element.getAttribute(Strings.roundedX) ?? '') ?? 0.0;

    final path = Path();
    if (rx > 0) {
      path.addRRect(RRect.fromRectXY(Rect.fromLTWH(x, y, width, height), rx, rx));
    } else {
      path.addRect(Rect.fromLTWH(x, y, width, height));
    }

    return path;
  }

  Path _getCirclePath(XmlElement element) {
    final cx = double.tryParse(element.getAttribute(Strings.cx) ?? '') ?? 0.0;
    final cy = double.tryParse(element.getAttribute(Strings.cy) ?? '') ?? 0.0;
    final r = double.tryParse(element.getAttribute(Strings.r) ?? '') ?? 0.0;

    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    return path;
  }

  void _setColor(String id, {bool isBackground = false}) {
    if (isBackground) {
      colors[id] = AppDesign.colors.white;
      return;
    }
    if (id.startsWith(Strings.disablePrefix)) {
      colors[id] = disabledColor;
      borderColors[id] = defaultBorderColor;
    } else if (id.contains(Strings.textSuffix)) {
      colors[id] = defaultTextColor;
    } else if (id.startsWith(Strings.seatPrefix)) {
      colors[id] = defaultColor;
      borderColors[id] = defaultBorderColor;
    } else {
      colors[id] = defaultColor;
      borderColors[id] = defaultBorderColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;
        final parentHeight = constraints.maxHeight;

        final scaleX = parentWidth / _svgWidth;
        final scaleY = parentHeight / _svgHeight;
        final scale = (scaleX < scaleY) ? scaleX : scaleY;

        return GestureDetector(
          key: const ValueKey('seatMapGestureDetector'),
          onTapDown: (details) {
            Offset position = _adjustRatio(details);
            _onSectionTap(position, scale);
          },
          child: Center(
            child: InteractiveViewer(
              maxScale: 3,
              transformationController: _transformationController,
              child: Stack(
                children: [
                  CustomPaint(
                    key: const ValueKey('seatMapCustomPaint'),
                    painter: PathPainter(
                      sections: sections,
                      colors: colors,
                      borderColors: borderColors,
                      defaultColor: defaultColor,
                      defaultBorderColor: defaultBorderColor,
                      scale: scale,
                    ),
                    size: Size(parentWidth, parentHeight),
                  ),
                  CustomPaint(
                    painter: StagePainter(
                      sections: stages,
                      defaultColor: defaultColor,
                      scale: scale,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Offset _adjustRatio(TapDownDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    final transformedPosition = _transformationController.toScene(localPosition);
    return transformedPosition;
  }

  void _onSectionTap(Offset position, double scale) {
    final x = position.dx / scale;
    final y = position.dy / scale;
    final offset = Offset(x, y);

    for (var section in sections.reversed) {
      if (section.path.contains(offset)) {
        if (section.id.startsWith(Strings.disablePrefix)) return;
        if (widget.mode == const SeatMapWritable()) _changeColor(section.id);
        widget.onSectionSelected(section.id);
        break;
      }
    }
  }

  void _changeColor(String id) {
    setState(() {
      colors[id] = (colors[id] == selectedColor) ? defaultColor : selectedColor;
      borderColors[id] = (borderColors[id] == selectedBorderColor)
          ? defaultBorderColor
          : selectedBorderColor;
      final textId = id + Strings.textSuffix;
      colors[textId] = (colors[textId] == selectedTextColor) ? defaultTextColor : selectedTextColor;
    });
  }
}
