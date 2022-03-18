import 'package:flutter/material.dart';

// @deprecated
// class Button extends StatefulWidget {
//   static const _DEFAULT_STYLE = TextStyle(color: Colors.black, fontSize: 15);
//   static const _DEFAULT_DECORATION = BoxDecoration(
//       color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(5)));
//   Button(
//       {Key key,
//       this.normalStyle = _DEFAULT_STYLE,
//       this.highlightStyle,
//       this.disableStyle,
//       this.selectedStyle,
//       this.controller,
//       this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       this.normalDecoration = _DEFAULT_DECORATION,
//       this.highlightDecoration,
//       this.disableDecoration,
//       this.selectedDecoration,
//       this.onClick,
//       this.alignment})
//       : super(key: key);
//   final TextStyle normalStyle;
//   final TextStyle highlightStyle;
//   final TextStyle disableStyle;
//   final TextStyle selectedStyle;
//   final ButtonController controller;
//   final EdgeInsets padding;
//   final Decoration normalDecoration;
//   final Decoration highlightDecoration;
//   final Decoration disableDecoration;
//   final Decoration selectedDecoration;
//   final Function onClick;
//   final AlignmentGeometry alignment;
//
//   @override
//   _ButtonState createState() => _ButtonState();
// }

// class ButtonController extends ChangeNotifier {
//   ButtonController(
//       {Key? key, this.selected = false, this.enable = true, this.title})
//       : super();
//   bool selected = false;
//   bool enable = true;
//   String? title;
//   void commit() {
//     notifyListeners();
//   }
// }

// class _ButtonState extends State<Button> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Container(
//         alignment: widget.alignment ?? Alignment.center,
//         decoration: decoration,
//         padding:
//             widget.padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Text(
//           controller.title,
//           style: titleStyle,
//         ),
//       ),
//       behavior: HitTestBehavior.opaque,
//       onTapDown: (_) => touchDown(),
//       onTapUp: (_) => touchUp(),
//       onTapCancel: touchCancel,
//     );
//   }
//
//   ButtonController controller;
//   TextStyle titleStyle;
//   Decoration decoration;
//   @override
//   void initState() {
//     controller = widget.controller ?? ButtonController();
//     controller.addListener(controllValueChanged);
//     makeStyle();
//     super.initState();
//   }
//
//   void refWidget() {
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     controller.removeListener(controllValueChanged);
//     super.dispose();
//   }
//
//   void controllValueChanged() {
//     makeStyle();
//     refWidget();
//   }
//
//   void makeStyle() {
//     if (controller.enable ?? true) {
//       if (controller.selected ?? false) {
//         titleStyle =
//             widget.selectedStyle ?? widget.normalStyle ?? Button._DEFAULT_STYLE;
//         decoration = widget.selectedDecoration ??
//             widget.normalDecoration ??
//             Button._DEFAULT_DECORATION;
//       } else {
//         titleStyle = widget.normalStyle ?? Button._DEFAULT_STYLE;
//         decoration = widget.normalDecoration ?? Button._DEFAULT_DECORATION;
//       }
//     } else {
//       titleStyle =
//           widget.disableStyle ?? widget.normalStyle ?? Button._DEFAULT_STYLE;
//       decoration = widget.disableDecoration ??
//           widget.normalDecoration ??
//           Button._DEFAULT_DECORATION;
//     }
//   }
//
//   void touchDown() {
//     if (!controller.enable) return;
//     decoration = widget.highlightDecoration ??
//         widget.normalDecoration ??
//         Button._DEFAULT_DECORATION;
//     titleStyle =
//         widget.highlightStyle ?? widget.normalStyle ?? Button._DEFAULT_STYLE;
//     refWidget();
//   }
//
//   void touchUp() {
//     if (!controller.enable) return;
//     decoration = widget.normalDecoration ?? Button._DEFAULT_DECORATION;
//     titleStyle = widget.normalStyle ?? Button._DEFAULT_STYLE;
//     refWidget();
//     widget.onClick?.call();
//   }
//
//   void touchCancel() {
//     if (!controller.enable) return;
//     decoration = widget.normalDecoration ?? Button._DEFAULT_DECORATION;
//     titleStyle = widget.normalStyle ?? Button._DEFAULT_STYLE;
//     refWidget();
//   }
// }
