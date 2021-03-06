import 'package:crossroads_events/generated/i18n.dart';
import 'package:crossroads_events/utilities/style.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Walkthrough extends StatefulWidget {
  final SharedPreferences prefs;

  Walkthrough({this.prefs});

  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
//            gradient: LinearGradient(
//              colors: [
//                Theme.of(context).colorScheme.primary,
//                Theme.of(context).colorScheme.secondary
//              ],
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//            ),
          ),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: viewportConstraints.maxWidth,
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              widget.prefs.setBool('seen', true);
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'Passer',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                        SizedBox(
                          height:
                              (MediaQuery.of(context).size.width * 7) / 4.25,
                          child: PageView(
                            physics: ClampingScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (int page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Wrap(
                                  children: <Widget>[
                                    Center(
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: FlareActor(
                                              'assets/animations/easypurchase.flr',
                                              alignment: Alignment.center,
                                              animation: 'start',
                                            ))),
                                    SizedBox(height: 30.0),
                                    Text(
                                      S().achetezvosticketssimplement,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: kSubtitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Wrap(
                                  children: <Widget>[
                                    Center(
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: FlareActor(
                                              'assets/animations/easyscan.flr',
                                              alignment: Alignment.center,
                                              animation: 'start',
                                            ))),
                                    SizedBox(height: 30.0),
                                    Text(
                                      'Ne faîtes plus la queue!',
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: kSubtitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Wrap(
                                  children: <Widget>[
                                    Center(
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: FlareActor(
                                              'assets/animations/easychat.flr',
                                              alignment: Alignment.center,
                                              animation: 'start',
                                            ))),
                                    SizedBox(height: 30.0),
                                    Text(
                                      'Restez en contact avec\nvos rencontres',
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                    SizedBox(height: 15.0),
                                    Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: kSubtitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildPageIndicator(),
                        ),
                        _currentPage != _numPages - 1
                            ? Align(
                                alignment: FractionalOffset.bottomRight,
                                child: FlatButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Suivant',
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? Container(
                height: 100.0,
                width: double.infinity,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () {
                    widget.prefs.setBool('seen', true);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Démarrer',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(''),
      ),
    );
  }
}
