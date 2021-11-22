import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventComponentsPage extends StatefulWidget {

  const EventComponentsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventStatefulWidgetState();
}

class _EventStatefulWidgetState extends State<EventComponentsPage> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        alignment: Alignment.center,
        color: Colors.green,
        child: IgnorePointer(
          child: Listener(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              width: 200.0,
              height: 200.0,
              child: Text(
                '${_event?.localPosition ?? ''}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),
              ),
            ),
            onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
            onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
            onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
          )
        )
      ),
      onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
      onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
      onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
    );
  }
}