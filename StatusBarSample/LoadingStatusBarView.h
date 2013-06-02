//
//  SampleStatusBarView.h
//  StatusBarSample
//
//  Created by ho9ho9 on 2013/06/02.
//  Copyright (c) 2013年 ho9ho9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingStatusBarView : UIView

- (id)initWithController:(UIViewController *)controller;
- (void)showStatusBar;
- (void)dismissStatusBar:(NSString *)text;

@end
