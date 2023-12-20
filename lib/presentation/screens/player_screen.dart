import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:podcast_search/podcast_search.dart';



class PlayerScreen extends StatefulWidget {

  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _showFullText = false;
  Episode ?episode;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        episode=ModalRoute.of(context)!.settings.arguments as Episode;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;


    return Scaffold(
        appBar: AppBar(
          title: Text('this is title of podcast'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              size: 40,
            ),
            onPressed: () {},
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                // color: Colors.green,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.7,
                          height: size.width * 0.7,
                          // color: Colors.yellow,
                          decoration: BoxDecoration(
                            image:DecorationImage(
                              image: NetworkImage(episode!.imageUrl!)
                            )
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //TODO DESCRIPTION LENGTH SHOULD CHECK AND LOGICAL
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Html(
                            data: episode!.description,

                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showFullText = !_showFullText;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            // width:150,
                            // height: 50,
                            // color: Colors.orange,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.info_outline),
                                Text(_showFullText ? 'show less' : 'show more'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 20,),
            Container(
              width: size.width,
              height: size.height * 0.17,
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                children: [
                  Slider(
                    value: 0,
                    onChanged: (value) {},
                    max: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0:00'),
                        Text('0:00'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.fast_rewind,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.skip_previous,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow, size: 40)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.skip_next, size: 40)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.fast_forward,
                            size: 40,
                          )),
                    ],
                  ),
                  // SizedBox(height: ,)
                ],
              ),
            )
          ],
        ));
  }
}
