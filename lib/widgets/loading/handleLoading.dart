// import 'package:geekbooks/export/export.dart';

// class HandleLoading extends StatefulWidget {
//   const HandleLoading({
//     Key? key,
//     required this.child,
//     required this.isLoading,
//     this.loadingWidget,
//     this.loadingAlignment = Alignment.center,
//     this.loadingMargin = const EdgeInsets.all(0),
//     this.loadingPadding = const EdgeInsets.all(0),
//   }) : super(key: key);

//   final bool isLoading;
//   final Widget child;
//   final Widget? loadingWidget;
//   final EdgeInsetsGeometry loadingPadding;
//   final EdgeInsetsGeometry loadingMargin;
//   final AlignmentGeometry loadingAlignment;
//   @override
//   _HandleLoadingState createState() => _HandleLoadingState();
// }

// class _HandleLoadingState extends State<HandleLoading> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: widget.isLoading
//           ? widget.loadingWidget ??
//               Container(
//                 margin: widget.loadingMargin,
//                 padding: widget.loadingPadding,
//                 alignment: widget.loadingAlignment,
//                 child: CircularProgressIndicator.adaptive(),
//               )
//           : widget.child,
//     );
//   }
// }
