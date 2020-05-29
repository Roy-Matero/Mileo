import 'package:flutter/cupertino.dart';
import 'package:mileo/constants/keys.dart';

class CustomAlertDialog extends StatelessWidget{

  CustomAlertDialog({
    @required this.title,
    @required this.content,
    this.cancelActionText,
    @required this.defaultActionText
  }) : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String cancelActionText;
  final String defaultActionText;

  Future<bool> show(BuildContext context) async{
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  } 

  List<Widget> _buildActions(BuildContext context){
    final List<Widget> actions = <Widget>[];
    if(cancelActionText != null){
      actions.add(
        CustomAlertDialogAction(
          child: Text(
            cancelActionText,
            key: Key(ALERTCANCEL),
          ),
          onPressed: () => Navigator.of(context).pop(false)),
      );
    }
    actions.add(
      CustomAlertDialogAction(
        child: Text(
          defaultActionText,
          key: Key(ALERTDEFAULT),
        ),
        onPressed: () => Navigator.of(context).pop(true),
      ),
    );
    return actions;
  }

}

class CustomAlertDialogAction extends StatelessWidget{
  CustomAlertDialogAction({Key key, this.onPressed, this.child}) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      child:  child,
      onPressed: onPressed,
    );
  }

}