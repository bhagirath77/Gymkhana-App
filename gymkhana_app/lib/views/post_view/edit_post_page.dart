part of 'post_view.dart';

class EditPostPage extends StatefulWidget {
  final PostItem _postItem;

  const EditPostPage(this._postItem);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget._postItem.title;
    _descriptionController.text=widget._postItem.description;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    widget._postItem.photoUrl,
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _titleController,
                      validator: (val) {
                        if (val.length > 5) {
                          return 'Title should be greater than 5 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  final data = {
                    'title': _titleController.text,
                    'decription': _descriptionController.text
                  };

                  await context
                      .bloc<PostBloc>()
                      .databaseService
                      .updatePostData(postData: data,id: widget._postItem.id);
                  Navigator.pop(context);
                },
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
