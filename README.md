# Placemat

[![CI Status](http://img.shields.io/travis/Dan2552/Placemat.svg?style=flat)](https://travis-ci.org/Dan2552/Placemat)
[![Version](https://img.shields.io/cocoapods/v/Placemat.svg?style=flat)](http://cocoapods.org/pods/Placemat)
[![License](https://img.shields.io/cocoapods/l/Placemat.svg?style=flat)](http://cocoapods.org/pods/Placemat)
[![Platform](https://img.shields.io/cocoapods/p/Placemat.svg?style=flat)](http://cocoapods.org/pods/Placemat)

Placemat is a support library with little helpers. It's main purpose is to be used alongside [Luncheon](https://github.com/Dan2552/luncheon), but can also be used standalone.

It's most notable features are:

- `Navigation` - Helper class to navigate between view controllers easily.
 - `show(target:modally:)` - shows a given UIViewController. Modally is optional. When modally is enabled, it will embed the target in a UINavigationController and present modally.
 - `dimiss()` - Dismisses the view controller. Automatically determines how the controller should be dismissed appropriately (e.g. if it's shown modally or not)
 - `setupWindow()`. - Used to setup a UIWindow containing the view controller. Normally this should be used within `application:didFinishLaunchingWithOptions:`.
- `BlockBarButtonItem` - UIBarButtonItem that simply allows you to supply a block rather than a selector.
- `String` extensions -
  - `changingCaseOf(firstCharacter:)` - Change the case of the first character of a string
  - `camelCased(firstCharacterCase:)` - Converts `underscore_cased` to `camelCased` or `CamelCased`
  - `pluralize()` - E.g. `"Banana"` to `"Bananas"`; `"Money"` to `"Monies"`
  - `underscoreCased()` - Converts `camelCased` or `CamelCased` to `underscore_cased`
  - `humanize(firstCharacterCase:)` - E.g. converts `"underscore_cased"` to `"underscore cased"` or `"Underscore cased"`
  - `titleize()`- E.g. converts `"underscore_cased"` to `"Underscore Cased"`


## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Placemat is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Placemat"
```

## Author

Daniel Inkpen, dan2552@gmail.com

## License

Placemat is available under the MIT license. See the LICENSE file for more info.
