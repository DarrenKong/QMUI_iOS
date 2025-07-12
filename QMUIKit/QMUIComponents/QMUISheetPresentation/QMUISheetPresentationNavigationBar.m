//
//  QMUISheetPresentationNavigationBar.m
//  QMUIKit
//
//  Created by molice on 2024/2/27.
//  Copyright © 2024 QMUI Team. All rights reserved.
//

#import "QMUISheetPresentationNavigationBar.h"
#import "QMUICore.h"
#import "QMUIButton.h"
#import "QMUINavigationButton.h"
#import "QMUINavigationTitleView.h"

@interface QMUISheetPresentationNavigationBar ()
@property(nonatomic, strong) QMUINavigationButton *backButton;
@property(nonatomic, strong) QMUIButton *leftButton;
@property(nonatomic, strong) QMUIButton *rightButton;
@end

@implementation QMUISheetPresentationNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        
        self.titleLabel = [[UILabel alloc] init];
        if (QMUICMIActivated) {
            self.titleLabel.font = NavBarTitleFont;
            self.titleLabel.textColor = NavBarTitleColor;
        }
        
        self.rightButton = [[QMUIButton alloc] init];
        [self.rightButton setImage:QMUICMI.navBarCloseButtonImage forState:(UIControlStateNormal)];
        [self.rightButton addTarget:self action:@selector(handleCloseItemEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
    }
    return self;
}

- (void)setNavigationItem:(UINavigationItem *)navigationItem {
    if (_navigationItem != navigationItem) {
        self.titleLabel.text = nil;
        [self.titleView removeFromSuperview];
    }
    _navigationItem = navigationItem;
    if (navigationItem.titleView) {
        if ([navigationItem.titleView isKindOfClass:NSClassFromString(@"QMUINavigationTitleView")]) {
            QMUINavigationTitleView *navigationTitleView = (QMUINavigationTitleView *)navigationItem.titleView;
            self.titleLabel.text = navigationTitleView.titleLabel.text;
            self.titleView = self.titleLabel;
        } else {
            self.titleView = navigationItem.titleView;
        }
    } else if (navigationItem.title.length) {
        self.titleLabel.text = navigationItem.title;
        self.titleView = self.titleLabel;
    }
    [self addSubview:self.titleView];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, 56);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleView sizeToFit];
    self.titleView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    self.rightButton.frame = CGRectMake(CGRectGetWidth(self.bounds) - 44 - 8, (CGRectGetHeight(self.bounds) - 44) / 2, 44, 44);
}

- (void)handleCloseItemEvent {
    if (self.qmui_tapCloseBlock) {
        self.qmui_tapCloseBlock(self.rightButton);
    }
}

@end
