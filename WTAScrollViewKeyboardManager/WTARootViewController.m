//
//  WTRootViewController.m
//  WTScrollViewKeyboardManager
//
//  Created by Andrew Carter on 10/7/13.
//  Copyright (c) 2013 WillowTree Apps. All rights reserved.
//

#import "WTARootViewController.h"

#import "WTAScrollViewKeyboardManager.h"

@interface WTARootViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) WTAScrollViewKeyboardManager *keyboardManager;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textFields;

@end

@implementation WTARootViewController

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    [self setupKeyboardManager];
}

- (void)viewDidLayoutSubviews
{
    [[self scrollView] setContentSize:CGSizeMake(CGRectGetWidth([[self scrollView] bounds]), CGRectGetHeight([[self scrollView] bounds]))];
}

#pragma mark - Instance Methods

- (void)setupKeyboardManager
{
    WTAScrollViewKeyboardManager *manager = [[WTAScrollViewKeyboardManager alloc] initWithScrollView:[self scrollView] viewController:self];
    [self setKeyboardManager:manager];
    
}

- (IBAction)submitButtonPressed:(id)sender
{
    [[self textFields] makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

@end
