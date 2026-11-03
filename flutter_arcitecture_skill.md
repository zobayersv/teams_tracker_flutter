---
name: softvence-flutter-template-master
description: >-
  Master implementation rules for Flutter projects based on
  NayemSoftvence/flutter_template. Use this skill whenever creating,
  modifying, reviewing, debugging, or extending application code in this
  architecture. It preserves the project's feature-based structure, RxDart
  state flow, Dio networking, GetIt/GetStorage usage, navigation, generated
  assets/colors, shared widgets, responsive sizing, error handling, and
  human-readable coding style.
---

# Softvence Flutter Template — Master Engineering Skill

## 0. Purpose

This file is the normative implementation guide for agents working in Flutter
projects derived from `NayemSoftvence/flutter_template`.

The goal is not merely to make code compile. The goal is to make every change
look and behave as though it was written intentionally inside this codebase:

- preserve the feature-based architecture;
- reuse existing helpers and shared widgets;
- preserve current navigation, API, RxDart, storage, and error flows;
- use generated assets/colors instead of hardcoded paths or duplicated values;
- keep UI responsive using ScreenUtil conventions;
- avoid introducing a second architecture or state-management system;
- avoid unnecessary abstractions and AI-looking boilerplate;
- make the smallest clean change that fully satisfies the requirement;
- never silently break compatibility-sensitive names or behavior.

This skill was derived from the repository's `dev` branch, including its active
`lib/` code, shared infrastructure, generated-asset configuration, feature
examples, `pubspec.yaml`, lint configuration, README, and architecture report.

---

# 1. Non-negotiable operating rules

## 1.1 Inspect before editing

Before writing code, inspect the relevant existing files.

At minimum, inspect:

1. the closest existing feature with similar behavior;
2. related files under `common_widgets/`;
3. related files under `helpers/`;
4. `networks/endpoints.dart` for APIs;
5. `networks/api_acess.dart` for shared Rx instances;
6. `helpers/all_routes.dart` for navigation;
7. `constants/text_font_style.dart` for typography;
8. `lib/gen/colors.gen.dart` and `assets/color/colors.xml` for colors;
9. `lib/gen/assets.gen.dart` for assets;
10. `constants/validator.dart` before creating validation logic;
11. all provided screenshots or design mockups across screens to identify reusable buttons and shared components before writing any widget.

Do not invent a new pattern before checking whether the repository already has
one.

## 1.2 Make surgical changes

Implement the smallest coherent change that satisfies the requirement.

Do not:

- reformat unrelated files;
- reorganize unrelated folders;
- rename existing public helpers casually;
- migrate state management while implementing a feature;
- replace navigation architecture as a side effect;
- replace networking architecture as a side effect;
- rewrite working widgets only because another style is possible;
- introduce a generic abstraction for a one-off problem;
- clean up unrelated template/demo issues unless explicitly requested.

## 1.3 Preserve compatibility first

This repository contains several established names with spelling or casing that
would normally be corrected in a fresh project. If they are already referenced,
treat them as compatibility-sensitive APIs.

Examples include names such as:

- `api_acess.dart`
- `custome_theme.dart`
- `error_message_Handler.dart`
- `url_lunch.dart`
- `CustomTexButton`
- `popAndReplaceWihArgs`
- `featchProducts`
- `featchProfile`
- `kSelectedCategotyId`

Do **not** rename such identifiers during ordinary feature work.

A rename is allowed only when the task is explicitly a refactor and all
references, tests, imports, persisted keys, and compatibility effects are
handled together.

## 1.4 Active architecture beats stale examples

The repository contains commented examples, placeholder functionality, demo
values, and legacy code. These are useful for context but are not automatically
coding standards.

Do not copy:

- commented-out Provider/GetX/Firebase/location examples unless the requested
  feature intentionally activates and configures them;
- hardcoded demo credentials;
- placeholder product data in production paths;
- old commented API examples as if they were live dependencies;
- default Flutter counter-test assumptions that no longer describe the app;
- accidental one-off violations of the project's shared-helper conventions.

When documentation, an isolated demo snippet, and active shared infrastructure
conflict, prefer the active shared architecture and the nearest production-like
feature implementation.

---

# 2. Architecture model

The project uses a feature-based architecture with a reactive layer between UI
and API access.

Think in this flow:

```text
Presentation/UI
    ↓ user intent / initial fetch
Rx class (RxDart BehaviorSubject)
    ↓
Feature API class
    ↓
Central HTTP helper / Dio singleton
    ↓
Backend

Backend response
    ↓
Feature API class
    ↓
Rx success/error handling
    ↓
BehaviorSubject stream
    ↓
StreamBuilder/UI
```

For API-backed features, preserve these responsibilities.

## 2.1 Presentation layer

Location:

```text
lib/features/<feature>/presentation/
```

Responsibilities:

- build UI;
- collect user input;
- trigger Rx methods;
- observe streams;
- render loading/data/empty/error states;
- navigate using the existing navigation system;
- delegate reusable visual sections to feature widgets.

Presentation code must **not** instantiate Dio, build endpoint URLs, implement
HTTP status handling, or duplicate global error mapping.

## 2.2 Feature data/API layer

Location pattern:

```text
lib/features/<feature>/data/rx_<verb>_<resource>/
  api.dart
  rx.dart
```

Examples of expected naming:

```text
rx_get_products/
rx_get_product_details/
rx_post_login/
rx_post_signup/
```

The API class performs HTTP communication.

The Rx class performs reactive state orchestration and exposes the stream to the
UI.

## 2.3 Model layer

Location:

```text
lib/features/<feature>/model/
```

Use models for structured API responses and domain data.

Prefer typed `Map<String, dynamic>` boundaries when practical and convert to
models at a clear boundary. Existing features sometimes expose raw `Map`
streams; preserve an existing feature's contract when changing it unless the
task includes a deliberate migration.

Do not spread `dynamic` farther through new code merely because older template
code uses untyped `Map` in some places.

## 2.4 Shared infrastructure

Use these project areas instead of recreating them inside features:

```text
lib/common_widgets/
lib/constants/
lib/helpers/
lib/networks/
lib/gen/
```

---

# 3. Canonical project structure

Use this shape when adding code:

```text
lib/
├── main.dart
├── loading_screen.dart
├── welcome_screen.dart
├── navigation_screen.dart
│
├── common_widgets/
│   ├── app_network_image.dart
│   ├── custom_appbar.dart
│   ├── custom_button.dart
│   ├── custom_rich_text_button.dart
│   ├── custom_text_button.dart
│   ├── custom_textform_field.dart
│   ├── custom_toast.dart
│   ├── loading_indicators.dart
│   ├── no_data_widget.dart
│   ├── not_found_widget.dart
│   └── waiting_widget.dart
│
├── constants/
│   ├── app_constants.dart
│   ├── custome_theme.dart
│   ├── text_font_style.dart
│   └── validator.dart
│
├── features/
│   └── <feature>/
│       ├── data/
│       │   └── rx_<verb>_<resource>/
│       │       ├── api.dart
│       │       └── rx.dart
│       ├── model/
│       │   └── <resource>_model.dart
│       ├── widget/
│       │   └── <feature_widget>.dart
│       └── presentation/
│           └── <screen>.dart
│
│
├── gen/                       # generated: never hand edit
│   ├── assets.gen.dart
│   ├── colors.gen.dart
│   └── fonts.gen.dart
│
├── helpers/
│   ├── all_routes.dart
│   ├── di.dart
│   ├── error_message_Handler.dart
│   ├── helper_methods.dart
│   ├── loading_helper.dart
│   ├── navigation_service.dart
│   ├── social_auth.dart
│   ├── ui_helpers.dart
│   ├── web_socket_service.dart
│   └── ...
│
└── networks/
    ├── api_acess.dart
    ├── endpoints.dart
    ├── rx_base.dart
    ├── dio/
    │   ├── dio.dart
    │   └── log.dart
    └── exception_handler/
```

Do not add top-level architecture folders such as `providers/`, `controllers/`,
`repositories/`, `services/`, or `bloc/` merely because another Flutter style
uses them. Add a new architectural layer only when the task explicitly requires
it and the change is agreed for the whole project.

---

# 4. Feature creation workflow

When implementing a new API-backed feature, follow this sequence unless the
requirement genuinely needs a different order.

## Step 1 — Identify the feature boundary

Choose the existing feature if the behavior belongs to an established domain.
Create a new feature only for a distinct product/domain capability.

Good:

```text
features/orders/
features/notifications/
features/user_profile/
```

Bad:

```text
features/common/
features/misc/
features/api_stuff/
features/screens/
```

## Step 2 — Define or update model(s)

Create models under:

```text
features/<feature>/model/
```

Model rules:

- map JSON keys exactly;
- keep nullability aligned with the API contract;
- parse nested objects in their model constructors;
- parse dates deliberately;
- provide `toJson()` when needed by the surrounding code style;
- do not mix widget/UI behavior into models;
- do not invent default values that hide malformed backend responses unless the
  product requirement calls for defaults.

If backend shape is uncertain, preserve defensive parsing and handle the absent
state in UI rather than force-casting blindly.

## Step 3 — Add endpoint centrally

All endpoint construction belongs in:

```text
lib/networks/endpoints.dart
```

Do not hardcode API paths inside screens or feature API classes.

Use a method when parameters are required.

Conceptual pattern:

```dart
static String orderDetails(int id) => '/orders/$id';
```

Keep the existing base URL and header strategy in the networking layer.

## Step 4 — Create API class

Create:

```text
features/<feature>/data/rx_<verb>_<resource>/api.dart
```

Follow the singleton API-class pattern where the feature uses it.

### Required Imports

```dart
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../networks/dio/dio.dart';
import '../../../../networks/endpoints.dart';
import '../../../../networks/exception_handler/data_source.dart';
```
*(Adjust relative path depth `../../../..` according to feature folder nesting).*

### Example A: GET Request (Fetching Data)

```dart
final class GetProfileApi {
  static final GetProfileApi _singleton = GetProfileApi._internal();
  GetProfileApi._internal();
  static GetProfileApi get instance => _singleton;

  Future<Map> getProfile() async {
    try {
      Response response = await getHttp(Endpoints.getProfile());
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

### Example B: POST Request with Payload (Mutating / Creating Data)

```dart
final class PostLoginApi {
  static final PostLoginApi _singleton = PostLoginApi._internal();
  PostLoginApi._internal();
  static PostLoginApi get instance => _singleton;

  Future<Map> postLogin(Map data) async {
    try {
      Response response = await postHttp(Endpoints.login(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

### Example C: POST / PUT Request with Route Parameter (Updating Data)

```dart
final class PostUpdateSummaryApi {
  static final PostUpdateSummaryApi _singleton =
      PostUpdateSummaryApi._internal();
  PostUpdateSummaryApi._internal();
  static PostUpdateSummaryApi get instance => _singleton;

  Future<Map> postUpdateSummary(Map data, int? id) async {
    try {
      Response response = await postHttp(Endpoints.updateSwapSummary(id), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

### Example D: DELETE Request with Route Parameter

```dart
final class DeleteSwapSummaryApi {
  static final DeleteSwapSummaryApi _singleton =
      DeleteSwapSummaryApi._internal();
  DeleteSwapSummaryApi._internal();
  static DeleteSwapSummaryApi get instance => _singleton;

  Future<Map> deleteSwapSummary(int? id) async {
    try {
      Response response = await deleteHttp(Endpoints.deleteSwapSummary(id));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

### Example E: Multipart / File Upload Request (FormData)

```dart
final class PostUpdateProfilePicApi {
  static final PostUpdateProfilePicApi _singleton =
      PostUpdateProfilePicApi._internal();
  PostUpdateProfilePicApi._internal();
  static PostUpdateProfilePicApi get instance => _singleton;

  Future<Map> postUpdateProfilePic(dynamic data) async {
    try {
      Response response = await postHttp(Endpoints.updateProfilePicture(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

API-class rules:

- use `getHttp`, `postHttp`, `putHttp`, or `deleteHttp` from the central network helper;
- use `Endpoints` (never hardcode URLs or paths inside the API class);
- do not create `Dio()` locally;
- do not duplicate auth headers locally unless an endpoint has a special contract;
- do not show UI toasts from the API class;
- do not navigate from the API class;
- always rethrow errors so the Rx/error layer handles them;
- verify `response.statusCode == 200 || response.statusCode == 201` and throw `DataSource.DEFAULT.getFailure()` otherwise.

## Step 5 — Create Rx class

Create:

```text
features/<feature>/data/rx_<verb>_<resource>/rx.dart
```

The Rx class:

- extends `RxResponseInt`;
- accesses the feature API singleton (`final api = ...Api.instance;`);
- defines `String message = "Something went wrong";`;
- accepts `required super.empty` and `required super.dataFetcher` in its constructor;
- exposes a clean stream getter: `ValueStream get fillData => dataFetcher.stream;`;
- provides clean, intent-oriented methods with **named parameters** returning `Future<bool>`:
  - `fetch...()` for GET;
  - `post(...)` for mutations;
  - `delete...({int? id})` for deletions.
- routes success through `handleSuccessWithReturn(data)` and returns `true`;
- routes failure through `handleErrorWithReturn(error)` and returns `false`.

### Required Imports

```dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common_widgets/custom_toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';
```

### Example A: GET Rx Class (Fetching Data)

```dart
final class GetProfileRx extends RxResponseInt {
  final api = GetProfileApi.instance;

  String message = "Something went wrong";

  GetProfileRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> fetchProfile() async {
    try {
      Map resdata = await api.getProfile();
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"]?.toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
```

### Example B: POST / Mutation Rx Class with Named Parameters

```dart
final class PostLoginRx extends RxResponseInt {
  final api = PostLoginApi.instance;

  String message = "Something went wrong";

  PostLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> post({String? email, String? password}) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      Map resdata = await api.postLogin(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    appData.write(kKeyAccessToken, data["data"]["access_token"]);
    appData.write(kKeyRefreshToken, data["data"]["refresh_token"]);
    appData.write(kKeyIsLoggedIn, true);
    await performPostLoginActions();
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"]?.toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
```

### Example C: DELETE Rx Class with Toast on Success

```dart
final class DeleteSwapSummaryRx extends RxResponseInt {
  final api = DeleteSwapSummaryApi.instance;

  String message = "Something went wrong";

  DeleteSwapSummaryRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> deleteSwapSummary({int? id}) async {
    try {
      Map resdata = await api.deleteSwapSummary(id);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    message = data["message"] ?? "Item deleted successfully.";
    customToastMessage('Success', message);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"]?.toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
```

### Example D: Multipart / File Upload Rx Class

```dart
final class PostUpdateProfilePicRx extends RxResponseInt {
  final api = PostUpdateProfilePicApi.instance;

  String message = "Something went wrong";

  PostUpdateProfilePicRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> post({XFile? profilePicture}) async {
    try {
      MultipartFile? imageFile;
      if (profilePicture != null) {
        imageFile = await MultipartFile.fromFile(
          profilePicture.path,
          filename: profilePicture.name,
        );
      }

      Map<String, dynamic> data = {"profile_picture": imageFile};

      Map resdata = await api.postUpdateProfilePic(FormData.fromMap(data));
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"]?.toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
```

## Step 6 — Expose shared Rx object in `api_acess.dart`

Shared feature Rx instances are exposed globally from:

```text
lib/networks/api_acess.dart
```

Register the object using `BehaviorSubject<Map>()` and an empty map `{}`:

```dart
GetProfileRx getProfileRxObj = GetProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PostLoginRx postloginRxObj = PostLoginRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

DeleteSwapSummaryRx deleteSwapSummaryRxObj = DeleteSwapSummaryRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
```

Rules:
- Do not create multiple global instances of the same Rx class.
- Name the global instance in `camelCase` ending in `RxObj` (e.g., `getProfileRxObj`, `postloginRxObj`).

## Step 7 — Implement UI with Easy-to-Read Calling Patterns

Connect the UI to the Rx objects cleanly and concisely.

### Pattern 1: Data Fetching & StreamBuilder (GET Requests)

Fetch data in `initState()`, observe `fillData`, and deserialize using the model's `fromJson()`:

```dart
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    getProfileRxObj.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getProfileRxObj.fillData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: WaitingWidget());
          } else if (snapshot.hasData && snapshot.data != null && !snapshot.hasError) {
            final ProfileDataModel profileData =
                ProfileDataModel.fromJson(snapshot.data);
            return Column(
              children: [
                Text(profileData.data?.account?.fullName ?? ""),
                // ... other UI elements
              ],
            );
          } else {
            return const Center(child: Text("No profile data found"));
          }
        },
      ),
    );
  }
}
```

### Pattern 2: Form Submissions with `.waitingForFutureWithoutBg()` (POST/PUT Mutations)

Wrap future execution with the project's `.waitingForFutureWithoutBg()` extension. It manages the progress indicator automatically without manual dialog handling:

```dart
CustomButton(
  text: "Login",
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      postloginRxObj
          .post(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .waitingForFutureWithoutBg()
          .then((isSuccess) {
            if (isSuccess) {
              NavigationService.navigateToUntilReplacement(
                Routes.navigationScreen,
              );
            }
          });
    }
  },
)
```

### Pattern 3: Deletions & Refreshing Lists

Perform the delete action, then re-trigger list fetching upon success:

```dart
GestureDetector(
  onTap: () {
    deleteSwapSummaryRxObj
        .deleteSwapSummary(id: item?.id)
        .waitingForFutureWithoutBg()
        .then((isSuccess) {
          if (isSuccess) {
            getSummariesListRxObj.fetchSummaries(query: "all");
          }
        });
  },
  child: const Icon(Icons.delete),
)
```

### Pattern 4: Picking Images & Uploading Files

Pick the file, pass it directly to the Rx method, and refetch on completion:

```dart
GestureDetector(
  onTap: () async {
    XFile? image = await CustomImagePicker.pickImage(context);
    if (image != null) {
      postUpdateProfilePictureRxObj
          .post(profilePicture: image)
          .waitingForFutureWithoutBg()
          .then((isSuccess) {
            if (isSuccess) {
              getProfileRxObj.fetchProfile(); // Refetches to update UI
            }
          });
    }
  },
  child: CustomProfileImage(...),
)
```

## Step 8 — Add navigation if needed

Add route names to `Routes` and route construction to `RouteGenerator` in:

```text
helpers/all_routes.dart
```

Use `NavigationService` from normal feature code when moving between named
screens.

For route arguments, keep the argument contract explicit and stable.

Do not scatter literal route strings throughout UI code.

## Step 9 — Validate

At minimum, after modifications:

```bash
dart format <changed dart files>
flutter analyze
flutter test
```

If generation inputs changed, regenerate before analysis.

If the repository already has unrelated baseline warnings/tests failing, do not
silently alter unrelated code just to make a green command. Confirm whether the
failure existed before the change and report it distinctly.

---

# 5. Networking rules

## 5.1 One Dio owner

`DioSingleton` is the central Dio owner.

Never do this inside a feature:

```dart
final dio = Dio();
```

Use the existing wrappers:

```text
getHttp(...)
postHttp(...)
putHttp(...)
deleteHttp(...)
```

This preserves:

- base URL;
- timeouts;
- headers;
- logging;
- cancellation behavior;
- global interceptors;
- authenticated/unauthenticated client setup.

## 5.2 Authentication

The app starts with the unauthenticated Dio configuration and updates the client
with a bearer token after authenticated state is available.

Do not manually attach bearer tokens in random feature APIs.

When auth state changes, use the existing Dio update mechanism and storage keys.

## 5.3 Endpoints

Every reusable API path belongs in `networks/endpoints.dart`.

Never write:

```dart
getHttp('/api/v1/orders/42');
```

inside a screen or feature API when it can be represented by an endpoint helper.

## 5.4 Response status

Respect the backend contract. Existing APIs commonly accept `200` and `201` as
success.

Do not assume every request only succeeds with `200`.

For endpoints that legitimately use `204` or another success code, handle it
specifically rather than globally changing all APIs.

## 5.5 Exceptions

Do not swallow exceptions.

Bad:

```dart
try {
  ...
} catch (_) {
  return {};
}
```

unless an empty map is genuinely the domain meaning of failure.

Prefer rethrowing to the Rx/error layer.

## 5.6 WebSocket / Socket implementation rules

When a feature requires real-time bidirectional communication (e.g., live transcription, real-time chat, audio streaming, continuous status feeds), follow the established WebSocket architecture.

### 5.6.1 Architectural Flow for WebSockets

```text
Endpoint (`socketUrl` in networks/endpoints.dart)
    ↓
WebSocketService (lib/helpers/web_socket_service.dart)
    ↓ WebSocketChannel.connect(uri)
Incoming Event (JSON / bytes)
    ↓ rxObj.getVoiceData(data)
Rx class (RxResponseInt / BehaviorSubject sink)
    ↓ dataFetcher.sink.add(data)
StreamBuilder in UI (observing rxObj.fillData)
```

### 5.6.2 Centralize Socket URLs in `Endpoints`

All WebSocket URLs must live in `lib/networks/endpoints.dart`:

```dart
const String socketUrl = "wss://medscribeai.app/ws/stt/";

// Or for dynamic paths with parameters:
static String chatSocketUrl(String roomId) => "wss://example.com/ws/chat/$roomId/";
```

Never hardcode `wss://` strings inside screens or UI widgets.

### 5.6.3 Canonical `WebSocketService` Implementation

Location:
```text
lib/helpers/web_socket_service.dart
```

Use `package:web_socket_channel/web_socket_channel.dart` and `package:web_socket_channel/status.dart`:

```dart
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../networks/api_acess.dart';
import '../networks/endpoints.dart';

class WebSocketService {
  final Function()? onConnected;
  final Function()? onDisconnected;

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  WebSocketService({this.onConnected, this.onDisconnected});

  void connect() {
    if (_channel != null) {
      log("WebSocket already connected.");
      return;
    }

    final uri = Uri.parse(socketUrl);

    try {
      _channel = WebSocketChannel.connect(uri);

      _subscription = _channel!.stream.listen(
        (event) {
          log("Received socket event: $event");
          if (event != null && event.toString().isNotEmpty) {
            final data = json.decode(event);
            // Route parsed socket payload to the central Rx object
            getVoiceToTextRxObj.getVoiceData(data);
          }
        },
        onDone: () {
          log("WebSocket disconnected.");
          onDisconnected?.call();
          _subscription?.cancel();
          _subscription = null;
          _channel = null;
        },
        onError: (error) {
          log("WebSocket error: $error");
        },
        cancelOnError: true,
      );

      onConnected?.call();
    } catch (e) {
      log("WebSocket connect failed: $e");
    }
  }

  /// Sends text JSON or raw binary bytes (e.g. List<int> audio chunks)
  void sendMessage(dynamic message) {
    if (_channel != null) {
      _channel!.sink.add(message);
    }
  }

  void disconnect() {
    try {
      _subscription?.cancel();
      _subscription = null;
    } catch (_) {}

    _channel?.sink.close(status.normalClosure);
    _channel = null;
  }
}
```

### 5.6.4 Socket Rx Class Pattern

The Rx class exposes incoming socket events to the UI:

```dart
final class GetVoiceToTextRx extends RxResponseInt {
  GetVoiceToTextRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> getVoiceData(Map resData) async {
    try {
      return await handleSuccessWithReturn(resData);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    log(error.toString());
    return false;
  }
}
```

Register globally in `lib/networks/api_acess.dart`:

```dart
GetVoiceToTextRx getVoiceToTextRxObj = GetVoiceToTextRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
```

### 5.6.5 UI Integration and Lifecycle

In stateful screens (e.g., live streaming / voice input):

```dart
class LiveVoiceScreen extends StatefulWidget {
  const LiveVoiceScreen({super.key});

  @override
  State<LiveVoiceScreen> createState() => _LiveVoiceScreenState();
}

class _LiveVoiceScreenState extends State<LiveVoiceScreen> {
  late WebSocketService _socket;

  @override
  void initState() {
    super.initState();
    _socket = WebSocketService(
      onConnected: () => log("Socket Connected"),
      onDisconnected: () => log("Socket Disconnected"),
    );
    _socket.connect();
  }

  @override
  void dispose() {
    _socket.disconnect();
    getVoiceToTextRxObj.clean(); // Resets BehaviorSubject to initial empty state
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getVoiceToTextRxObj.fillData,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Waiting for live data..."));
          }
          final model = VoiceToTextRes.fromJson(snapshot.data);
          return Text(model.text ?? "");
        },
      ),
    );
  }
}
```

### 5.6.6 Strict Socket Rules

1. **Never initiate sockets inside `build()`**: Connect in `initState()` or on user action.
2. **Prevent duplicate connections**: Always check `if (_channel != null) return;` in `connect()`.
3. **Always disconnect in `dispose()`**: Cancel subscription and close the sink with `status.normalClosure`.
4. **Clean Rx state on screen exit**: Call `rxObj.clean()` in `dispose()` to prevent stale live data from persisting when the user returns.
5. **Support binary & text payloads**: Use `_channel.sink.add(bytes)` for audio/binary data and `_channel.sink.add(jsonString)` for JSON messages.

## 5.7 Social Authentication implementation (Google & Apple)

When social login/signup is required, follow the established pattern connecting `SocialAuthHelper` to the backend Rx layer.

### 5.7.1 Architectural Flow for Social Auth

```text
UI (Google / Apple Button tap)
    ↓
SocialAuthHelper (lib/helpers/social_auth.dart)
    ↓ Authenticates with Google/Apple SDK & Firebase
Returns (User user, String token) via onSuccess callback
    ↓
postSocialLoginRxObj.post(provider: "google"|"apple", accessToken: token)
    ↓ .waitingForFutureWithoutBg()
PostSocialLoginApi.instance.postSocialLogin(data)
    ↓ postHttp(Endpoints.socialLogin(), data)
Backend validates token & returns session access/refresh tokens
    ↓
postSocialLoginRxObj emits response:
    - writes kKeyAccessToken, kKeyRefreshToken, kKeyIsLoggedIn to appData
    - calls performPostLoginActions()
    - routes to NavigationScreen (or CompleteProfileScreen if account incomplete)
```

### 5.7.2 Canonical `SocialAuthHelper` (`lib/helpers/social_auth.dart`)

Location:
```text
lib/helpers/social_auth.dart
```

```dart
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'loading_helper.dart';

class SocialAuthHelper {
  static final _auth = FirebaseAuth.instance;
  static final _googleSignIn = GoogleSignIn.instance;

  /// Common success handler
  static Future<void> _handleLoginSuccess({
    required UserCredential? userCredential,
    required String token,
    required Future<void> Function(User user, String token)? onSuccess,
  }) async {
    if (userCredential == null) return;
    if (onSuccess != null) await onSuccess(userCredential.user!, token);
  }

  /// Google Sign-In
  static Future<UserCredential?> signInWithGoogle({
    required Future<void> Function(User user, String token)? onSuccess,
  }) async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.initialize(
        clientId: "<GOOGLE_CLIENT_ID>",
        serverClientId: "<GOOGLE_SERVER_CLIENT_ID>",
      );

      final authentication = await _googleSignIn.authenticate();
      final authIdToken = authentication.authentication;

      final auth = await authentication.authorizationClient.authorizeScopes([
        'email',
        'profile',
      ]);

      final credential = GoogleAuthProvider.credential(
        idToken: authIdToken.idToken,
        accessToken: auth.accessToken,
      );

      final userCredential = await _auth
          .signInWithCredential(credential)
          .waitingForFutureWithoutBg();

      await _handleLoginSuccess(
        userCredential: userCredential,
        token: credential.accessToken ?? '',
        onSuccess: onSuccess,
      );

      return userCredential;
    } catch (e) {
      debugPrint("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  /// Apple Sign-In
  static Future<UserCredential?> signInWithApple({
    required Future<void> Function(User user, String token)? onSuccess,
  }) async {
    try {
      final apple = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider("apple.com").credential(
        idToken: apple.identityToken,
        accessToken: apple.authorizationCode,
      );

      final userCredential = await _auth
          .signInWithCredential(credential)
          .waitingForFutureWithoutBg();

      await _handleLoginSuccess(
        userCredential: userCredential,
        token: apple.identityToken ?? '',
        onSuccess: onSuccess,
      );

      return userCredential;
    } catch (e) {
      debugPrint("❌ Apple Sign-In Error: $e");
      return null;
    }
  }
}
```

### 5.7.3 API & Rx Layer for Social Auth

#### Endpoint (`lib/networks/endpoints.dart`):
```dart
static String socialLogin() => "/api/auth/social-login/";
```

#### API Class (`features/auth/data/rx_post_social_login/api.dart`):
```dart
final class PostSocialLoginApi {
  static final PostSocialLoginApi _singleton = PostSocialLoginApi._internal();
  PostSocialLoginApi._internal();
  static PostSocialLoginApi get instance => _singleton;

  Future<Map> postSocialLogin(Map data) async {
    try {
      Response response = await postHttp(Endpoints.socialLogin(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(json.encode(response.data));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
```

#### Rx Class (`features/auth/data/rx_post_social_login/rx.dart`):
```dart
final class PostSocialLoginRx extends RxResponseInt {
  final api = PostSocialLoginApi.instance;

  PostSocialLoginRx({required super.empty, required super.dataFetcher});

  ValueStream get fillData => dataFetcher.stream;

  Future<bool> post({String? provider, String? accessToken}) async {
    try {
      Map<String, dynamic> data = {
        "provider": provider,
        "access_token": accessToken,
      };

      Map resdata = await api.postSocialLogin(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message =
          error.response?.data["message"]?.toString() ?? "Something went wrong";
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    customToastMessage('Error', message);
    return false;
  }
}
```

Registered in `lib/networks/api_acess.dart`:
```dart
PostSocialLoginRx postSocialLoginRxObj = PostSocialLoginRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
```

### 5.7.4 UI Screen Integration

In `login_screen.dart` or `signup_screen.dart`:

```dart
// Google Sign-In Button
GestureDetector(
  onTap: () {
    SocialAuthHelper.signInWithGoogle(
      onSuccess: (user, token) async {
        postSocialLoginRxObj
            .post(provider: "google", accessToken: token)
            .waitingForFutureWithoutBg()
            .then((success) {
              if (success) {
                final data = postSocialLoginRxObj.dataFetcher.value;
                appData.write(kKeyAccessToken, data["data"]["access_token"]);
                appData.write(kKeyRefreshToken, data["data"]["refresh_token"]);
                appData.write(kKeyEmail, data["data"]["user"]?["email"]);
                appData.write(kKeyIsLoggedIn, true);
                performPostLoginActions();

                if (data["data"]["is_account_info_completed"] == true) {
                  NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
                } else {
                  NavigationService.navigateToUntilReplacement(Routes.completeProfileScreen);
                }
              }
            });
      },
    );
  },
  child: SvgPicture.asset(Assets.icons.google),
)

// Apple Sign-In Button (iOS only)
if (Platform.isIOS)
  GestureDetector(
    onTap: () {
      SocialAuthHelper.signInWithApple(
        onSuccess: (user, token) async {
          postSocialLoginRxObj
              .post(provider: "apple", accessToken: token)
              .waitingForFutureWithoutBg()
              .then((success) {
                if (success) {
                  // Handle storage & navigation
                }
              });
        },
      );
    },
    child: SvgPicture.asset(Assets.icons.apple),
  )
```

### 5.7.5 Social Auth Rules
1. **Never skip backend verification:** Do not consider the user authenticated purely because Firebase/Google returned a token; the token must be sent to `Endpoints.socialLogin()` so the backend can issue application session tokens.
2. **Platform Visibility:** Display Apple Sign-In on iOS (as required by App Store Review Guidelines).
3. **Session Persistence:** Store tokens via `appData.write(kKeyAccessToken, ...)` and invoke `performPostLoginActions()` to update Dio headers immediately.

## 5.8 Auto-Logout and Force-Logout on Token Expiration (401 Unauthorized)

When an authenticated session expires, a token is revoked, or the server invalidates the user's credentials, API endpoints return `401 Unauthorized` (or in certain backend contracts, `403 Forbidden`). The application must automatically detect this condition globally, wipe all sensitive session data, reset the networking client, notify the user, and force navigation back to the login screen without crashing or entering infinite redirect loops.

### 5.8.1 Architectural Flow for Auto-Logout

```text
Any API Request (getHttp / postHttp / putHttp / deleteHttp)
    ↓
Backend returns HTTP 401 Unauthorized (or 403 Forbidden)
    ↓
Dio Interceptor (InterceptorsWrapper.onError in lib/networks/dio/dio.dart)
    ↓ _isGlobalError(error) detects status == 401
_handleGlobalError(error) → performForceLogout()
    ↓ Concurrency Guard: if (_isLoggingOut) return;
1. Clear session storage: appData.erase() (or reset auth keys)
2. Reset Dio client: DioSingleton.instance.create() (wipes Authorization header)
3. Disconnect real-time sockets: WebSocketService.instance.disconnect()
4. User notification: customToastMessage("Session Expired", "Please log in again.")
5. Redirect: NavigationService.navigateToUntilReplacement(Routes.logInScreen)
```

### 5.8.2 Canonical Interceptor Implementation in `DioSingleton`

Location:
```text
lib/networks/dio/dio.dart
```

In `DioSingleton`, intercept global errors and route `401 Unauthorized` directly to `performForceLogout()`. A static debounce lock (`_isLoggingOut`) prevents multiple concurrent API failures from flooding the user with duplicate toasts or competing route pushes:

```dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../common_widgets/custom_toast.dart';
import '../../constants/app_constants.dart';
import '../../helpers/di.dart';
import '../../helpers/navigation_service.dart';
import '../../helpers/all_routes.dart';
import '../endpoints.dart';
import 'log.dart';

final class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  static CancelToken cancelToken = CancelToken();
  DioSingleton._internal();

  static DioSingleton get instance => _singleton;

  late Dio dio;
  static bool _isLoggingOut = false;

  void create() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.APP_KEY: NetworkConstants.APP_KEY_VALUE,
      },
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(InterceptorsWrapper(
        onError: (error, handler) {
          if (_isGlobalError(error)) {
            _handleGlobalError(error);
            return handler.reject(error);
          }
          return handler.next(error);
        },
      ));
  }

  void update(String auth) {
    if (kDebugMode) {
      print("Dio update with auth token");
    }
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      headers: {
        NetworkConstants.ACCEPT: NetworkConstants.ACCEPT_TYPE,
        NetworkConstants.AUTHORIZATION: "Bearer $auth",
      },
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
    );

    dio = Dio(options)
      ..interceptors.add(Logger())
      ..interceptors.add(InterceptorsWrapper(
        onError: (error, handler) {
          if (_isGlobalError(error)) {
            _handleGlobalError(error);
            return handler.reject(error);
          }
          return handler.next(error);
        },
      ));
  }

  bool _isGlobalError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 401 ||
        error.response?.statusCode == 403 ||
        error.response?.statusCode == 500 ||
        error.response?.statusCode == 502 ||
        error.response?.statusCode == 503;
  }

  void _handleGlobalError(DioException error) {
    if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
      performForceLogout();
    }
  }

  /// Global Force Logout / Session Expiration Handler
  static void performForceLogout() {
    // Concurrency guard: prevents multiple concurrent requests from spamming toasts or navigations
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    // 1. Wipe local session & credentials
    appData.erase();

    // 2. Reset Dio client to unauthenticated state (drops Bearer token)
    DioSingleton.instance.create();

    // 3. Inform user
    customToastMessage("Session Expired", "Your session has expired. Please log in again.");

    // 4. Force navigation to login screen, clearing the entire backstack
    NavigationService.navigateToUntilReplacement(Routes.logInScreen);

    // Release debounce lock after navigation completes
    Future.delayed(const Duration(seconds: 2), () {
      _isLoggingOut = false;
    });
  }
}
```

### 5.8.3 Manual Logout vs Automatic Force Logout

There are two distinct logout flows in the template architecture:

| Concern | Manual User Logout | Automatic / Force Logout |
| :--- | :--- | :--- |
| **Trigger** | User explicitly taps "Logout" in Profile / Settings | Backend returns `401 Unauthorized` or `403 Forbidden` |
| **Backend API** | Calls `postLogoutRxObj.post(refreshToken: ...)` | Skipped (session is already invalid on server) |
| **Storage Action** | `appData.erase()` | `appData.erase()` |
| **Dio Reset** | `DioSingleton.instance.create()` | `DioSingleton.instance.create()` |
| **Navigation** | `NavigationService.navigateToUntilReplacement(Routes.logInScreen)` | `NavigationService.navigateToUntilReplacement(Routes.logInScreen)` |
| **User Feedback** | Screen transition | Toast: `"Your session has expired. Please log in again."` |

#### Manual Logout Implementation (e.g. `ProfileScreen`):
```dart
GestureDetector(
  onTap: () {
    postLogoutRxObj
        .post(refreshToken: appData.read(kKeyRefreshToken))
        .waitingForFutureWithoutBg()
        .then((success) {
          // Regardless of whether backend call succeeds or network dropped,
          // clear client state when user explicitly requested logout
          appData.erase();
          DioSingleton.instance.create();
          NavigationService.navigateToUntilReplacement(Routes.logInScreen);
        });
  },
  child: CustomButton(
    text: "Logout",
    // ...
  ),
)
```

### 5.8.4 Splash & Loading Screen Token Validation

In `lib/loading_screen.dart`, when the application launches:

```dart
Future<void> loadInitialData() async {
  await setInitValue();

  final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
  final String? token = appData.read(kKeyAccessToken);

  if (isLoggedIn && token != null && token.isNotEmpty) {
    // 1. Configure authenticated Dio instance
    DioSingleton.instance.update(token);
    try {
      // 2. Fetch initial user session / bootstrap data
      await performPostLoginActions();
      NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
    } catch (e) {
      // If post-login initialization fails with 401, the interceptor automatically triggers performForceLogout()
    }
  } else {
    // Unauthenticated user -> Login Screen
    NavigationService.navigateToUntilReplacement(Routes.logInScreen);
  }
}
```

### 5.8.5 Strict Rules for Auto-Logout & Session Invalidation

1. **Always Reset Dio to Unauthenticated (`DioSingleton.instance.create()`):**
   Never leave the old `Authorization: Bearer <token>` in the Dio instance after logout. If another user logs in or public requests are made, an outdated token must never leak into subsequent requests.

2. **Always Use `navigateToUntilReplacement` to Clear Backstack:**
   Never use `navigateTo()` or `pop()` for logout redirection. Always use `NavigationService.navigateToUntilReplacement(Routes.logInScreen)` or `Get.offAllNamed(Routes.logInScreen)` so the user cannot press the hardware back button or swipe back to view stale authenticated screens.

3. **Concurrency Lock (`_isLoggingOut`):**
   When multiple widgets or background futures trigger API calls simultaneously and the session expires, multiple calls may return 401 concurrently. The concurrency flag `_isLoggingOut` guarantees that only ONE toast is shown and ONE navigation event is executed.

4. **Wipe Persistent Storage via `appData.erase()`:**
   Do not leave user profile info, tokens, or personal cached responses in `GetStorage` when logging out.

5. **Disconnect Sockets on Logout:**
   If `WebSocketService` is active, ensure `WebSocketService.instance.disconnect()` is called on logout so open sockets do not leak data or reconnect in the background.

## 5.9 Post-Login Actions & Session Bootstrap (`performPostLoginActions`)

After any successful authentication—whether through traditional Email/Password login, OTP verification, Social Sign-In (Google/Apple), or app cold start auto-login—the application requires a centralized routine to bootstrap the authenticated session.

Instead of scattering token updates, FCM push notification registration, socket connection logic, and initial profile queries across individual screens or Rx classes, all post-login setup is centralized in:

```text
lib/helpers/post_login.dart
```

### 5.9.1 Architectural Flow for Post-Login Bootstrap

```text
Login / OTP / Social Auth / Splash Auto-Login Success
    ↓
Persist session credentials:
    - appData.write(kKeyAccessToken, token)
    - appData.write(kKeyRefreshToken, refreshToken)
    - appData.write(kKeyIsLoggedIn, true)
    ↓
Invoke performPostLoginActions() (lib/helpers/post_login.dart)
    ├── 1. Update Dio instance: DioSingleton.instance.update(token) (Attaches Authorization: Bearer <token>)
    ├── 2. Register / Sync FCM push notification token (if push notifications enabled)
    ├── 3. Pre-fetch essential bootstrap data (e.g. getProfileRxObj.fetchProfile())
    └── 4. Connect real-time services (e.g. WebSocketService.instance.connect() if authenticated)
    ↓
Navigate to destination screen (Routes.navigationScreen or Routes.completeProfileScreen)
```

### 5.9.2 Canonical `performPostLoginActions` Implementation

Location:
```text
lib/helpers/post_login.dart
```

```dart
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:medscribeai/constants/app_constants.dart';
import 'package:medscribeai/helpers/di.dart';
import 'package:medscribeai/networks/dio/dio.dart';
// import 'package:medscribeai/networks/api_acess.dart';
// import 'package:medscribeai/helpers/web_socket_service.dart';

Future<void> performPostLoginActions() async {
  try {
    // 1. Read stored access token from GetStorage
    final token = appData.read(kKeyAccessToken);

    if (token != null && token.toString().isNotEmpty) {
      // 2. Reconfigure Dio client with the authenticated Bearer token
      DioSingleton.instance.update(token.toString());
      log("Dio configured with authenticated bearer token.");

      // 3. Optional: Sync FCM device push token with backend
      // final fcmToken = appData.read(kKeyFCMToken);
      // if (fcmToken != null) {
      //   postFcmTokenRxObj.post(deviceToken: fcmToken);
      // }

      // 4. Optional: Pre-fetch essential user profile into global Rx stream
      // getProfileRxObj.fetchProfile();

      // 5. Optional: Connect authenticated WebSocket
      // WebSocketService.instance.connect();
    }
  } catch (e) {
    log("Error during performPostLoginActions: $e");
    // Non-critical background bootstrap errors must not crash or block the login flow
  }
}
```

### 5.9.3 Invocation Locations (Where to Call `performPostLoginActions`)

`performPostLoginActions()` is invoked in exactly 4 scenarios:

#### 1. In `PostLoginRx.handleSuccessWithReturn` (Email/Password Login)
```dart
@override
handleSuccessWithReturn(data) async {
  appData.write(kKeyAccessToken, data["data"]["access_token"]);
  appData.write(kKeyRefreshToken, data["data"]["refresh_token"]);
  appData.write(kKeyIsLoggedIn, true);

  // Bootstrap authenticated state
  await performPostLoginActions();

  dataFetcher.sink.add(data);
  return true;
}
```

#### 2. In `PostOtpVerifyRx.handleSuccessWithReturn` (OTP Login / Verification)
```dart
@override
handleSuccessWithReturn(data) async {
  appData.write(kKeyAccessToken, data["access_token"]);
  appData.write(kKeyRefreshToken, data["refresh_token"]);
  appData.write(kKeyIsLoggedIn, true);

  // Bootstrap authenticated state
  await performPostLoginActions();

  dataFetcher.sink.add(data);
  return true;
}
```

#### 3. In Social Sign-In Callback (Google / Apple Login in UI)
```dart
SocialAuthHelper.signInWithGoogle(
  onSuccess: (user, token) async {
    postSocialLoginRxObj
        .post(provider: "google", accessToken: token)
        .waitingForFutureWithoutBg()
        .then((success) async {
          if (success) {
            final data = postSocialLoginRxObj.dataFetcher.value;
            appData.write(kKeyAccessToken, data["data"]["access_token"]);
            appData.write(kKeyRefreshToken, data["data"]["refresh_token"]);
            appData.write(kKeyEmail, data["data"]["user"]?["email"]);
            appData.write(kKeyIsLoggedIn, true);

            // Bootstrap authenticated state
            await performPostLoginActions();

            if (data["data"]["is_account_info_completed"] == true) {
              NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
            } else {
              NavigationService.navigateToUntilReplacement(Routes.completeProfileScreen);
            }
          }
        });
  },
);
```

#### 4. In `LoadingScreen.loadInitialData` (Cold App Launch / Auto-Login)
```dart
Future<void> loadInitialData() async {
  await setInitValue();

  final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
  final String? token = appData.read(kKeyAccessToken);

  if (isLoggedIn && token != null && token.isNotEmpty) {
    // Configure authenticated session and fetch fresh bootstrap data
    DioSingleton.instance.update(token);
    await performPostLoginActions();
    NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
  } else {
    // Unauthenticated user -> Login Screen
    NavigationService.navigateToUntilReplacement(Routes.logInScreen);
  }
}
```

### 5.9.4 Strict Rules for `performPostLoginActions`

1. **Centralize All Post-Login Initialization:**
   Never write raw `DioSingleton.instance.update(token)` or duplicate bootstrap logic scattered across individual UI widgets or feature buttons. Always invoke `performPostLoginActions()`.

2. **Always Return `Future<void>`:**
   Allows callers that require pre-fetched bootstrap data before navigation (such as the splash/loading screen) to await completion safely.

3. **Defensive Error Handling:**
   All secondary tasks inside `performPostLoginActions()` (such as FCM token registration, profile pre-fetching, or socket connections) must be wrapped in `try/catch` blocks so that a temporary peripheral failure never blocks the user from reaching the application’s main screens.

4. **Pair with Auto-Logout Cleanliness:**
   Everything configured in `performPostLoginActions()` (Dio update, sockets, subscriptions) must have a corresponding teardown in `performForceLogout()` / manual logout (`DioSingleton.instance.create()`, `WebSocketService.instance.disconnect()`, `appData.erase()`).

---

# 6. Error handling

Use the existing centralized mechanisms:

```text
helpers/error_message_Handler.dart
networks/rx_base.dart
networks/exception_handler/
common_widgets/custom_toast.dart
```

`ErrorMessageHandler` already interprets common Dio/network/status/server error
shapes.

Rules:

- do not duplicate generic status-code-to-message maps inside a feature;
- do not expose raw exception strings to users unless explicitly intended;
- keep debug logging separate from user-facing messages;
- show one error notification for one failed action;
- use visual error-state widgets for screen-level failures;
- use toast/snackbar-style feedback for action-level failures where appropriate.

When an endpoint has a domain-specific validation message from the server,
preserve that meaningful server message if the central handler already extracts
it.

---

# 7. Loading rules

For full-screen reactive loading, prefer the existing waiting/loading widgets.

For an action that needs a blocking loader around a `Future`, check
`helpers/loading_helper.dart` and use the existing `.waitingForFutureWithoutBg()`
extension when its behavior matches the requirement.

Do not create a new modal-spinner helper for every feature.

Never leave a loader open if the future throws. Use the established helper or a
`try/finally` equivalent when special behavior is required.

---

# 8. Navigation rules

Navigation infrastructure:

```text
helpers/all_routes.dart
helpers/navigation_service.dart
```

Use named routes already defined in `Routes`.

Preferred feature-level usage:

```dart
NavigationService.navigateTo(Routes.someScreen);
```

or the established argument helper when arguments are needed.

Use local `Navigator.pop`/back behavior only where appropriate for a local route
stack action and consistent with nearby code.

Do not:

- hardcode route strings;
- introduce `go_router`, GetX navigation, AutoRoute, or another router without
  an explicit architecture migration;
- bypass `RouteGenerator` for ordinary named screens;
- assume route arguments exist without null/type checks at the route boundary.

The route generator intentionally varies page transition style by platform. Keep
that behavior unless the task explicitly changes navigation UX.

---

# 9. Dependency injection and app-wide services

App-wide service setup lives in:

```text
helpers/di.dart
```

The current DI container is GetIt.

Rules:

- use the existing global `locator` for services registered there;
- use the established shared `GetStorage` instance (`appData`) rather than
  creating new storage instances throughout new code;
- register app-wide services in `diSetup()`;
- do not introduce a second service locator;
- do not introduce Provider/Riverpod/GetX just to access a singleton;
- feature-local objects that do not need global lifetime can remain local.

Keep initialization order compatible with `main.dart`:

1. Flutter binding;
2. GetStorage initialization;
3. DI setup;
4. Dio setup;
5. app launch.

Do not make a service usable before its initialization contract is satisfied.

---

# 10. Centralized constants and persistent storage keys (`app_constants.dart`)

All shared application constants, storage keys, and regular expressions live exclusively in:

```text
lib/constants/app_constants.dart
```

Never scatter literal key strings (e.g., `'access_token'`, `'is_logged_in'`, `'user_id'`) through screens, Rx classes, or networking helpers.

## 10.1 Key naming convention (`kKey<Name>`)

All keys used for persistent storage (`GetStorage` / `appData`) and app-wide state identifiers follow the canonical `kKey...` prefix in `lowerCamelCase`, mapping to a stable `snake_case` string:

```dart
// Authentication & Session Keys
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kKeyRefreshToken = 'refresh_token';
const String kKeyTempToken = 'temp_token';
const String kKeyResetPasswordToken = 'reset_password_token';

// User & Profile Keys
const String kKeyUserID = 'user_id';
const String kKeyEmail = 'email_address';
const String kKeyFullName = 'full_name';
const String kKeyProfileImage = 'profile_image';
const String kKeyDesignation = 'designation';
const String kKeyLicenseNo = 'license_no';
const String kKeyOrganization = 'organization';

// Device & Push Notifications
const String kKeyDeviceToken = 'device_token';
const String kKeyDeviceID = 'device_id';
const String kKeyFCMToken = 'firebase_token';

// App Settings & Preferences
const String kKeyfirstTime = "first";
const String kKeySelectedLocation = 'selected_location';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'country_code';
```

## 10.2 Centralized Regular Expressions (`AppRegExpText`)

Regex patterns used for validation (e.g., in `validator.dart`) must also be centralized in `app_constants.dart`:

```dart
final class AppRegExpText {
  AppRegExpText._();

  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static String kRegExpPhone =
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
      "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}
```

## 10.3 Reading and writing via `appData` (GetStorage)

The project initializes a global `GetStorage` singleton named `appData` (configured in `helpers/di.dart`). Always use `appData` paired with `kKey...` constants:

### Writing data (e.g., in login Rx or profile Rx):
```dart
appData.write(kKeyAccessToken, data["data"]["access_token"]);
appData.write(kKeyRefreshToken, data["data"]["refresh_token"]);
appData.write(kKeyIsLoggedIn, true);
appData.write(kKeyEmail, data["data"]["user"]["email"]);
```

### Reading data:
```dart
final String? token = appData.read(kKeyAccessToken);
final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
final String? userEmail = appData.read(kKeyEmail);
```

### Clearing data on Logout:
```dart
// Erases all persistent keys cleanly upon logout
appData.erase();
```

## 10.4 Strict rules for agents

1. **Zero Raw String Keys:**
   - **Never write:** `appData.write('access_token', token)` or `appData.read('is_logged_in')`.
   - **Always write:** `appData.write(kKeyAccessToken, token)` or `appData.read(kKeyIsLoggedIn)`.

2. **Never change existing key values casually:**
   - Even if an existing key string contains a historical typo (e.g., `'lst_name'` or `'selected_lot'`), **never** alter the string literal during feature work. Altering the string causes existing app installations to lose saved user data!

3. **Adding a new key:**
   - When a feature requires persisting a new value (e.g., `user_role`, `has_completed_onboarding`):
     1. Open `lib/constants/app_constants.dart`.
     2. Add the constant with the `kKey` prefix: `const String kKeyHasCompletedOnboarding = 'has_completed_onboarding';`.
     3. Import and use the constant across the feature.

---

# 11. Assets and images — strict rules

This section is non-negotiable because asset mistakes are easy to introduce.

## 11.1 Generated files are read-only

Never manually edit:

```text
lib/gen/assets.gen.dart
lib/gen/colors.gen.dart
lib/gen/fonts.gen.dart
```

These are generated by FlutterGen.

If generated output is wrong, change its source configuration/input and
regenerate.

## 11.2 Asset locations

Use the existing directories:

```text
assets/icons/
assets/images/
assets/lottie/
assets/fonts/
assets/color/colors.xml
```

Do not create arbitrary duplicates such as:

```text
assets/img/
assets/pictures/
assets/svg_icons/
```

unless the project is intentionally expanding its asset strategy.

## 11.3 Local raster images

Use FlutterGen references.

Preferred examples:

```dart
Assets.images.placeholderImage.path
Assets.images.errorImage.path
```

When convenient, the generated `AssetGenImage` also supports direct image
creation.

Do **not** hardcode:

```dart
Image.asset('assets/images/placeholder_image.jpeg')
```

when the asset is available in `Assets`.

## 11.4 Icons from assets

Use generated references such as:

```dart
Assets.icons.notificationIcon.path
```

Do not duplicate the same icon under multiple file names just to access it from
a different feature.

Material `Icons.*` are fine when the design calls for a standard Material icon.

## 11.5 Lottie/dotlottie

Use generated paths from:

```dart
Assets.lottie.<name>
```

The repository contains both `.json` Lottie files and `.lottie` assets.

Use the already configured animation package/helper appropriate to that format.

Do not type asset path strings manually.

## 11.6 Network images

Use:

```text
common_widgets/app_network_image.dart
```

and the `AppNetworkImage` widget for ordinary remote images.

Do not use `Image.network` for normal feature UI when `AppNetworkImage` handles
the same need.

Do not instantiate `CachedNetworkImage` directly in every screen unless the
requested behavior cannot be expressed by `AppNetworkImage`. If a missing
behavior is broadly useful, enhance `AppNetworkImage` once instead.

This preserves caching, placeholders, error behavior, sizing conventions, and
visual consistency.

## 11.7 Adding a new asset

When adding an image/icon/Lottie asset:

1. place it in the correct existing asset folder;
2. use a descriptive `snake_case` filename;
3. ensure the folder is covered by `pubspec.yaml`;
4. regenerate FlutterGen;
5. reference the generated symbol;
6. do not hand-edit the generated Dart file.

The project already registers the `icons`, `lottie`, and `images` directories in
`pubspec.yaml`.

Typical regeneration command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

If the project's local toolchain uses the modern equivalent, it is acceptable
to run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Use the command compatible with the installed Flutter/Dart toolchain; do not
change project configuration merely to prefer one command spelling.

---

# 12. Color rules

Source colors live in:

```text
assets/color/colors.xml
```

FlutterGen generates:

```text
lib/gen/colors.gen.dart
```

Use:

```dart
AppColors.<colorName>
```

instead of repeatedly creating raw color literals.

Bad for reusable design colors:

```dart
const Color(0xFFFF3A1222)
Colors.green
```

when an equivalent project color already exists.

A one-off framework color may be acceptable when semantically intentional, but
first check `AppColors`.

To add a brand/design-system color:

1. add it to `assets/color/colors.xml`;
2. name it consistently;
3. regenerate FlutterGen;
4. use the generated `AppColors` value.

Never hand-edit `colors.gen.dart`.

---

# 13. Typography rules

Typography is centralized. Agents must treat this as a design-system rule, not
as an optional convenience.

## 13.1 Source of truth

All application text styles live in:

```text
lib/constants/text_font_style.dart
```

**Font Requirement Flexibility:**
Every project has different font requirements based on its brand and design specifications (e.g., `Poppins`, `Inter`, `Outfit`, `Plus Jakarta Sans`, etc.).
`DMSans` and `Open Sans` are base template / fallback fonts.

When working in a project:
1. Inspect `lib/constants/text_font_style.dart` and `pubspec.yaml` to identify the project's active design font family.
2. If the project uses `GoogleFonts` (e.g., `GoogleFonts.poppins(...)`), follow that pattern in `TextFontStyle`.
3. If the project uses asset-declared fonts, use the project's primary font with `DMSans` and `Open Sans` in the fallback list (`fontFamilyFallback`).
4. For normal application UI, **never create `TextStyle(...)` or `GoogleFonts.*(...)` directly inside a screen or widget**. Always define and resolve the style through `TextFontStyle`.

## 13.2 Existing naming convention is mandatory

The established style name encodes the visual token:

```text
textStyle<size>c<HEX><FontFamily><weight>
```

Where `<FontFamily>` matches the font used in the project (e.g., `Poppins`, `Inter`, `DMSans`).

Examples:

```dart
TextFontStyle.textStyle20c333333Poppins600
```

means:

```text
fontSize   = 20.sp
color      = AppColors.c333333
fontFamily = Poppins
fontWeight = FontWeight.w600
```

Another example:

```dart
TextFontStyle.textStyle14c606060DMSans400
```

means:

```text
fontSize   = 14.sp
color      = AppColors.c606060
fontFamily = DMSans (or project fallback)
fontWeight = FontWeight.w400
```

When adding a new style, preserve this exact naming model. Do not introduce
semantic names such as these unless the repository is deliberately migrated to
a new typography system:

```dart
headingLarge
bodyMedium
primaryTitle
smallGreyText
```

The codebase already contains a small number of legacy/inconsistent style names.
Do not rename them as part of unrelated work. New code should follow the dominant
`textStyle<size>c<HEX><FontFamily><weight>` convention.

## 13.3 How to choose a text style

Before styling any `Text`, `RichText`, `TextSpan`, label, button title, field
text, empty state, dialog copy, or similar UI text, follow this order:

1. Determine the required font size from the design.
2. Determine the required project color and find its `AppColors` token.
3. Determine the required font family according to project design requirements (with `DMSans` and `Open Sans` as fallbacks).
4. Determine the font weight.
5. Search `TextFontStyle` for the exact combination.
6. If the exact style exists, reuse it directly.
7. If the exact visual token does not exist and it is a real design style, add
   it to `TextFontStyle` using the repository naming convention.
8. Use `copyWith` only for a genuinely contextual/runtime variation of an
   existing token, not as a shortcut for avoiding the shared style file.

### Correct: exact existing token

```dart
Text(
  'Welcome Back',
  style: TextFontStyle.textStyle24c333333Poppins600,
)
```

### Correct: another exact existing token

```dart
Text(
  'Please sign in to your account',
  style: TextFontStyle.textStyle14c898989Poppins400,
  textAlign: TextAlign.center,
)
```

### Wrong: rebuilding an existing token inline

```dart
Text(
  'Welcome Back',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.c333333,
  ),
)
```

### Wrong: calling GoogleFonts inline in a widget

```dart
Text(
  'Welcome Back',
  style: GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.c333333,
  ),
)
```
*(All `GoogleFonts` or `TextStyle` definitions belong exclusively inside `TextFontStyle`).*

## 13.4 When `copyWith` is allowed

`copyWith` is allowed when the underlying typography token is still the same and
only a context-dependent property changes.

Examples include:

- selected vs unselected state;
- enabled vs disabled state;
- temporary opacity/color driven by state;
- text decoration for a specific interactive state;
- a runtime property that cannot reasonably be represented as a fixed shared
  token.

Example:

```dart
Text(
  title,
  style: TextFontStyle.textStyle14c333333Poppins500.copyWith(
    color: isSelected ? AppColors.c4DB43F : AppColors.c898989,
  ),
)
```

Do **not** use `copyWith` merely because the required fixed design style is
missing:

```dart
// Avoid this when 18 / c333333 / Poppins / 600 is a real fixed design token.
TextFontStyle.textStyle14c333333Poppins500.copyWith(
  fontSize: 18.sp,
)
```

If the design actually requires `18sp`, `c333333`, `Poppins`, `w600`, use or add:

```dart
TextFontStyle.textStyle18c333333Poppins600
```

This keeps the visual system searchable and prevents style drift.

## 13.5 How to add a missing style

If the exact required token does not exist, add it to
`lib/constants/text_font_style.dart`.

### Pattern A: If the project uses GoogleFonts (e.g. Poppins, Inter, etc.)

```dart
static final textStyle16c4DB43FPoppins500 = GoogleFonts.poppins(
  color: AppColors.c4DB43F,
  fontSize: 16.sp,
  fontWeight: FontWeight.w500,
);
```

### Pattern B: If the project uses asset-declared fonts (with DMSans and Open Sans fallbacks)

```dart
static final textStyle18c202020DMSans600 = TextStyle(
  fontFamily: 'DMSans',
  fontFamilyFallback: const [
    'Open Sans',
    'Roboto',
    'Noto Sans',
  ],
  color: AppColors.c202020,
  fontSize: 18.sp,
  fontWeight: FontWeight.w600,
);
```

Rules for new definitions:

- `static final` follows the existing implementation;
- font size must use `.sp`;
- color must come from `AppColors` when it is a product/design color;
- the color portion of the style name must match the `AppColors` token;
- the font family in the token name must match the project's designated font (`Poppins`, `Inter`, `DMSans`, etc.);
- `DMSans` and `Open Sans` are fallback fonts;
- weight in the name must match the actual `FontWeight` exactly;
- do not duplicate an identical style under a second name;
- do not add a new style before searching the existing class;
- do not hand-edit generated color files to support the style.

### Name construction examples

| Design requirement | Required style name |
|---|---|
| 12sp, `c898989`, Poppins, 400 | `textStyle12c898989Poppins400` |
| 16sp, `c333333`, Poppins, 500 | `textStyle16c333333Poppins500` |
| 18sp, `c115DFB`, Poppins, 500 | `textStyle18c115DFBPoppins500` |
| 14sp, `c606060`, DMSans, 400 | `textStyle14c606060DMSans400` |
| 20sp, `cFFFFFF`, Poppins, 500 | `textStyle20cFFFFFFPoppins500` |

The encoded color value is the project color token without `#` or `0x`.

## 13.6 Color changes required by a new text style

If the design needs a color that does not yet exist:

1. check `AppColors` first;
2. check `assets/color/colors.xml`;
3. if it is a real reusable product/design color, add it to `colors.xml`;
4. regenerate FlutterGen;
5. use the generated `AppColors` token in `TextFontStyle`;
6. never manually edit `lib/gen/colors.gen.dart`.

Do not hide a missing design token by putting a raw `Color(0xFF...)` in a
feature screen.

## 13.7 Rich text and spans

The same rule applies to `TextSpan` and `RichText`.

Correct:

```dart
RichText(
  text: TextSpan(
    text: 'Already have an account? ',
    style: TextFontStyle.textStyle14c898989Poppins400,
    children: [
      TextSpan(
        text: 'Sign In',
        style: TextFontStyle.textStyle14c4DB43FPoppins500,
      ),
    ],
  ),
)
```

Avoid embedding new inline `TextStyle` or `GoogleFonts` objects inside spans when the same token
belongs in `TextFontStyle`.

Before writing a custom `RichText`, also inspect existing common widgets such as
the repository's rich-text button and reuse them when the interaction/design
matches.

## 13.8 Buttons, fields, app bars, and reusable widgets

Typography inside reusable controls should remain centralized too.

Before styling text in a feature screen:

- check whether `custom_button.dart` already owns the button typography;
- check whether `custom_textform_field.dart` already owns hint/label/input
  typography;
- check `custom_appbar.dart` before implementing title typography locally;
- check the other `common_widgets/` components before duplicating their text
  behavior.

A feature screen should not override a shared widget's typography just to make
one instance visually different unless that variation is part of the intended
component API.

If a shared component genuinely needs multiple typography variants, extend its
API deliberately and pass/resolve `TextFontStyle` tokens rather than scattering
inline styles at call sites.

## 13.9 ScreenUtil is mandatory for font sizes

All fixed design font sizes in `TextFontStyle` must use `.sp`:

```dart
fontSize: 16.sp,
```

Not:

```dart
fontSize: 16,
```

Do not apply `.sp` again at the usage site. A `TextFontStyle` token is already
responsive.

## 13.10 What agents must not do

Do not:

```dart
style: const TextStyle(...)
```
or inline `GoogleFonts.*(...)` in screens or widgets for normal product UI.

Do not create feature-local typography constants such as:

```dart
const titleStyle = TextStyle(...);
```

Do not create another typography class such as:

```dart
AppTextStyles
TypographyStyles
MyTextTheme
```

Do not hardcode raw color values in a screen just for text.

Do not use arbitrary font weights that conflict with the design.

Do not change existing global styles to make one new screen look correct if that
change would alter existing screens. Add the required token instead.

Do not rename existing text-style fields during unrelated feature work.
Compatibility and minimal diffs take priority.

## 13.11 Typography implementation checklist

Before considering UI text complete, verify:

- [ ] Every product-facing text element uses `TextFontStyle` directly or a
      shared widget that internally uses it.
- [ ] The project's active font family was checked (with DMSans and Open Sans serving as fallbacks).
- [ ] The exact existing style was searched before creating another one.
- [ ] New style names encode size + color + family + weight correctly.
- [ ] Font sizes use `.sp`.
- [ ] Product colors use `AppColors`.
- [ ] `copyWith` is used only for contextual variation.
- [ ] No duplicate inline `TextStyle` or `GoogleFonts` was introduced in widgets.
- [ ] Shared controls keep ownership of their internal typography where
      appropriate.
- [ ] Existing styles were not globally changed to solve a local design need.

---

# 14. Responsive UI rules

The app initializes ScreenUtil with a reference design size of approximately:

```text
375 × 812
```

Use ScreenUtil consistently:

```dart
16.w
12.h
14.sp
8.r
```

General convention:

- horizontal dimensions/padding: `.w`;
- vertical dimensions/padding: `.h`;
- font/icon size: `.sp` where appropriate;
- corner radius: `.r`;
- design-size-specific containers: apply the axis that reflects the intended
  dimension.

Do not convert every mathematical constant mechanically. Values that are
logical/non-visual (IDs, counts, API pagination, opacity, flex factors, aspect
ratios when intentionally dimensionless) should remain plain numbers.

The project also provides `UIHelper` for standard spacing/padding.

Before writing another repeated `SizedBox`, check whether `UIHelper` already
expresses the spacing clearly.

Keep layout readable. Do not nest unnecessary `Container` widgets solely to
match an AI-generated pattern.

---

# 15. Common widget reuse & button design strategy

Before creating any UI widget, inspect `common_widgets/`.

Existing reusable components include:

- `AppNetworkImage`
- `CustomAppBar`
- `CustomButton`
- rich/text buttons
- `CustomTextFormField`
- toast/snackbar helper (`customToastMessage`)
- loading indicators (`loadingIndicatorCircle`)
- `NoDataWidget`
- `NotFoundWidget`
- `WaitingWidget`

## 15.1 Analyzing UI screenshots for reusable buttons

When an agent receives UI screenshots, mockups, or Figma designs:

1. **Cross-Screen Visual Audit**:
   - Compare all available screenshots side by side before writing a single widget.
   - Specifically check if buttons share the same base structure (e.g., solid background, 12.r border radius, centered text, full-width or fixed width).
   - In most apps, buttons appearing in Login, Sign Up, OTP Verification, Profile Update, Settings, and Bottom Sheets are the **same reusable button** styled with consistent primary or secondary themes.

2. **Never duplicate button implementations**:
   - **Do not** write raw `ElevatedButton`, `FilledButton`, `TextButton`, or custom `GestureDetector(child: Container(...))` inside individual feature screens.
   - **Do not** create screen-specific button classes such as `LoginButton`, `OtpButton`, or `NextButton`.
   - **Always** use or adapt `lib/common_widgets/custom_button.dart`.

3. **Handle visual variants through parameters, not new classes**:
   - Solid / Primary Button: Default `backgroundColor` (e.g. `AppColors.allPrimaryColor`) and white text.
   - Secondary / Outlined Button: White `backgroundColor` with `borderColor` and colored text.
   - Compact / Custom Padding: Pass optional `width`, `height`, `verticalPadding`, or `radius`.

## 15.2 Anatomy of `CustomButton` in `common_widgets/custom_button.dart`

The project's standard `CustomButton` is designed to be universally configurable while maintaining design-system defaults:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';
import '../gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final double verticalPadding;
  final double? width;
  final String? logoAsset;
  final VoidCallback? onPressed;
  final IconData? iconData;
  final Color? iconColor;
  final double? height;
  final double? radius;
  final TextStyle? style;

  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.logoAsset,
    required this.onPressed,
    this.iconData,
    this.borderColor,
    this.radius,
    this.iconColor,
    this.verticalPadding = 16,
    this.height,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: verticalPadding.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(radius ?? 12.r),
          border: Border.all(
            color: borderColor ?? backgroundColor ?? AppColors.allPrimaryColor,
            width: 1.w,
          ),
        ),
        child: Text(
          text,
          style: style ??
              (textColor != null
                  ? TextFontStyle.textStyle18cFFFFFFPoppins500.copyWith(
                      color: textColor,
                    )
                  : TextFontStyle.textStyle18cFFFFFFPoppins500),
        ),
      ),
    );
  }
}
```

## 15.3 How to use `CustomButton` across multiple screens

### Pattern A: Standard Primary Action (Full-Width Solid Button)
Used for Login, Sign Up, Next, Save, Submit, Generate:

```dart
CustomButton(
  text: "Login",
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      postloginRxObj
          .post(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .waitingForFutureWithoutBg()
          .then((isSuccess) {
            if (isSuccess) {
              NavigationService.navigateToUntilReplacement(Routes.navigationScreen);
            }
          });
    }
  },
)
```

### Pattern B: Secondary / Outlined Button Variant
Used for Cancel, Back, or secondary actions:

```dart
CustomButton(
  text: "Cancel",
  backgroundColor: AppColors.cFFFFFF,
  borderColor: AppColors.allPrimaryColor,
  textColor: AppColors.allPrimaryColor,
  onPressed: () {
    NavigationService.goBack;
  },
)
```

### Pattern C: Custom Sized or Rounded Button
Used in dialogs, cards, or specific narrow rows:

```dart
CustomButton(
  text: "Next",
  width: 160.w,
  verticalPadding: 12,
  radius: 8.r,
  onPressed: () {
    NavigationService.navigateTo(Routes.nextScreen);
  },
)
```

## 15.4 Rules for other shared widgets

- use an existing shared widget when its behavior matches;
- extend a shared widget when the improvement is truly reusable and backwards
  compatible;
- do not modify a shared widget for one screen in a way that changes every
  caller unexpectedly;
- add optional parameters with safe defaults for reusable enhancements;
- keep feature-specific widgets inside that feature's `presentation/widget/`
  folder;
- move a widget to `common_widgets/` only after it has genuine cross-feature
  value.

A duplicated 10-line visual fragment in one screen is not automatically a new
shared component. Extract when it improves clarity or reuse.

---

# 16. Forms and validation

Use:

```text
common_widgets/custom_textform_field.dart
constants/validator.dart
```

before creating new field/validator implementations.

Rules:

- own `TextEditingController`s in a stateful widget when needed;
- dispose controllers in `dispose()`;
- use a `GlobalKey<FormState>` for form validation where appropriate;
- validate before firing network requests;
- avoid validating the same rule both in the widget and a second local helper;
- add a new validator centrally if it is broadly reusable.

Password visibility and common input decoration should be implemented through
or consistently with the project's custom form-field component.

---

# 17. Screen and widget state rules

Use `StatelessWidget` when the widget owns no mutable lifecycle state.

Use `StatefulWidget` when it needs:

- controller ownership;
- lifecycle-driven fetches;
- transient local UI state;
- subscriptions/resources requiring disposal.

Do not convert a screen to `StatefulWidget` without a reason.

Do not place API calls directly inside `build()`.

Initial network loading normally belongs in `initState()`.

Avoid calling `setState()` after an awaited operation without checking whether
that widget still exists when the code path can outlive the screen.

Do not put global application state into arbitrary stateful screens when the Rx
layer already owns it.

---

# 18. RxDart conventions

Current reactive foundation:

```text
RxDart
BehaviorSubject
RxResponseInt
```

When working in existing Rx features:

- expose a read-oriented stream getter;
- keep the subject owned by the reactive layer/shared access point;
- reset with the existing empty-state mechanism when necessary;
- avoid emitting contradictory loading/data/error states;
- do not subscribe manually in UI when a `StreamBuilder` is sufficient;
- close locally owned subjects when their lifetime ends;
- do not dispose globally shared subjects from an individual screen.

If a feature uses the global instances in `api_acess.dart`, the screen does not
own that subject's lifetime.

Do not introduce BLoC, Cubit, Provider, Riverpod, ChangeNotifier, or GetX for a
single feature unless the project is intentionally migrating architecture.

---

# 19. Naming conventions

Follow established semantic names.

## API classes

```text
GetProductsApi
GetProfileApi
PostLoginApi
```

Pattern:

```text
<Verb><Resource>Api
```

## Rx classes

```text
GetProductsRx
GetProfileRx
PostLoginRx
```

Pattern:

```text
<Verb><Resource>Rx
```

## Screens

```text
LoginScreen
ProductsScreen
ProductDetailsScreen
ProfileScreen
```

Pattern:

```text
<FeatureOrAction>Screen
```

## Models

Prefer clear domain/result names such as:

```text
ProductModel
ProductsResponse
ProfileResModel
User
```

Do not use vague names such as:

```text
DataModel2
ApiModel
ResultThing
MyObject
```

## Files

Use `snake_case.dart`.

Match the surrounding repository's directory names even if one historical name
contains a typo. New file names should be correctly spelled unless consistency
with a fixed external/public contract demands otherwise.

---

# 20. Imports

Keep imports minimal and remove unused imports from changed files.

The repository contains a mixture of relative and package imports. Do not run a
mass import-style migration during feature work.

Within a changed module:

- follow the dominant nearby style;
- keep Flutter/Dart/package imports logically readable;
- avoid importing internal implementation files from unrelated features when a
  shared helper/model is the proper dependency;
- never import generated asset files through handwritten duplicate wrappers
  unless that wrapper is already part of the architecture.

Run formatter/analyzer after edits.

---

# 21. Humanized coding standard

"Humanized" means code should feel intentional, practical, and maintainable—not
machine-generated, over-explained, or artificially abstract.

## 21.1 Prefer obvious code

Good:

```dart
final products = data.products ?? [];
if (products.isEmpty) {
  return const NoDataWidget(
    title: 'No Products',
    subtitle: 'No products are available right now.',
  );
}
```

Avoid wrapping a simple check in multiple generic utility layers without a real
reason.

## 21.2 Name by intent

Prefer:

```text
fetchProfile
selectedProduct
isSubmitting
formattedPrice
```

over:

```text
doStuff
data1
valueX
flag
```

When extending an existing API with a misspelled public method, preserve the
existing method for compatibility; use correct spelling for genuinely new APIs
where possible.

## 21.3 Small focused functions

Extract a function when it:

- represents a meaningful unit of behavior;
- improves screen readability;
- is reused;
- isolates complex branching.

Do not create a private method for every 3-line widget only to inflate
abstraction.

## 21.4 Comments explain decisions, not syntax

Good comment:

```dart
// Reset stale results before requesting the next search query.
```

Bad comment:

```dart
// Create a container.
Container(...)
```

Do not fill files with comments that merely narrate Dart syntax.

Remove obsolete comments when implementation changes.

## 21.5 No fake completeness

Do not add placeholder methods such as:

```dart
void handleFeature() {
  // TODO: implement later
}
```

unless the user explicitly requests scaffolding.

Do not claim a feature is complete when its backend/action is still a demo.

## 21.6 No speculative architecture

Do not create:

- repository interfaces;
- use-case classes;
- mappers;
- DTO/domain duplicates;
- base widget hierarchies;
- generic result wrappers;
- custom service locators;

unless the current feature complexity or explicit task genuinely requires them.

The existing architecture is already layered. Respect it rather than adding
ceremonial layers.

## 21.7 Preserve local style without copying mistakes

Use nearby active code to understand naming, composition, and flow, but do not
repeat obvious accidental behavior such as:

- test credentials inside `build()`;
- demo data as a production fallback;
- unsafe force unwraps when a null path is normal;
- raw colors when project colors exist;
- direct Navigator usage when the project's navigation helper is clearly the
  intended abstraction;
- duplicate error toasts;
- stale commented dependencies.

Consistency is important, but correctness and established shared architecture
are more important than reproducing a local mistake.

## 21.8 Clean, easy-to-read API and UI calling pattern

Code readability is essential. Follow these specific conventions:

1. **Named parameters in Rx methods**:
   - Do not pass raw, loosely-typed `Map` objects from UI into the Rx layer.
   - Use named parameters: `post({String? email, String? password})`, `deleteSwapSummary({int? id})`, `post({XFile? profilePicture})`.
   - The Rx class internally constructs payload maps and `FormData`, isolating network transport details from presentation widgets.

2. **Clean Future chaining with `.waitingForFutureWithoutBg()`**:
   - In UI buttons and tap handlers, chain actions directly:
     ```dart
     rxObj
         .post(...)
         .waitingForFutureWithoutBg()
         .then((isSuccess) {
           if (isSuccess) {
             // UI transitions, navigation, or list refresh
           }
         });
     ```
   - Avoid manual loading dialog management or try/catch blocks in widget code.

3. **Standard stream getter `fillData`**:
   - Rx classes consistently expose `ValueStream get fillData => dataFetcher.stream;`.
   - In UI screens, observe `stream: myRxObj.fillData` inside `StreamBuilder`.
   - Deserialize the data cleanly inside the builder: `MyModel.fromJson(snapshot.data)`.

4. **Standardized error handling in Rx**:
   - `handleErrorWithReturn(error)` inspects `if (error is DioException)` and extracts `error.response?.data["message"]`.
   - Checks `error.type == DioExceptionType.connectionError` to present `"Check Your Network Connection"`.
   - Displays a unified toast via `customToastMessage('Error', message)` and returns `false`.

## 21.9 Screen Construction Standard: Zero Private `_build...()` Methods (The Brunopomar Screen Pattern)

A major hallmark of machine-generated AI code is taking a Flutter screen and fracturing it into dozens of private helper methods inside the same `State` class:

```dart
// ❌ WRONG: AI Anti-Pattern — Monolithic screen sliced into private helper methods
children: [
  SizedBox(height: 12.h),
  // Top Bar: Back Button + Title
  _buildHeader(),
  SizedBox(height: 28.h),
  // Task Progress Section
  _buildProgressSection(),
  SizedBox(height: 28.h),
  // Section Title: REQUIRED TASK
  Text(...),
  SizedBox(height: 12.h),
  // Task List Card
  _buildTaskListCard(),
  SizedBox(height: 24.h),
],
...
_buildBottomActionBar(),
```

**Never do this.** In professional Flutter engineering and across all screens in `brunopomar_flutter`, private widget-builder methods (`Widget _buildSomething()`) are strictly prohibited.

### 21.9.1 Why `_build...()` Helper Methods are Harmful

1. **Rebuild Cascades & Performance Degradation**:
   Helper methods are functions, not widgets. Flutter's widget tree treats them as plain code inside the parent's `build()` method. Whenever `setState()` is called in the screen (e.g. typing in a field, toggling a checkbox, or receiving a stream event), **the entire screen and every single `_build...()` method re-executes and rebuilds from scratch**. Flutter cannot optimize or skip rebuilding them because they do not have their own `Widget` lifecycle, `Element`, or `canUpdate()` checks.
2. **Context Bugs & Theme Pitfalls**:
   Helper methods share the parent's `BuildContext` instead of their own unique node in the element tree. This breaks localized inherited widget lookups like `Theme.of(context)`, `MediaQuery.of(context)`, `ScaffoldMessenger.of(context)`, and `Navigator.of(context)`.
3. **Monolithic Spaghetti Files**:
   Slicing a screen into 10 private methods produces giant 800+ line "God" files where private methods mutate and access private state variables without clear boundaries.
4. **Machine-Code Feel**:
   Excessive robotic narrations (`// Top Bar: Back Button + Title`, `// Task Progress Section`, `// SingleChildScrollView`, `// Expanded`) combined with `_build...()` methods immediately identify code as low-quality AI generation.

---

### 21.9.2 The Brunopomar Solution: Two Humanized Rules

In `brunopomar_flutter` (e.g., `HomeScreen`, `LoginScreen`, `TranscriptionDetailsScreen`, `VoiceNoteScreen`), screens are built with two simple, humanized principles:

#### Rule 1: Direct Declarative Composition in `build()`
For typical screens and general layout flow, declare the UI directly inside `build(BuildContext context)`. The screen reads naturally top-to-bottom:
- Top bar uses existing `CustomAppBar(title: "...")`.
- Layout structure uses native Flutter widgets: `Scaffold`, `SafeArea`, `Column`, `Row`, `SingleChildScrollView`, `Container`, `Padding`.
- Spacing uses `UIHelper.verticalSpace(...)` and `UIHelper.horizontalSpace(...)`, not repetitive `SizedBox(height: ...)`.
- Shared inputs use `CustomTextField(...)` and buttons use `CustomButton(...)`.

#### Rule 2: Component Extraction into Standalone Widget Classes
When a section is complex, has its own internal state, repeats across lists, or represents a distinct visual component (such as cards, dialogs, or custom input bars):
- **Extract it into a standalone `StatelessWidget` or `StatefulWidget` file** under:
  ```text
  lib/features/<feature>/presentation/widget/<widget_name>.dart
  ```
  *(or `lib/features/<feature>/widget/<widget_name>.dart`)*
  Or if reused across features, place it in:
  ```text
  lib/common_widgets/<widget_name>.dart
  ```
- Give it a `const` constructor, typed parameters, and its own clean `build(BuildContext context)`.
- Real examples from `brunopomar_flutter`:
  - `ActionCard` (`lib/features/home/widget/action_card.dart`)
  - `SettingCard` (`lib/features/setting/widget/setting_card.dart`)
  - `NoteCard` (`lib/common_widgets/note_card.dart`)
  - `OtpInputField` (`lib/features/auth/widget/otp_input_field.dart`)
  - `NamePopup` (`lib/features/voice_note/presentation/widget/name_popup.dart`)

---

### 21.9.3 Concrete Side-by-Side Comparison

#### ❌ Machine-Generated AI Code (from user screenshot):
```dart
class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    // Top Bar: Back Button + Title
                    _buildHeader(),
                    SizedBox(height: 28.h),
                    // Task Progress Section
                    _buildProgressSection(),
                    SizedBox(height: 28.h),
                    // Section Title: REQUIRED TASK
                    Text(
                      'REQUIRED TASK',
                      style: GoogleFonts.urbanist(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Task List Card
                    _buildTaskListCard(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            // BOTTOM ACTION AREA
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(...); // 50 lines of code inside screen
  }

  Widget _buildProgressSection() {
    return Container(...); // 80 lines of code inside screen
  }

  Widget _buildTaskListCard() {
    return Container(...); // 120 lines of code inside screen
  }

  Widget _buildBottomActionBar() {
    return Container(...); // 60 lines of code inside screen
  }
}
```

#### ✅ Clean, Humanized Brunopomar Code:

**Screen (`features/task/presentation/task_screen.dart`):**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/colors.gen.dart';
import '../../../helpers/ui_helpers.dart';
import '../widget/task_progress_card.dart';
import '../widget/task_item_card.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cF9FAFB,
      body: SafeArea(
        child: Column(
          children: [
            UIHelper.verticalSpace(12.h),
            const CustomAppBar(title: "Task Details"),
            UIHelper.verticalSpace(28.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TaskProgressCard(completedCount: 3, totalCount: 5),
                    UIHelper.verticalSpace(28.h),
                    Text(
                      "REQUIRED TASK",
                      style: TextFontStyle.textStyle14c898989Poppins600,
                    ),
                    UIHelper.verticalSpace(12.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      separatorBuilder: (_, __) => UIHelper.verticalSpace(10.h),
                      itemBuilder: (context, index) => TaskItemCard(
                        title: "Task #$index",
                        onTap: () {},
                      ),
                    ),
                    UIHelper.verticalSpace(24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: CustomButton(
                text: "Complete Tasks",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Extracted Subwidget (`features/task/presentation/widget/task_progress_card.dart`):**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/text_font_style.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../helpers/ui_helpers.dart';

class TaskProgressCard extends StatelessWidget {
  final int completedCount;
  final int totalCount;

  const TaskProgressCard({
    super.key,
    required this.completedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = totalCount > 0 ? (completedCount / totalCount).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.cEDF8EC, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Progress", style: TextFontStyle.textStyle16c333333Poppins600),
          UIHelper.verticalSpace(8.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.cF1F5F9,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.allPrimaryColor),
          ),
        ],
      ),
    );
  }
}
```

### 21.9.4 Summary Checklist for Screen Architecture

- [ ] **Zero `Widget _build...()` methods**: Screen State classes never contain private methods returning `Widget`.
- [ ] **Direct composition**: The screen's layout is declared directly inside `build()`.
- [ ] **Component extraction**: Complex or reusable pieces live in their own `StatelessWidget` / `StatefulWidget` files inside `features/<feature>/presentation/widget/`.
- [ ] **No robotic syntax comments**: Code comments explain business logic, not obvious widget tree tags (`// Column`, `// Expanded`).
- [ ] **Clean spacing**: Spacing uses `UIHelper.verticalSpace` and `UIHelper.horizontalSpace`.
- [ ] **Token reuse**: Typography uses `TextFontStyle`, colors use `AppColors`, icons use `Assets`.

---

# 22. Null safety and type discipline

Write null-safe code intentionally.

Rules:

- avoid `!` unless the invariant is genuinely guaranteed;
- use nullable access for optional API fields;
- check route arguments before casting when they may be absent;
- prefer typed collections in new code;
- avoid `dynamic` when the type is known;
- do not convert a typed model back to `Map` just to pass it through UI;
- do not manufacture empty strings/zero values if "missing" has a different
  product meaning.

Existing models are nullable and defensive. Preserve resilience to incomplete
API responses.

---

# 23. UI composition and design consistency

For normal screens:

- use `Scaffold`;
- use `SafeArea` where screen content can collide with system UI;
- use `CustomAppBar` where the design fits;
- use `AppColors`;
- use `TextFontStyle`;
- use ScreenUtil;
- use `UIHelper` for common spacing;
- use shared buttons/text fields before rebuilding them;
- keep widget trees readable;
- **never use private helper methods returning widgets** (`_buildHeader`, `_buildTable`, `_buildCard`, etc.); compose directly in `build()` or extract into a standalone Widget class in `lib/features/<feature>/presentation/widget/<widget_name>.dart`;
- **do not write mechanical closing-tag or section comments** (`// Column`, `// SingleChildScrollView`, `// Top Bar: Back Button`, `// Expanded`).

For scrollable content:

- choose `ListView`, `GridView`, or `SingleChildScrollView` based on content,
  not habit;
- avoid nesting unbounded scroll views without constraints;
- use lazy builders for long lists;
- preserve responsive spacing from design specs.

Do not add random design constants because they "look close." Map supplied
Figma/design values through the existing color/type/spacing system whenever
possible.

---

# 24. Platform-specific code

The repository contains the standard Flutter platform targets (`android`, `ios`,
`web`, desktop targets).

Do not edit native platform files for a pure Dart/UI feature.

Modify Android/iOS configuration only when a package or product requirement
needs native permissions, URL schemes, signing-related config, background modes,
or other platform integration.

When native config is required:

1. inspect the package's current official installation requirements;
2. preserve existing application identifiers/signing configuration;
3. make only required entries;
4. do not overwrite manifest/plist files wholesale;
5. document any external console configuration the code alone cannot perform.

Do not assume commented template integrations are already installed/configured.

---

# 25. Dependencies

Before adding a package:

1. inspect `pubspec.yaml`;
2. check whether an existing dependency/helper already solves the problem;
3. prefer current project dependencies;
4. add a dependency only when it materially reduces complexity or is required
   by the feature;
5. avoid packages that introduce another state/navigation architecture for a
   narrow task.

Current architecture centers on:

- Flutter/Dart;
- RxDart;
- Dio;
- GetIt;
- GetStorage;
- FlutterScreenUtil;
- CachedNetworkImage;
- FlutterGen;
- Lottie/dotlottie;
- url_launcher;
- intl where needed.

Do not treat a commented dependency in `pubspec.yaml` as installed.

---

# 26. Generated code policy

Never hand-edit generated output.

Files containing comments such as:

```text
GENERATED CODE - DO NOT MODIFY BY HAND
```

are source artifacts, not edit targets.

Change generation inputs/configuration, then rerun the generator.

Before committing generated changes, verify they correspond only to intentional
input changes.

---

# 27. Testing and quality gates

For every implementation, apply these gates proportionally to the change.

## Mandatory static checks

```bash
dart format <changed files>
flutter analyze
```

## Tests

Run:

```bash
flutter test
```

where the repository/test environment permits it.

For meaningful new business/UI behavior, add or update focused tests when the
project has an appropriate testing seam.

Do not create a huge testing framework for a tiny change.

The repository may contain template-era tests that do not represent the current
app. Distinguish pre-existing failures from regressions introduced by your
change.

## Manual behavior checklist

For UI/API changes verify:

- initial loading;
- successful data;
- empty data;
- network/server failure;
- navigation/back behavior;
- repeated taps/submissions;
- null/missing optional fields;
- small-screen layout;
- keyboard/form behavior when relevant;
- authenticated vs unauthenticated state when relevant.

---

# 28. Security and data handling

Never commit or introduce:

- real passwords;
- production user credentials;
- private API tokens;
- signing secrets;
- OTPs;
- hardcoded bearer tokens.

Use existing environment/config patterns for runtime keys.

Do not log sensitive credentials or full auth tokens.

Keep user-facing validation separate from security decisions enforced by the
backend.

---

# 29. Refactoring rules

Refactoring is allowed when it directly supports the requested change, but it
must be scoped.

Good refactor:

- extracting a repeated feature widget used three times in the same feature;
- adding an optional parameter to a shared widget to avoid duplicate code;
- consolidating duplicated endpoint strings into `Endpoints`;
- replacing a newly touched direct network image with `AppNetworkImage`.

Bad incidental refactor:

- renaming every typo in the codebase;
- replacing RxDart with Riverpod;
- converting all relative imports to package imports;
- redesigning all models while adding one field;
- rewriting all buttons because one screen needs a special style.

When a compatibility-sensitive typo truly needs cleanup, prefer a staged
approach: introduce a correctly named API while keeping the old entry point as a
deprecated forwarder, then migrate callers separately if the project owner wants
that cleanup.

---

# 30. Decision hierarchy for ambiguous situations

When uncertain, use this priority order:

1. explicit user/product requirement;
2. runtime correctness and data safety;
3. established active shared infrastructure in this repository;
4. this master skill;
5. nearest production-like feature implementation;
6. README / architecture documentation;
7. demo, commented, placeholder, or legacy code.

Never choose a lower-priority source merely because it is faster to copy.

---

# 31. Agent implementation procedure

For every coding task, internally execute this procedure.

## A. Understand

- Restate the required behavior internally.
- Identify affected feature(s).
- Identify whether the change is UI-only, API-only, model, navigation, storage,
  platform, or cross-layer.
- Identify compatibility constraints.

## B. Inspect

Read the closest active feature and shared helpers before editing.

Search for:

- existing widgets;
- existing colors/styles;
- existing storage keys;
- existing route names;
- existing endpoints;
- existing model fields;
- existing network/image helpers.

## C. Plan minimal file changes

For a typical new API screen, expected files may be:

```text
features/<feature>/model/<model>.dart
features/<feature>/data/rx_<action>/api.dart
features/<feature>/data/rx_<action>/rx.dart
features/<feature>/presentation/<screen>.dart
features/<feature>/presentation/widget/<widget>.dart   # only if useful
networks/endpoints.dart
networks/api_acess.dart
helpers/all_routes.dart                               # only if routed
```

Do not touch more files than required.

## D. Implement in dependency order

Recommended order:

1. model;
2. endpoint;
3. feature API;
4. Rx layer;
5. shared Rx registration/access;
6. route;
7. UI;
8. feature widgets;
9. tests.

## E. Self-review against project rules

Search changed code for accidental violations:

```text
Image.network(
CachedNetworkImage(
Color(0x
'assets/
Dio()
Navigator.pushNamed(
'/api/
TextStyle(
GetStorage()
```

These strings are not universally forbidden, but each occurrence deserves a
reason because the project normally provides a centralized abstraction.

Also inspect for:

- duplicated toasts;
- controllers not disposed;
- force unwraps;
- API calls in `build()`;
- hardcoded route strings;
- duplicated storage key strings;
- hand-edited generated files;
- unscaled visual dimensions;
- copy-pasted demo values;
- excessive comments or abstractions.

## F. Format and validate

Run formatter, analyzer, appropriate tests, and asset generation when required.

## G. Report precisely

When returning work, explain:

- what changed;
- which architecture layers were touched;
- whether generation was required;
- validation performed;
- any pre-existing issue that prevented a fully green check.

Do not claim tests passed if they were not run.

---

# 32. Quick reference — use / avoid

| Need | Use | Avoid by default |
|---|---|---|
| Remote image | `AppNetworkImage` | raw `Image.network` |
| Local asset | FlutterGen `Assets...` | hardcoded `assets/...` string |
| Color | `AppColors` | repeated raw `Color(0x...)` |
| Typography | `TextFontStyle` | duplicated inline `TextStyle` |
| Responsive size | `.w`, `.h`, `.sp`, `.r` | arbitrary fixed UI dimensions |
| Spacing | `UIHelper` where suitable | repeated magic `SizedBox`s |
| HTTP | `getHttp/postHttp/putHttp/deleteHttp` | local `Dio()` |
| Endpoint | `Endpoints` | URL strings in features |
| State | RxDart + `RxResponseInt` pattern | Provider/GetX/Riverpod/BLoC ad hoc |
| Global Rx access | `api_acess.dart` pattern | duplicate global controller instances |
| Error message | `ErrorMessageHandler` | per-screen status map |
| Route | `Routes` + `RouteGenerator` + `NavigationService` | literal route strings |
| Storage | `appData` + constants | new `GetStorage()` everywhere |
| Post-Login Setup | `performPostLoginActions()` in `helpers/post_login.dart` | scattering `Dio.update()` / token setup across individual screens |
| Session Expiry / 401 | Interceptor `performForceLogout` + `appData.erase()` + `DioSingleton.instance.create()` | ignoring 401 / silent redirect loops / leaving user on broken screen |
| Logout Navigation | `NavigationService.navigateToUntilReplacement(Routes.logInScreen)` | `navigateTo` (which preserves backstack) |
| Validation | `validator.dart` | repeated validator functions |
| Shared form UI | `CustomTextFormField` | rebuilding same input decoration |
| App bar | `CustomAppBar` where applicable | unrelated per-screen recreation |
| Screen UI Decomposition | Direct `build()` composition or separate `StatelessWidget` in `widget/` | private `_buildHeader()`, `_buildTable()` methods inside screen State |
| Spacing & Dividers | `UIHelper.verticalSpace(...)` / `UIHelper.horizontalSpace(...)` | repetitive `SizedBox(height: ...)` with robotic comments |
| Empty/error/loading | existing common widgets | blank/ambiguous states |
| Generated code | regenerate | hand edit `lib/gen/*` |

---

# 33. Definition of done

A change is complete only when the relevant checks below are satisfied.

## Architecture

- [ ] Feature code is in the correct feature folder.
- [ ] UI, Rx, API, model, and network responsibilities are not mixed.
- [ ] Existing shared helpers are reused.
- [ ] No second state/network/navigation architecture was introduced.

## API

- [ ] Endpoint is centralized.
- [ ] Central Dio helpers are used.
- [ ] Failure flows to the existing error layer.
- [ ] 401 Unauthorized errors trigger force-logout (clearing storage, resetting Dio, redirecting to login).
- [ ] Authentication flows call `performPostLoginActions()` to bootstrap headers and session state.
- [ ] No duplicate user-facing error notification exists.
- [ ] Auth headers/tokens are not manually duplicated without need.

## UI

- [ ] Existing colors and text styles are reused.
- [ ] ScreenUtil conventions are followed.
- [ ] Common widgets are reused where appropriate.
- [ ] No private widget helper methods (`_buildHeader`, `_buildBody`, etc.); UI is composed directly or extracted into dedicated Widget classes in `widget/`.
- [ ] No robotic comment narrations (`// Column`, `// Header`, `// Sizedbox`).
- [ ] Loading, data, empty, and error states are covered where relevant.
- [ ] Controllers/resources are disposed when locally owned.

## Assets

- [ ] Local assets use generated `Assets` references.
- [ ] Remote images use `AppNetworkImage` unless there is a documented reason.
- [ ] New colors originate from `colors.xml`.
- [ ] Generated files were not hand-edited.
- [ ] FlutterGen was rerun when asset/color inputs changed.

## Navigation/storage

- [ ] Route names are centralized.
- [ ] Navigation uses the existing service/pattern.
- [ ] Logout clears backstack using `navigateToUntilReplacement`.
- [ ] Persisted keys use constants.
- [ ] Existing persisted-key values were not silently renamed.

## Code quality

- [ ] Names communicate intent.
- [ ] Code is simple and readable.
- [ ] No unnecessary abstraction was added.
- [ ] No demo credentials/placeholders were introduced into production logic.
- [ ] Comments explain non-obvious decisions only.
- [ ] Nullability and types are handled intentionally.
- [ ] Changed Dart files are formatted.
- [ ] Analyzer was run.
- [ ] Relevant tests were run or any limitation was reported accurately.

---

# 34. Final instruction to every agent

Do not treat this Flutter template as a blank Flutter application.

Before implementing anything, learn the existing path for that concern and stay
inside it.

The correct solution is normally the one that:

1. changes the fewest necessary files;
2. reuses the existing helper/component;
3. preserves current API contracts and stored data;
4. follows the feature → Rx → API → network flow;
5. uses generated assets/colors and shared typography;
6. remains responsive;
7. handles failure and loading explicitly;
8. reads like practical code written by an experienced human developer;
9. does not introduce architecture for architecture's sake;
10. leaves unrelated working code untouched.

When two approaches both work, choose the approach that is already native to
this repository.
