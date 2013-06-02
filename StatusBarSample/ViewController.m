//
//  ViewController.m
//  StatusBarSample
//
//  Created by ho9ho9 on 2013/06/02.
//  Copyright (c) 2013年 ho9ho9. All rights reserved.
//

#import "ViewController.h"
#import "LoadingStatusBarView.h"

@interface ViewController () {
    @private
    LoadingStatusBarView *_statusBarView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.wantsFullScreenLayout = YES;
    [ UIApplication sharedApplication ].statusBarStyle = UIStatusBarStyleBlackTranslucent;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(60, 100, 200, 50);
    [button setTitle:@"status bar loading" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // StatusBar
    _statusBarView = [[LoadingStatusBarView alloc] initWithController:self];
}

- (void)tapButton:(id)sendar {
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        [_statusBarView showStatusBar];
    } else {
        [_statusBarView dismissStatusBar:@"now loading..."];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
