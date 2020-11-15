import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khojbuy/Seller/Screens/pages/dashboard.dart';
import 'package:khojbuy/Seller/Screens/pages/profile.dart';
import 'package:khojbuy/Seller/Screens/pages/faq.dart';
import 'package:khojbuy/Seller/Screens/pages/about_us.dart';
import '../Models/seller.dart';

enum NavigationEvents {
  DashBoardClickEvent,
  ProfileClickEvent,
  FaqClickEvent,
  AboutEvent
}

abstract class NavigationStates {}

class NavigatorBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigatorBloc(NavigationStates initialState) : super(initialState);

  NavigationStates get initialState => DashBoardPage(false);

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickEvent:
        yield DashBoardPage(false);
        break;
      case NavigationEvents.ProfileClickEvent:
        yield ProfilePage();
        break;

      case NavigationEvents.FaqClickEvent:
        yield Faq();
        break;
      case NavigationEvents.AboutEvent:
        yield ContactInfo();

        break;
    }
  }
}
