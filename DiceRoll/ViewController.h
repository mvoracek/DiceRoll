//
//  ViewController.h
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiceView.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet DiceView *firstDieView;
@property (weak, nonatomic) IBOutlet DiceView *secondDieView;
@property (weak, nonatomic) IBOutlet DiceView *thirdDieView;
@property (weak, nonatomic) IBOutlet DiceView *fourthDieView;
@property (weak, nonatomic) IBOutlet DiceView *fifthDieView;
@property (weak, nonatomic) IBOutlet DiceView *sixthDieView;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;

@end

