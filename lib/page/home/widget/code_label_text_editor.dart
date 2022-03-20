import 'package:flutter/material.dart';
import 'package:home_screen_codes/bloc/bloc_provider.dart';
import 'package:home_screen_codes/bloc/codes_bloc.dart';
import 'package:home_screen_codes/domain/entity/code_data.dart';

class CodeLabelTextEditor extends StatefulWidget {
  const CodeLabelTextEditor({
    required this.codeData,
    required this.canEdit,
    Key? key,
  }) : super(key: key);

  final CodeData codeData;
  final bool canEdit;

  @override
  _CodeLabelTextEditorState createState() => _CodeLabelTextEditorState();
}

class _CodeLabelTextEditorState extends State<CodeLabelTextEditor> {
  bool _isEditing = false;

  Widget _getChild() {
    if (_isEditing && widget.canEdit) {
      return TextField(
        controller: TextEditingController(text: widget.codeData.labelText),
        autofocus: true,
        textAlign: TextAlign.center,
        onSubmitted: (value) {
          setState(() {
            _isEditing = false;
          });
          BlocProvider.of<CodesBloc>(context).updateCodeData(
            oldCodeData: widget.codeData,
            newCodeData: CodeData(
              labelText: value,
              imagePath: widget.codeData.imagePath,
            ),
          );
        },
      );
    } else {
      return Text(widget.codeData.labelText);
    }
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        child: _getChild(),
      );
}
