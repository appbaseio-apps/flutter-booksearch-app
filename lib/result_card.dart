import 'star_display.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'result_description.dart';

class ResultCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  ResultCard(this.data);

  _launchURL(query) async {
    dynamic url = 'https://google.com/search?q=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(data['original_title']),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Card(
                elevation: 50,
                shadowColor: Theme.of(context).primaryColorDark,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: SizedBox(
                  height: 250,
                  child: Image.network(
                    data["image"],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: data['original_title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'By: ${data["authors"]}',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          'Pub: ${data["original_publication_year"]}',
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: IconTheme(
                                    data: Theme.of(context).iconTheme,
                                    child: StarDisplay(
                                        value: data["average_rating_rounded"]),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 3, 8, 0),
                                  child: Text(
                                    '(${data["average_rating"]} avg)',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: ResultDescription(
                                data['original_title'].split(' ').join('+')),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _launchURL(
                                  data['original_title'].split(' ').join('+'));
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8, 4, 10),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Search on Web',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 8, 0, 8),
                                      child: Icon(Icons.open_in_new, size: 25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
