//
//  DAIndexBar.m
//  DAIndexBar
//
//  Created by Daria Kopaliani on 9/10/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import "DAIndexBar.h"

@interface DAIndexBar ()

@property (assign, nonatomic) CGFloat indexViewHeight;

@end


@implementation DAIndexBar

#pragma mark - Initialization

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - Private

- (void)handleTouch:(UITouch *)touch
{
    NSInteger letterIndex = (NSInteger)floorf(fabs([touch locationInView:self].y) / self.indexViewHeight);
    if (letterIndex < 0) {
        letterIndex = 0;
    } else if (letterIndex > self.indexTitles.count - 1) {
        letterIndex = self.indexTitles.count - 1;
    }
    __block NSInteger scrollIndex;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, letterIndex + 1)];
    [self.indexTitles enumerateObjectsAtIndexes:indexSet
                                        options:NSEnumerationReverse
                                     usingBlock:^(NSString *letter, NSUInteger index, BOOL *stop) {
        scrollIndex = [self.indexTitles indexOfObject:letter];
        *stop = scrollIndex != NSNotFound;
    }];
    [self.delegate indexBar:self didSelectIndex:scrollIndex];
}

- (void)setUp
{
    if (!self.indexTitles) {
        self.indexTitles = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    }
    if (!self.indexColor) {
        self.indexColor =[UIColor lightGrayColor];
    }
}

- (CATextLayer *)textLayerWithFontSize:(CGFloat)fontSize string:(NSString *)string frame:(CGRect)frame
{
    CATextLayer *textLayer = [CATextLayer layer];
    [textLayer setFont:@"ArialMT"];
    [textLayer setFontSize:fontSize];
    [textLayer setFrame:frame];
    [textLayer setAlignmentMode:kCAAlignmentCenter];
    [textLayer setContentsScale:[[UIScreen mainScreen] scale]];
    [textLayer setForegroundColor:self.indexColor.CGColor];
    [textLayer setString:string];
    return textLayer;
}
     
#pragma mark - Public

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    self.indexViewHeight = CGRectGetHeight(self.frame) / self.indexTitles.count;
    CGFloat fontSize = 12;
    [self.indexTitles enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger index, BOOL *stop) {
        CGRect frame = CGRectMake(0., index * self.indexViewHeight, CGRectGetWidth(self.frame), self.indexViewHeight);
        CATextLayer *textLayer = [self textLayerWithFontSize:fontSize
                                                      string:letter
                                                       frame:frame];
        [self.layer addSublayer:textLayer];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self handleTouch:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self handleTouch:[touches anyObject]];
}

@end