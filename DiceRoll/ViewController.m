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

@property int roll1, roll2, roll3, roll4, roll5, roll6, sum;

@end

static NSString *RollsTakenKey = @"rollsTaken";

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showRollButtonValue];
}

- (void)showRollButtonValue
{
    NSInteger rollsTaken;
    NSUserDefaults *rollsTakenDefault = [NSUserDefaults standardUserDefaults];
    
    if ([rollsTakenDefault objectForKey:RollsTakenKey] != nil) {
        rollsTaken = [rollsTakenDefault integerForKey:RollsTakenKey];
    } else {
        rollsTaken = 1;
        [rollsTakenDefault setInteger:rollsTaken forKey:RollsTakenKey];
        [rollsTakenDefault synchronize];
    }
    [self updateButtonTitle:rollsTaken];
}

- (void)updateRollTaken
{
    NSUserDefaults *rollsTakenDefault = [NSUserDefaults standardUserDefaults];
    NSInteger rollsTaken = [rollsTakenDefault integerForKey:RollsTakenKey];
    
    if (rollsTaken < 3) {
        rollsTaken++;
        [rollsTakenDefault setInteger:rollsTaken forKey:RollsTakenKey];
        [rollsTakenDefault synchronize];
    } else {
        rollsTaken = 1;
        [rollsTakenDefault setInteger:rollsTaken forKey:RollsTakenKey];
        [rollsTakenDefault synchronize];
        //tried to fast enumerate, would not work
        [self.firstDieView setAlpha:1.0];
        [self.firstDieView setIsHeldDie:NO];
        [self.secondDieView setAlpha:1.0];
        [self.secondDieView setIsHeldDie:NO];
        [self.thirdDieView setAlpha:1.0];
        [self.thirdDieView setIsHeldDie:NO];
        [self.fourthDieView setAlpha:1.0];
        [self.fourthDieView setIsHeldDie:NO];
        [self.fifthDieView setAlpha:1.0];
        [self.fifthDieView setIsHeldDie:NO];
        [self.sixthDieView setAlpha:1.0];
        [self.sixthDieView setIsHeldDie:NO];
    }
    
    self.sum = self.roll1 + self.roll2 + self.roll3 + self.roll4 + self.roll5 +self.roll6;
    self.sumLabel.text = [NSString stringWithFormat:@"Dice Total: %d", self.sum];
    [self updateButtonTitle:rollsTaken];
}

- (void)updateButtonTitle:(NSInteger)rollsTaken
{
    NSString *buttonTitle = [NSString stringWithFormat:@"Roll %ld", (long)rollsTaken];
    [self.rollButton setTitle:buttonTitle forState:UIControlStateNormal];
}

- (IBAction)rollButtonClicked:(id)sender
{
    DiceData *dieData = [[DiceData alloc] init];
    
    //fast enumerate this, but keep track of each die value
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
    if (!self.sixthDieView.isHeldDie) {
        self.roll6 = [self rollDie:dieData forView:self.sixthDieView];
    }

    [self updateRollTaken];
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
