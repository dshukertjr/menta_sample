import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/bloc/compose_post/compose_post_bloc.dart';
import 'package:sample/pages/tab_page.dart';

class ComposePostPage extends StatefulWidget {
  @override
  _ComposePostPageState createState() => _ComposePostPageState();
}

class _ComposePostPageState extends State<ComposePostPage> {
  TextEditingController _textController;
  File _imageFile;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('投稿'),
      ),
      body: BlocListener<ComposePostBloc, ComposePostState>(
        condition: (oldState, state) {
          if (oldState is SubmittingPostState && state is ComposePostInitial) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('投稿されました！')));
          _textController.clear();
          _imageFile = null;
          setState(() {});
          TabInherited.of(context).openTab(0);
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(12),
            children: <Widget>[
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return '必須項目です';
                  }
                  return null;
                },
                controller: _textController,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '写真と一言',
                ),
              ),
              SizedBox(height: 12),
              _imageFile == null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: RaisedButton(
                        color: Color(0xFFf0f0f0),
                        textTheme: ButtonTextTheme.normal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.image),
                            Text('画像を選ぶ'),
                          ],
                        ),
                        onPressed: () {
                          _selectImage();
                        },
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        _selectImage();
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.file(
                          _imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              BlocBuilder<ComposePostBloc, ComposePostState>(
                  builder: (context, state) {
                return RaisedButton(
                  child: state is SubmittingPostState
                      ? Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : Text('投稿'),
                  onPressed: () {
                    FocusScope.of(context).unfocus(focusPrevious: true);
                    final result = _formKey.currentState.validate();
                    if (!result) {
                      return;
                    }
                    final text = _textController.text;
                    BlocProvider.of<ComposePostBloc>(context).add(
                      ComposeEvent(
                        text: text,
                        imageFile: _imageFile,
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    FocusScope.of(context).unfocus(focusPrevious: true);
    _imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 75,
    );
    setState(() {});
  }
}
