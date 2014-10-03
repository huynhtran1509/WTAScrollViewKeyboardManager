//
//  WTAKeyboardManager.m
//  WTAKeyboardManager
//
//  Created by Joel Garrett on 8/14/14.
//  Copyright (c) 2014 WillowTree Apps, Inc. All rights reserved.
//

#import "WTAKeyboardManager.h"
#import <objc/message.h>

@interface WTAFirstResponderEvent : UIEvent

@property (nonatomic, strong) id firstResponder;

@end

@implementation WTAFirstResponderEvent

@end

@implementation UIResponder (WTAKeyboardManager_FirstResponder)

- (void)wta_findFirstResponder:(id)sender event:(WTAFirstResponderEvent *)event
{
    event.firstResponder = self;
}

@end

@interface WTAKeyboardManager ()

@property (nonatomic, strong) NSDictionary *keyboardInfo;
@property (nonatomic, readwrite, setter = setKeyboardHidden:) BOOL isKeyboardHidden;

@end

@implementation WTAKeyboardManager

+ (id)firstResponder
{
    WTAFirstResponderEvent *event = [WTAFirstResponderEvent new];
    [[UIApplication sharedApplication] sendAction:@selector(wta_findFirstResponder:event:)
                                               to:nil
                                             from:nil
                                         forEvent:event];
    return event.firstResponder;
}

+ (void)dismissKeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        id firstResponder = [[self class] firstResponder];
        [self setKeyboardHidden:(firstResponder == nil)];
        [self setupKeyboardNotificationObserver];
    }
    return self;
}

- (void)setupKeyboardNotificationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

#pragma Accessors/setters

- (void)setScrollView:(UIScrollView *)scrollView
{
    if (![_scrollView isEqual:scrollView])
    {
        _scrollView = scrollView;
        [self setInitialContentInsets:scrollView.contentInset];
        [self setInitialScrollIndicatorInsets:scrollView.scrollIndicatorInsets];
    }
    if (self.shouldUpdateScrollViewInsets &&
        self.keyboardInfo.allKeys.count)
    {
        [self updateScrollViewInsets:self.keyboardInfo
                            animated:YES];
    }
}

- (CGRect)keyboardFrame
{
    NSValue *keyboardFrameValue = self.keyboardInfo[UIKeyboardFrameEndUserInfoKey];
    if (keyboardFrameValue)
    {
        CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
        return keyboardFrame;
    }
    return CGRectZero;
}

#pragma mark - Scroll view inset updates

- (void)updateScrollViewInsets:(NSDictionary *)keyboardInfo
{
    [self updateScrollViewInsets:keyboardInfo
                        animated:NO];
}

- (void)updateScrollViewInsets:(NSDictionary *)keyboardInfo animated:(BOOL)animated
{
    NSValue *keyboardFrameValue = keyboardInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
    NSNumber *animationDuration = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *animationOptions = keyboardInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIEdgeInsets contentInsets = self.initialContentInsets;
    UIEdgeInsets scrollIndicatorInsets = self.initialScrollIndicatorInsets;
    
    // Get the scroll view's frame relative to it's window
    UIWindow *window = self.scrollView.window;
    CGRect scrollViewFrame = self.scrollView.frame;
    scrollViewFrame.origin = [window convertPoint:scrollViewFrame.origin
                                       fromWindow:nil];
    
    CGRect intersection = CGRectIntersection(keyboardFrame, scrollViewFrame);
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        contentInsets.bottom += intersection.size.height;
        scrollIndicatorInsets.bottom += intersection.size.height;
    }
    else
    {
        contentInsets.bottom += intersection.size.width;
        scrollIndicatorInsets.bottom += intersection.size.width;
    }
    
    CGFloat duration = (animated) ? animationDuration.floatValue : 0.0f;
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:animationOptions.unsignedIntegerValue
                     animations:^{
                         
                         self.scrollView.contentInset = contentInsets;
                         self.scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
                         
                     } completion:^(BOOL finished) {
                         
                         if (self.shouldFlashScrollIndicators)
                         {
                             [[self scrollView] flashScrollIndicators];
                         }
                         if (self.delegate)
                         {
                             [[self delegate] keyboardManagerDidUpdateScrollViewInsets:self];
                         }
                         
                     }];
}

#pragma mark - Delegate notification

- (void)notifyDelegate:(SEL)delegateSelector object:(id)object
{
    if (self.delegate && [[self delegate] respondsToSelector:delegateSelector])
    {
        objc_msgSend(self.delegate,
                     delegateSelector,
                     self,
                     object);
    }
}

#pragma mark - Keyboard notifications

- (void)keyboardDidChangeFrameNotification:(NSNotification*)notification
{
    [self setKeyboardInfo:notification.userInfo];
    [self notifyDelegate:@selector(keyboardManager:keyboardDidChangeFrame:)
                  object:notification.userInfo];
    
    if (self.shouldUpdateScrollViewInsets)
    {
        [self updateScrollViewInsets:notification.userInfo];
    }
}

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    [self notifyDelegate:@selector(keyboardManager:keyboardWillShow:)
                  object:notification.userInfo];
    
    if (self.shouldUpdateScrollViewInsets)
    {
        [self updateScrollViewInsets:notification.userInfo animated:YES];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    [self notifyDelegate:@selector(keyboardManager:keyboardWillHide:)
                  object:notification.userInfo];
    if (self.shouldUpdateScrollViewInsets)
    {
        [self updateScrollViewInsets:notification.userInfo animated:YES];
    }
    
    // Remove frame change notification observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidChangeFrameNotification
                                                  object:nil];
}

- (void)keyboardDidShowNotification:(NSNotification *)notification
{
    [self setKeyboardInfo:notification.userInfo];
    [self notifyDelegate:@selector(keyboardManager:keyboardDidShow:)
                  object:notification.userInfo];
    [self setKeyboardHidden:NO];
    
    // Add frame change notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}

- (void)keyboardDidHideNotification:(NSNotification *)notification
{
    [self setKeyboardInfo:notification.userInfo];
    [self notifyDelegate:@selector(keyboardManager:keyboardDidHide:)
                  object:notification.userInfo];
    [self setKeyboardHidden:YES];
}

@end
