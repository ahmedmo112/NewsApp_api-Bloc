import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/medouls/web_view/web_view_screen.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Function onSubmit;
  final Function onchange;
  final Function validate;
  final String label;
  final IconData prefix;
  final bool isPassword;
  final IconData suffix;
  final Function onTap;
  final isEnabled;

  const DefaultFormField({
    Key key,
    @required this.controller,
    @required this.type,
    this.onSubmit,
    this.onchange,
    this.onTap,
    this.isEnabled = true,
    @required this.validate,
    @required this.label,
    @required this.prefix,
    this.suffix,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      onTap: onTap,
      enabled: isEnabled,
      validator: validate,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null ? Icon(suffix) : null,
          border: OutlineInputBorder()),
    );
  }
}

//! ////////////////////////////////////////////
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
//! ///////////////////////////////////////////

Widget buildArticleItem(dynamic article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  // mainAxisSize: MainAxisSize.min,

                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, context , {isSearch= false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
          itemCount: list.length),
      fallback: (context) =>isSearch? Container(): Center(
        child: CircularProgressIndicator(),
      ),
    );
