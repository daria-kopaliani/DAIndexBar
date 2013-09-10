//
//  DAIndexBar.h
//  DAIndexBar
//
//  Created by Daria Kopaliani on 9/10/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DAIndexBar;

@protocol DAIndexBarDelegate <NSObject>

- (void)indexBar:(DAIndexBar *)indexBar didSelectIndex:(NSInteger)index;

@end


@interface DAIndexBar : UIView

@property (strong, nonatomic) NSArray *indexTitles;
@property (strong, nonatomic) UIColor *indexColor;
@property (weak, nonatomic) id<DAIndexBarDelegate> delegate;

@end