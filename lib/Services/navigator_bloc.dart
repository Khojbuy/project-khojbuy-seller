import 'package:bloc/bloc.dart';
import 'package:khojbuy/Screens/pages/dashboard.dart';
import 'package:khojbuy/Screens/pages/orders.dart';
import 'package:khojbuy/Screens/pages/profile.dart';

enum NavigationEvents {
  DashBoardClickEvent,
  ProfileClickEvent,
  OrdersClickEvent
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
      case NavigationEvents.OrdersClickEvent:
        yield MyOrders();
        break;
    }
  }
}
