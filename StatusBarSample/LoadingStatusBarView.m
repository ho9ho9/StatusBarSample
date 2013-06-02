//
//  SampleStatusBarView.m
//  StatusBarSample
//
//  Created by ho9ho9 on 2013/06/02.
//  Copyright (c) 2013年 ho9ho9. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LoadingStatusBarView.h"

@interface LoadingStatusBarView() {
    @private
    UIView *_rectView;
    UILabel *_label;
    UIActivityIndicatorView *_indicator;
}

@end

@implementation LoadingStatusBarView

- (id)initWithController:(UIViewController *)controller {
    self = [super init];
    if (self != nil) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        float x = statusBarFrame.origin.x;
        float y = statusBarFrame.origin.y;
        float w = statusBarFrame.size.width;
        float h = statusBarFrame.size.height;
        // controller
        controller.wantsFullScreenLayout = YES;
        CGRect mainFrame = CGRectMake(0, h, controller.view.bounds.size.width, controller.view.bounds.size.height);
        UIView *mainView = [[UIView alloc] initWithFrame:mainFrame];
        mainView.backgroundColor = controller.view.backgroundColor;
        for (UIView *v in [controller.view subviews]) {
            [v removeFromSuperview];
            [mainView addSubview:v];
        }
        [controller.view addSubview:mainView];
        mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
         // status view
        self.backgroundColor = [UIColor blackColor];
        self.frame = CGRectMake(x, y, w, h);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // rect area
        _rectView = [[UIView alloc] init];
        _rectView.backgroundColor = [UIColor grayColor];
        _rectView.frame = CGRectMake(0, h, w, (h * 2));
        _rectView.layer.cornerRadius = 5.0f;
        _rectView.clipsToBounds = true;
        _rectView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_rectView];
        
        [controller.view addSubview:self];
        [controller.view sendSubviewToBack:self];
    }
    return self;
}

- (void)showStatusBar {
    // animation
    NSTimeInterval duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        CGRect rectFrame = _rectView.bounds;
        float w = rectFrame.size.width;
        float h = rectFrame.size.height;
        _rectView.frame = CGRectMake(0, 20, w, h);
    } completion:^(BOOL finished) {
        [self removeMessageArea];
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)dismissStatusBar:(NSString *)text {
    [self addMessageArea:text];
    // animation
    [_indicator startAnimating];
    NSTimeInterval duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView animateWithDuration:duration animations:^{
        CGRect rectFrame = _rectView.bounds;
        float w = rectFrame.size.width;
        float h = rectFrame.size.height;
        _rectView.frame = CGRectMake(0, 0, w, h);
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void) addMessageArea:(NSString *)text {
    if (_indicator == nil) {
        // label
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
//        _label.frame = CGRectMake(0, 0, 0, 0);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
//        _label.text = @"";
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        // set text
        _label.text = text;
        [_label sizeToFit];
        // layout position
        float rectW = _rectView.bounds.size.width;
        CGSize labelSize = _label.bounds.size;
        float labelX = (rectW / 2) - (labelSize.width / 2);
        _label.frame = CGRectMake(labelX, 0, labelSize.width, labelSize.height);

        [_rectView addSubview:_label];
        
        // Activity indicator
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        float indicatorX = labelX - _indicator.frame.size.width;
        _indicator.frame = CGRectMake(indicatorX, 10, 0, 0);

        [_rectView addSubview:_indicator];
    }
}
- (void)removeMessageArea {
    if (_indicator != nil) {
        [_indicator stopAnimating];
        [_indicator removeFromSuperview];
        _indicator = nil;
    }
}

@end
