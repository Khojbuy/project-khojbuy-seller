import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Seller/Screens/pages/dashboard.dart';
import 'package:khojbuy/Seller/Screens/pages/profile.dart';
import 'package:khojbuy/Seller/Screens/pages/about_us.dart';

enum NavigationEvents { DashBoardClickEvent, ProfileClickEvent, AboutEvent }

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

        break;
      case NavigationEvents.AboutEvent:
        yield ContactInfo();

        break;
    }
  }
}
