# Mobile application architecture

## Overview

`src/mobileapp` is a Flutter 3.35.7 application built with Dart 3.9.2 for Android, iOS, and web. It uses Riverpod and Freezed for dependency composition and state, GoRouter for navigation, EasyLocalization for English and Vietnamese resources, Supabase for backend services, and a Dio/built_value client generated from the backend API contract. Shared infrastructure lives under `lib/core`, while application behavior is organized by feature under `lib/features` with data, domain, and presentation layers where needed.

## Project structure

```text
mobileapp/
├── android/                         # Android host project
├── api-client/                      # generated Dio and built_value backend client
├── assets/
│   ├── fonts/                       # bundled application fonts
│   └── translations/                # English and Vietnamese locale resources
├── ios/                             # iOS host project
├── lib/
│   ├── core/
│   │   ├── app/                     # root widget and provider observation
│   │   ├── configs/                 # compile-time application configuration
│   │   ├── constants/               # shared constants and locale definitions
│   │   ├── exceptions/              # shared failure model and exception mapping
│   │   ├── network/                 # generated API and Supabase composition
│   │   ├── router/                  # routes and GoRouter configuration
│   │   ├── storage/                 # application storage contract and adapter
│   │   ├── theme/                   # color schemes, typography, and themes
│   │   └── widgets/                 # reusable application widgets
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/                # remote sources and repository adapters
│   │   │   ├── domain/              # entities, repository contracts, and use cases
│   │   │   └── presentation/        # Riverpod state and authentication UI
│   │   ├── onboarding/              # onboarding presentation
│   │   └── splash/                  # application startup presentation
│   └── main.dart                    # Flutter entrypoint and service initialization
├── test/
│   └── core/network/                # API client unit and HTTP integration tests
├── tool/
│   └── generate_api_client.sh       # generated-client workflow
├── web/                             # Flutter web host project
├── openapi-generator-config.yaml    # Dart client generator configuration
└── pubspec.yaml                     # dependencies, assets, and SDK constraints
```
