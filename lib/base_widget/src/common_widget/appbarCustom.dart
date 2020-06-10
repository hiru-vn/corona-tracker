import 'package:flutter/material.dart';

class AppBarCustomNew extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final ValueChanged<String> onSubmitSearch;
  final bool haveSearch;
  final Color color;

  const AppBarCustomNew(
      {Key key,
      this.title,
      this.onSubmitSearch,
      this.haveSearch = false,
      this.color = Colors.white70})
      : super(key: key);
  @override
  _AppBarCustomNewState createState() => _AppBarCustomNewState();

  @override
  Size get preferredSize => Size(20.0, 60.0);
}

class _AppBarCustomNewState extends State<AppBarCustomNew> {
  bool isSearch = false;
  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.navigate_before,
              color: Colors.grey,
            )),
      ),
      actions: widget.haveSearch
          ? <Widget>[
              !isSearch
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                        color: widget.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearch = true;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: widget.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearch = false;
                          _searchController.text = '';
                          widget.onSubmitSearch(null);
                        });
                      },
                    )
            ]
          : null,
      title: !isSearch
          ? Text(widget.title, style: Theme.of(context).textTheme.headline.copyWith(color: Colors.black87))
          : TextField(
              textInputAction: TextInputAction.search,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Tìm kiếm... ",
                contentPadding: EdgeInsets.only(
                  left: 10,
                  right: _searchController.text.isNotEmpty ? 0 : 20,
                  top: 16,
                  bottom: 16,
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: 15.0),
                fillColor: Theme.of(context).primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: widget.color, width: 2.0),
                ),
              ),
              onSubmitted: widget.onSubmitSearch,
            ),
      elevation: 2,
      backgroundColor: Colors.white,
    );
  }
}
