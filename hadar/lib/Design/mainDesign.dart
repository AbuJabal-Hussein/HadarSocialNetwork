
import 'basicTools.dart';
import 'package:flutter/material.dart';


class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  String title;

  MySliverAppBar({required this.expandedHeight, required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          child: Image.asset(
            "assets/images/color.jpg",
            fit: BoxFit.cover,
          ),
        ),
        // Container( alignment: Alignment.topRight, child: Text(' שלום $title') ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(

              elevation:0 ,color: Colors.transparent,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: UserCircle(),
                // child: UserCircle(),
              ),
            ),
          ),
        ),
        Navigator.canPop(context) ? Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width/30,
          child: IconButton(
              icon: Icon(Icons.keyboard_arrow_left , color: Colors.white,size: 45,),
              onPressed: (){
                print("asdasd");
                if(Navigator.canPop(context)){
                  print("asdasdddd23333333333");
                  Navigator.pop(context);
                }else{
                  print("asdasdddd");
                  Navigator.pop(context);

                }
              },
            ),
        ) : Container(),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

//when using this, send the color you want to use
//see example in BackgroundDesign class
//the icons aren't linked to another page yet
class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: BasicColor.backgroundClr,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(-3, -3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 1,),
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: BasicColor.clr,
                      ),
                      onPressed: () {
                        if(ModalRoute.of(context)!.settings.name != '/userProfile') {
                          Navigator.pushNamed(
                              context,
                              '/userProfile',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(flex: 1,),

                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.dynamic_feed_outlined,
                        size: 30,
                        color: BasicColor.clr,
                      ),
                      onPressed: () async {
                        if(ModalRoute.of(context)!.settings.name != '/userMainPage' && ModalRoute.of(context)!.settings.name != '/'){
                          Navigator.pushNamed(
                            context,
                            '/userMainPage',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(flex: 1,),

                ],
              ),
            ),
          ),
        ),
      // ),
    );
  }
}

class AdminBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: BasicColor.backgroundClr,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(-3, -3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(60, 10, 60, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Spacer(flex: 1,),
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: BasicColor.clr,
                      ),
                      onPressed: () {
                        if(ModalRoute.of(context)!.settings.name != '/adminProfile'){
                          Navigator.pushNamed(
                            context,
                            '/adminProfile',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(flex: 1,),
                  Expanded(
                    child: FlatButton(
                      child: Icon(Icons.supervisor_account_sharp,
                        size: 30,
                        color: BasicColor.clr,
                      ),
                      onPressed: () {
                        if(ModalRoute.of(context)!.settings.name != '/adminAllUsersView') {
                          Navigator.pushNamed(
                            context,
                            '/adminAllUsersView',
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(flex: 1,),
                  Expanded(
                    child: FlatButton(
                      child: Icon(
                        Icons.admin_panel_settings_outlined,
                        size: 30,
                        color: BasicColor.clr,
                      ),
                      onPressed: (){
                        if(ModalRoute.of(context)!.settings.name != '/adminPage'
                            && ModalRoute.of(context)!.settings.name != '/') {
                          Navigator.pushNamed(
                            context,
                            '/adminPage',
                          );
                        }
                      }
                    ),
                  ),
                  //Spacer(flex: 1,),
                ],
              ),
            ),
          ),
        ),
        // ),
      );
  }
}

// in  the future this will show the user picture
// gets the user name and looks for the picture in the database
class UserCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.transparent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/try.png',
              // width: 150,
              // height: 150,
            ),
          ),
        ],
      ),
    );
  }
}


class AdminViewRequestsBar extends StatelessWidget {
  final String title;
  AdminViewRequestsBar(this.title);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: Navigator.canPop(context) ? Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.chevron_right , color: Colors.white,size: 45,),
            onPressed: (){
              if(Navigator.canPop(context)){
                Navigator.pop(context);
              }else{
                Navigator.pop(context);
              }
            },
        ),
      ) : Container(),
      automaticallyImplyLeading: false,
      expandedHeight: 80.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              )),
          background: Image.asset(
        "assets/images/color.jpg",
        fit: BoxFit.cover,
      ),),
    );
  }
}



