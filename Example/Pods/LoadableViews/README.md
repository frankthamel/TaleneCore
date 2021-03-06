![Build Status](https://travis-ci.org/MLSDev/LoadableViews.svg?branch=master) &nbsp;
[![codecov.io](http://codecov.io/github/MLSDev/LoadableViews/coverage.svg?branch=master)](http://codecov.io/github/MLSDev/LoadableViews?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)]()

# LoadableViews

Easiest way to load view classes into another XIB or storyboard.

![WTFCat](wtf_cat_designable.png)

## Basic setup

* Subclass your view from `LoadableView`
* Create a xib file, set File's Owner class to your class
* Link outlets as usual

## Usage

* Drop UIView to your XIB or storyboard
* Set it's class to your class name

Your view is automatically loaded to different xib!

## IBInspectable && IBDesignable

IBInspectables automatically render themselves if your view is IBDesignable. Usually Interface Builder is not able to automatically figure out that your view is IBDesignable, so you need to add this attribute to your view subclass:

```swift
  @IBDesignable class WTFCatView: LoadableView
```

## UI classes supported

- [x] UIView - `LoadableView`
- [x] UITableViewCell - `LoadableTableViewCell`
- [x] UICollectionViewCell - `LoadableCollectionViewCell`
- [x] UICollectionReusableView - `LoadableCollectionReusableView`
- [x] UITextField - `LoadableTextField`

To use loading from xibs, for example for UICollectionViewCells, drop UIView instead of UICollectionViewCell in InterfaceBuilder, and follow basic setup. Then, on your storyboard, set a class of your cell, and it will be automatically updated.

## Customization

Change xib name

```swift
class CustomView : LoadableView {
  override var nibName : String {
    return "MyCustomXibName"
  }
}
```

Change view container

```swift
  class CustomViewWithLoadableContainerView : LoadableView {
    override var nibContainerView : UIView {
      return containerView
    }
  }
```

## Making your custom views loadable

* Adopt `NibLoadableProtocol` on your custom `UIView` subclass.
* Override `nibName` and `nibContainerView` properties, if necessary.
* Call `setupNib` method in both `init(frame:)` and `init(coder:)` methods.

## Known issues

* `IBDesignable` attribute is not recognized when it's inside framework due to bundle paths, which is why in current version you need to add `IBDesignable` attribute to your views manually.
* `UITableViewCell` and therefore `LoadableTableViewCell` cannot be made `IBDesignable`, because InterfaceBuilder uses `initWithFrame(_:)` method to render views: [radar](http://www.openradar.me/19901337), [stack overflow](http://stackoverflow.com/questions/26197582/is-there-a-way-for-interface-builder-to-render-ibdesignable-views-which-dont-ov)
* `UIScrollView` subclasses such as `UITextView` don't behave well with loadable views being inserted, which is why `UITextView` loadable subclass is not included in current release, but may be implemented in the future.

## Requirements

* iOS 8+
* tvOS 9.0+
* Swift 4.0 / 3.2

## Installation

#### CocoaPods

```ruby
  pod 'LoadableViews', '~> 2.2.0'
```

#### Carthage

```ruby
  carthage 'MLSDev/LoadableViews' "2.2.0"
```

## License

`LoadableViews` is released under the MIT license. See LICENSE for details.

## About MLSDev

[<img src="https://github.com/MLSDev/development-standards/raw/master/mlsdev-logo.png" alt="MLSDev.com">][mlsdev]

`LoadableViews` are maintained by MLSDev, Inc. We specialize in providing all-in-one solution in mobile and web development. Our team follows Lean principles and works according to agile methodologies to deliver the best results reducing the budget for development and its timeline.

Find out more [here][mlsdev] and don't hesitate to [contact us][contact]!

[mlsdev]: https://mlsdev.com
[contact]: https://mlsdev.com/contact-us
