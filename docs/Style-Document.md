#### Effective Dart

- Be consistent.
- Be brief.

[https://dart.dev/guides/language/effective-dart](https://dart.dev/guides/language/effective-dart)

#### Flutter formatting guidelines

- Have a single, shared style, and
- Enforce this style through automatic formatting.

[https://docs.flutter.dev/development/tools/formatting](https://docs.flutter.dev/development/tools/formatting)

#### Flutter performance practices

[https://docs.flutter.dev/perf/rendering/best-practices](https://docs.flutter.dev/perf/rendering/best-practices)

#### Command for formatting the code

- Enforces formatting guidelines

```
flutter format .
```

#### Command for linting the code

- Enforces Effective Dart and other Flutter rules
- Statically analyzes the project for errors

```
flutter analyze .
```

#### Command for running the tests

```
flutter test -r expanded .
```

---

### Checks must pass before the commit is pushed.

If checks fail, then we must revisit the tests and revise our work to ensure the checks pass before the commit.


