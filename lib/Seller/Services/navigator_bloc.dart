import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Seller/Screens/pages/dashboard.dart';
import 'package:khojbuy/Seller/Screens/pages/menu/view.dart';
import 'package:khojbuy/Seller/Screens/pages/profile_pages/profile.dart';
import 'package:khojbuy/Seller/Screens/pages/about_us.dart';
import 'package:khojbuy/Seller/Screens/pages/review.dart';
import 'package:khojbuy/Seller/Screens/pages/story.dart';

enum NavigationEvents {
  DashBoardClickEvent,
  ProfileClickEvent,
  AboutEvent,
  MenuEvent,
  StoryAddEvent,
  ReviewEvent
}

abstract class NavigationStates {}

class NavigatorBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigatorBloc(NavigationStates initialState) : super(initialState);

  NavigationStates get initialState => DashBoardPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickEvent:
        yield DashBoardPage();
        break;
      case NavigationEvents.ProfileClickEvent:
        yield ProfilePage();
        break;
      case NavigationEvents.StoryAddEvent:
        yield StoryAdd();
        break;
      case NavigationEvents.AboutEvent:
        yield ContactInfo();
        break;
      case NavigationEvents.MenuEvent:
        yield ShopMenu();
        break;
      case NavigationEvents.ReviewEvent:
        yield ReviewPage();
        break;
    }
  }
}
