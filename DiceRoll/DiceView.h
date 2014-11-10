//
//  DiceView.h
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiceView : UIView

@property (nonatomic, strong) UIImageView *dieImage;
@property int roll;
@property BOOL isHeldDie;
@property BOOL dieHasPoints;

- (void)showDie:(int)num;

@end
