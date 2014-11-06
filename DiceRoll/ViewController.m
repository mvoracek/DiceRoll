//
//  ViewController.m
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "ViewController.h"
#import "DiceData.h"

@interface ViewController ()

@property int roll1, roll2, roll3, roll4, roll5;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)rollButtonClicked:(id)sender
{
    DiceData *dieData = [[DiceData alloc] init];
    int sum = 0;
    
    if (!self.firstDieView.isHeldDie) {
        self.roll1 = [self rollDie:dieData forView:self.firstDieView];
    }
    if (!self.secondDieView.isHeldDie) {
        self.roll2 = [self rollDie:dieData forView:self.secondDieView];
    }
    if (!self.thirdDieView.isHeldDie) {
        self.roll3 = [self rollDie:dieData forView:self.thirdDieView];
    }
    if (!self.fourthDieView.isHeldDie) {
        self.roll4 = [self rollDie:dieData forView:self.fourthDieView];
    }
    if (!self.fifthDieView.isHeldDie) {
        self.roll5 = [self rollDie:dieData forView:self.fifthDieView];
    }
    
    sum = self.roll1 + self.roll2 + self.roll3 + self.roll4 + self.roll5;
    
    self.sumLabel.text = [NSString stringWithFormat:@"Sum is %d", sum];
}

- (IBAction)dieTapped:(UITapGestureRecognizer *)sender
{
    DiceView *die = (DiceView *)sender.view;
    
    if (sender.view.alpha == 1.0) {
        die.alpha = 0.5;
        die.isHeldDie = YES;
    } else {
        die.alpha = 1.0;
        die.isHeldDie = NO;
    }
}

- (int)rollDie:(DiceData *)dieData forView:(DiceView *)die
{
    int roll = [dieData getDiceRoll];
    [die showDie:roll];
    return roll;
}

@end
