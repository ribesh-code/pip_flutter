import 'package:flutter/material.dart';
import 'package:pip_flutter/pip_flutter.dart';

class PipModeWidget extends StatefulWidget {
  final Widget? pipChild;
  final Widget? child;
  final Widget Function(BuildContext)? pipBuilder;
  final Widget Function(BuildContext)? builder;
  final VoidCallback? onPipEntered;
  final VoidCallback? onPipExited;

  const PipModeWidget(
      {Key? key,
      this.pipChild,
      this.child,
      this.pipBuilder,
      this.builder,
      this.onPipEntered,
      this.onPipExited})
      : assert(child != null || builder != null),
        assert(pipChild != null || pipBuilder != null),
        super(key: key);

  @override
  State<PipModeWidget> createState() => _PipModeWidgetState();
}

class _PipModeWidgetState extends State<PipModeWidget> {
  late final PipFlutter pip;

  bool _pipMode = false;

  @override
  void initState() {
    super.initState();
    pip = PipFlutter(
      onPipEntered: onPipEntered,
      onPipExited: onPipExited,
    );
  }

  void onPipEntered() {
    setState(() {
      _pipMode = true;
    });
    widget.onPipEntered?.call();
  }

  void onPipExited() {
    setState(() {
      _pipMode = true;
    });

    widget.onPipEntered?.call();
  }

  @override
  Widget build(BuildContext context) {
    return _pipMode
        ? (widget.pipBuilder?.call(context) ?? widget.pipChild!)
        : (widget.builder?.call(context) ?? widget.child!);
  }
}
