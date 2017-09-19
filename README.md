[![Build Status](https://travis-ci.org/appunite/pronto-android_lint.svg?branch=master)](https://travis-ci.org/appunite/pronto-android_lint)
[![Gem Version](https://badge.fury.io/rb/pronto-android_lint.svg)](https://badge.fury.io/rb/pronto-android_lint)

# Pronto::AndroidLint

Pronto runner for android lint

## Installation

```
$ gem install pronto-android_lint
```

## Environment variables

* **PRONTO_ANDROID_LINT_RESULT_PATHS**

  Path to lint result files<br>
  Multiple paths should be separated by comma<br>
  `PRONTO_ANDROID_LINT_RESULT_PATHS=app/build/reports/lint-results.xml,app/build/reports/lint-results-release-fatal.xml`

* **PRONTO_ANDROID_LINT_PATH_SHIFT**

  Pronto is using relative paths<br>
  `app/src/main/res/values/strings.xml`

  If lint result contains absolute paths<br>
  `/builds/user_or_group/project_name/app/src/main/res/values/strings.xml`

  You need to set how many parts of path should be removed<br>
  `PRONTO_ANDROID_LINT_PATH_SHIFT=3`

## Usage

```
pronto run
```

For more details see [Pronto](https://github.com/prontolabs/pronto) readme

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
