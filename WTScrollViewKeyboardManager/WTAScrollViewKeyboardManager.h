//
//  WTAScrollViewKeyboardManager.h
//  WTAScrollViewKeyboardManager
//
//  Created by Andrew Carter on 10/7/13.
//  Copyright (c) 2013 WillowTree Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WTAScrollViewKeyboardManager;

@protocol WTScrollViewKeyboardMangerDelegate <NSObject>

- (void)keyboardWillShow:(WTAScrollViewKeyboardManager *)keyboardManager userInfo:(NSDictionary *)userInfo;
- (void)keyboardWillHide:(WTAScrollViewKeyboardManager *)keyboardManager userInfo:(NSDictionary *)userInfo;
- (void)keyboardDidShow:(WTAScrollViewKeyboardManager *)keyboardManager userInfo:(NSDictionary *)userInfo;
- (void)keyboardDidHide:(WTAScrollViewKeyboardManager *)keyboardManager userInfo:(NSDictionary *)userInfo;

@end

@interface WTAScrollViewKeyboardManager : NSObject

- (instancetype)initWithScrollView:(UIScrollView *)scrollView viewController:(UIViewController *)viewController;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, weak) id <WTScrollViewKeyboardMangerDelegate> delegate;
@property (nonatomic, assign) BOOL shouldFlashScrollIndicators;

@property (nonatomic, assign) UIEdgeInsets contentInsetsWithKeyboard;
@property (nonatomic, assign) UIEdgeInsets contentInsetsWithoutKeyboard;
@property (nonatomic, assign) UIEdgeInsets scrollIndicatorInsetsWithKeyboard;
@property (nonatomic, assign) UIEdgeInsets scrollIndicatorInsetsWithoutKeyboard;

@end
