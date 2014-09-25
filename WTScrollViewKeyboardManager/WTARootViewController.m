//
//  WTRootViewController.m
//  WTScrollViewKeyboardManager
//
//  Created by Andrew Carter on 10/7/13.
//  Copyright (c) 2013 WillowTree Apps. All rights reserved.
//

#import "WTARootViewController.h"

#import "WTAKeyboardManager.h"

@interface WTARootViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) WTAKeyboardManager *keyboardManager;

@end

@implementation WTARootViewController

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Form"];
    [self setupKeyboardManager];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [[self scrollView] setContentSize:CGSizeMake(CGRectGetWidth([[self scrollView] bounds]),
                                                 CGRectGetHeight([[self scrollView] bounds]))];
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

#pragma mark - Instance Methods

- (void)setupKeyboardManager
{
    WTAKeyboardManager *manager = [WTAKeyboardManager new];
    [self setKeyboardManager:manager];
}

- (IBAction)submitButtonPressed:(id)sender
{
    [WTAKeyboardManager dismissKeyboard];
}

@end
