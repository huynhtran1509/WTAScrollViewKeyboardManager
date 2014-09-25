//
//  WTAKeyboardManager.h
//  WTAKeyboardManager
//
//  Created by Joel Garrett on 8/14/14.
//  Copyright (c) 2014 WillowTree Apps, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WTAKeyboardManagerDelegate;

@interface WTAKeyboardManager : NSObject

@property (nonatomic, weak) id <WTAKeyboardManagerDelegate> delegate;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) UIEdgeInsets initialContentInsets;
@property (nonatomic, readwrite) UIEdgeInsets initialScrollIndicatorInsets;
@property (nonatomic, readwrite) BOOL shouldUpdateScrollViewInsets;
@property (nonatomic, readwrite) BOOL shouldFlashScrollIndicators;

@property (nonatomic, readonly) CGRect keyboardFrame;
@property (nonatomic, readonly) BOOL isKeyboardHidden;

+ (id)firstResponder;
+ (void)dismissKeyboard;

@end

@protocol WTAKeyboardManagerDelegate <NSObject>

/**
 *  Scroll view inset change method
 */
- (void)keyboardManagerDidUpdateScrollViewInsets:(WTAKeyboardManager *)manager;

@optional

/**
 *  Notification forwarding delegate methods
 */

- (void)keyboardManager:(WTAKeyboardManager *)manager keyboardWillShow:(NSDictionary *)userInfo;
- (void)keyboardManager:(WTAKeyboardManager *)manager keyboardWillHide:(NSDictionary *)userInfo;
- (void)keyboardManager:(WTAKeyboardManager *)manager keyboardDidShow:(NSDictionary *)userInfo;
- (void)keyboardManager:(WTAKeyboardManager *)manager keyboardDidHide:(NSDictionary *)userInfo;
- (void)keyboardManager:(WTAKeyboardManager *)manager keyboardDidChangeFrame:(NSDictionary *)userInfo;

@end
