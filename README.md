WTScrollViewKeyboardManager
===========================

A class to manage scroll view content and scroll indicator insets when the keyboard appears and disappears

Features
========
Automatically manages scroll view offsets when the keyboard appears and disappears. Works with iPhone and iPad, and allows you to provide additional insets for the content and scroll indicator if needed.

Usage
=====

```
WTScrollViewKeyboardManager *manager = [[WTScrollViewKeyboardManager alloc] initWithScrollView:[self scrollView] viewController:self];
[self setKeyboardManager:manager];
```

Demo
====

![Demo](https://raw.github.com/willowtreeapps/WTScrollViewKeyboardManager/develop/demo.gif)
