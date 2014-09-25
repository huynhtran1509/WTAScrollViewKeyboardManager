WTAScrollViewKeyboardManager
===========================

A class to manage scroll view content and scroll indicator insets when the keyboard appears and disappears

Features
========
Automatically manages scroll view offsets when the keyboard appears and disappears. Works with iPhone and iPad, and allows you to provide additional insets for the content and scroll indicator if needed.

Usage
=====

```
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  WTAKeyboardManager *manager = [WTAKeyboardManager new];
  [self setKeyboardManager:manager];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [[self keyboardManager] setShouldUpdateScrollViewInsets:YES];
  [[self keyboardManager] setScrollView:self.scrollView];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [[self keyboardManager] setShouldUpdateScrollViewInsets:NO];
}

- (IBAction)doneButtonPressed:(id)sender
{
  [WTAKeyboardManager dismissKeyboard];
}
```

Demo
====

![Demo](https://raw.github.com/willowtreeapps/WTScrollViewKeyboardManager/develop/demo.gif)
