import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/cart.dart';
import 'package:project_seven_nike_welcomeback/ui/home/home.dart';
import 'package:project_seven_nike_welcomeback/ui/profile/profile_screen.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/badge.dart';

const homeIndex = 0;
const cartIndex = 1;
const profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, const HomeScreen()),
              _navigator(_cartKey, cartIndex, const CartScreen()),
              _navigator(
                _profileKey,
                profileIndex,
                const ProfileScreen(),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'خانه'),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(CupertinoIcons.cart),
                      Positioned(
                        right: -10,
                        child: ValueListenableBuilder<int>(
                            valueListenable:
                                CartRepository.cartItemCountNotifier,
                             builder: (context,value,child){
                              return kBadge(value: value);
                             }),
                      )
                    ],
                  ),
                  label: 'سبد خرید'),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                      offstage: selectedScreenIndex != index,
                      child: child,
                    )),
          );
  }
  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }

}


//bottomNavigationBar:   BottomNavigationBar(

//             currentIndex: selectedScreenIndex,
//             onTap: (selectedScreenIndex) {
//               selectedScreenIndex = selectedIndex;
//             },
//           ),
