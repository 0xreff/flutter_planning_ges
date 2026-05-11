import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';
import 'package:in_app_review_library_y5nqfg/index.dart'
    as $in_app_review_library_y5nqfg;

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  $in_app_review_library_y5nqfg.initializeRoutes(
    homePageWidgetName: 'in_app_review_library_y5nqfg.HomePage',
    homePageWidgetPath: '/0',
  );

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    navigatorKey: appNavigatorKey,
    errorBuilder: (context, state) =>
        appStateNotifier.loggedIn ? NavBarPage() : Auth2LoginWidget(),
    routes: [
      FFRoute(
        name: '_initialize',
        path: '/',
        builder: (context, _) =>
            appStateNotifier.loggedIn ? NavBarPage() : Auth2LoginWidget(),
      ),
      FFRoute(
        name: ListerdvWidget.routeName,
        path: ListerdvWidget.routePath,
        builder: (context, params) => ListerdvWidget(),
      ),
      FFRoute(
        name: Auth2CreateWidget.routeName,
        path: Auth2CreateWidget.routePath,
        builder: (context, params) => Auth2CreateWidget(),
      ),
      FFRoute(
        name: Auth2LoginWidget.routeName,
        path: Auth2LoginWidget.routePath,
        builder: (context, params) => Auth2LoginWidget(),
      ),
      FFRoute(
        name: Auth2ForgotPasswordWidget.routeName,
        path: Auth2ForgotPasswordWidget.routePath,
        builder: (context, params) => Auth2ForgotPasswordWidget(),
      ),
      FFRoute(
        name: Auth2CreateProfileWidget.routeName,
        path: Auth2CreateProfileWidget.routePath,
        builder: (context, params) => Auth2CreateProfileWidget(),
      ),
      FFRoute(
        name: Auth2ProfileWidget.routeName,
        path: Auth2ProfileWidget.routePath,
        builder: (context, params) => Auth2ProfileWidget(),
      ),
      FFRoute(
        name: Auth2EditProfileWidget.routeName,
        path: Auth2EditProfileWidget.routePath,
        builder: (context, params) => Auth2EditProfileWidget(),
      ),
      FFRoute(
        name: ForumWidget.routeName,
        path: ForumWidget.routePath,
        builder: (context, params) => ForumWidget(),
      ),
      FFRoute(
        name: AddPartnerPageWidget.routeName,
        path: AddPartnerPageWidget.routePath,
        builder: (context, params) => AddPartnerPageWidget(),
      ),
      FFRoute(
        name: PartnerListPageWidget.routeName,
        path: PartnerListPageWidget.routePath,
        builder: (context, params) => PartnerListPageWidget(
          collaborationToEdit: params.getParam(
            'collaborationToEdit',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['collaborations'],
          ),
        ),
      ),
      FFRoute(
        name: CollaborationDetailPageWidget.routeName,
        path: CollaborationDetailPageWidget.routePath,
        builder: (context, params) => CollaborationDetailPageWidget(
          collaborationRef: params.getParam(
            'collaborationRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['collaborations'],
          ),
        ),
      ),
      FFRoute(
        name: CollaborationListPageWidget.routeName,
        path: CollaborationListPageWidget.routePath,
        builder: (context, params) => CollaborationListPageWidget(),
      ),
      FFRoute(
        name: PartnerDetailPageWidget.routeName,
        path: PartnerDetailPageWidget.routePath,
        builder: (context, params) => PartnerDetailPageWidget(
          partner: params.getParam(
            'partner',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['partners'],
          ),
        ),
      ),
      FFRoute(
        name: EditPartnerPageWidget.routeName,
        path: EditPartnerPageWidget.routePath,
        builder: (context, params) => EditPartnerPageWidget(
          partnerToEdit: params.getParam(
            'partnerToEdit',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['partners'],
          ),
        ),
      ),
      FFRoute(
        name: AddrdvWidget.routeName,
        path: AddrdvWidget.routePath,
        builder: (context, params) => AddrdvWidget(),
      ),
      FFRoute(
        name: NouveauforumWidget.routeName,
        path: NouveauforumWidget.routePath,
        builder: (context, params) => NouveauforumWidget(),
      ),
      FFRoute(
        name: ModifRdvWidget.routeName,
        path: ModifRdvWidget.routePath,
        builder: (context, params) => ModifRdvWidget(),
      ),
      FFRoute(
        name: SuppDialogWidget.routeName,
        path: SuppDialogWidget.routePath,
        asyncParams: {
          'appointement':
              getDoc(['appointements'], AppointementsRecord.fromSnapshot),
        },
        builder: (context, params) => SuppDialogWidget(
          appointement: params.getParam(
            'appointement',
            ParamType.Document,
          ),
        ),
      ),
      FFRoute(
        name: HomePageWidget.routeName,
        path: HomePageWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'homePage')
            : HomePageWidget(),
      ),
      FFRoute(
        name: EditCollaborationPageWidget.routeName,
        path: EditCollaborationPageWidget.routePath,
        builder: (context, params) => EditCollaborationPageWidget(
          collaborationToEdit: params.getParam(
            'collaborationToEdit',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['collaborations'],
          ),
        ),
      ),
      FFRoute(
        name: AddProductWidget.routeName,
        path: AddProductWidget.routePath,
        builder: (context, params) => AddProductWidget(),
      ),
      FFRoute(
        name: AdminProductsWidget.routeName,
        path: AdminProductsWidget.routePath,
        builder: (context, params) => AdminProductsWidget(),
      ),
      FFRoute(
        name: UserProductsWidget.routeName,
        path: UserProductsWidget.routePath,
        builder: (context, params) => UserProductsWidget(),
      ),
      FFRoute(
        name: OrderAdminWidget.routeName,
        path: OrderAdminWidget.routePath,
        builder: (context, params) => OrderAdminWidget(),
      ),
      FFRoute(
        name: UserOrdersWidget.routeName,
        path: UserOrdersWidget.routePath,
        builder: (context, params) => UserOrdersWidget(),
      ),
      FFRoute(
        name: EditProductWidget.routeName,
        path: EditProductWidget.routePath,
        asyncParams: {
          'produit': getDoc(['product'], ProductRecord.fromSnapshot),
        },
        builder: (context, params) => EditProductWidget(
          produit: params.getParam(
            'produit',
            ParamType.Document,
          ),
        ),
      ),
      FFRoute(
        name: ListeTachesWidget.routeName,
        path: ListeTachesWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'listeTaches')
            : ListeTachesWidget(),
      ),
      FFRoute(
        name: AjouterTacheWidget.routeName,
        path: AjouterTacheWidget.routePath,
        builder: (context, params) => AjouterTacheWidget(),
      ),
      FFRoute(
        name: EditformeWidget.routeName,
        path: EditformeWidget.routePath,
        builder: (context, params) => EditformeWidget(
          formRef: params.getParam(
            'formRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['formme'],
          ),
        ),
      ),
      FFRoute(
        name: AddCollaborationPageWidget.routeName,
        path: AddCollaborationPageWidget.routePath,
        builder: (context, params) => AddCollaborationPageWidget(),
      ),
      FFRoute(
        name: ListeShiftsWidget.routeName,
        path: ListeShiftsWidget.routePath,
        builder: (context, params) => ListeShiftsWidget(),
      ),
      FFRoute(
        name: ChatbotWidget.routeName,
        path: ChatbotWidget.routePath,
        builder: (context, params) => ChatbotWidget(),
      ),
      FFRoute(
        name: CollabPDFWidget.routeName,
        path: CollabPDFWidget.routePath,
        builder: (context, params) => CollabPDFWidget(),
      ),
      FFRoute(
        name: AjouterShiftWidget.routeName,
        path: AjouterShiftWidget.routePath,
        builder: (context, params) => AjouterShiftWidget(),
      ),
      FFRoute(
        name: ListePlansTraitementWidget.routeName,
        path: ListePlansTraitementWidget.routePath,
        builder: (context, params) => ListePlansTraitementWidget(),
      ),
      FFRoute(
        name: StatsPartnershipsPageWidget.routeName,
        path: StatsPartnershipsPageWidget.routePath,
        builder: (context, params) => params.isEmpty
            ? NavBarPage(initialPage: 'StatsPartnershipsPage')
            : StatsPartnershipsPageWidget(),
      ),
      FFRoute(
        name: PlanningDashboardWidget.routeName,
        path: PlanningDashboardWidget.routePath,
        builder: (context, params) => PlanningDashboardWidget(),
      ),
      FFRoute(
        name: HomePatientWidget.routeName,
        path: HomePatientWidget.routePath,
        builder: (context, params) => HomePatientWidget(),
      ),
      FFRoute(
        name: ConsultationPatientWidget.routeName,
        path: ConsultationPatientWidget.routePath,
        builder: (context, params) => ConsultationPatientWidget(
          ref: params.getParam(
            'ref',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['medical_records'],
          ),
        ),
      ),
      FFRoute(
        name: ViewConsultationWidget.routeName,
        path: ViewConsultationWidget.routePath,
        builder: (context, params) => ViewConsultationWidget(
          iduser: params.getParam(
            'iduser',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['users'],
          ),
          idconsultation: params.getParam(
            'idconsultation',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['consultations'],
          ),
        ),
      ),
      FFRoute(
        name: HomeDoctorWidget.routeName,
        path: HomeDoctorWidget.routePath,
        builder: (context, params) => HomeDoctorWidget(),
      ),
      FFRoute(
        name: CreateRecordWidget.routeName,
        path: CreateRecordWidget.routePath,
        builder: (context, params) => CreateRecordWidget(
          patient: params.getParam(
            'patient',
            ParamType.String,
          ),
          id: params.getParam(
            'id',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['users'],
          ),
        ),
      ),
      FFRoute(
        name: UpdateRecordWidget.routeName,
        path: UpdateRecordWidget.routePath,
        builder: (context, params) => UpdateRecordWidget(
          patient: params.getParam(
            'patient',
            ParamType.String,
          ),
          id: params.getParam(
            'id',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['medical_records'],
          ),
        ),
      ),
      FFRoute(
        name: ViewbackofficeWidget.routeName,
        path: ViewbackofficeWidget.routePath,
        builder: (context, params) => ViewbackofficeWidget(
          id: params.getParam(
            'id',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['medical_records'],
          ),
        ),
      ),
      FFRoute(
        name: CreateConsultationWidget.routeName,
        path: CreateConsultationWidget.routePath,
        builder: (context, params) => CreateConsultationWidget(
          id: params.getParam(
            'id',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['users'],
          ),
          recordRef: params.getParam(
            'recordRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['medical_records'],
          ),
        ),
      ),
      FFRoute(
        name: UpdateConsultationWidget.routeName,
        path: UpdateConsultationWidget.routePath,
        builder: (context, params) => UpdateConsultationWidget(
          id: params.getParam(
            'id',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['users'],
          ),
          recordRef: params.getParam(
            'recordRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['medical_records'],
          ),
          idconsultation: params.getParam(
            'idconsultation',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['consultations'],
          ),
        ),
      ),
      FFRoute(
        name: ChatPageWidget.routeName,
        path: ChatPageWidget.routePath,
        builder: (context, params) => ChatPageWidget(
          chatRef: params.getParam(
            'chatRef',
            ParamType.DocumentReference,
            isList: false,
            collectionNamePath: ['chats'],
          ),
        ),
      ),
      FFRoute(
        name: MedicamentWidget.routeName,
        path: MedicamentWidget.routePath,
        builder: (context, params) => MedicamentWidget(),
      ),
      FFRoute(
        name: CreateOrdonnanceWidget.routeName,
        path: CreateOrdonnanceWidget.routePath,
        builder: (context, params) => CreateOrdonnanceWidget(),
      ),
      FFRoute(
        name: NewProductWidget.routeName,
        path: NewProductWidget.routePath,
        builder: (context, params) => NewProductWidget(),
      ),
      FFRoute(
        name: AadddWidget.routeName,
        path: AadddWidget.routePath,
        builder: (context, params) => AadddWidget(),
      ),
      FFRoute(
        name: TeleconsultationWidget.routeName,
        path: TeleconsultationWidget.routePath,
        builder: (context, params) => TeleconsultationWidget(),
      ),
      FFRoute(
        name: $in_app_review_library_y5nqfg.HomePageWidget.routeName,
        path: $in_app_review_library_y5nqfg.HomePageWidget.routePath,
        builder: (context, params) =>
            $in_app_review_library_y5nqfg.HomePageWidget(),
      )
    ].map((r) => r.toRoute(appStateNotifier)).toList(),
  );
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo {
    final possibleKeys = [
      '__transition_info__',
      '__transition_info__in_app_review_library_y5nqfg'
    ];
    for (final key in possibleKeys) {
      if (extraMap.containsKey(key)) {
        return extraMap[key] as TransitionInfo;
      }
    }
    return TransitionInfo.appDefault();
  }
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/auth2Login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
