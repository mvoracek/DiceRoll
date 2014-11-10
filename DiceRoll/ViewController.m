//
//  ViewController.m
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "ViewController.h"
#import "DiceData.h"
#import "ScoringData.h"

@interface ViewController ()

@property int roll1, roll2, roll3, roll4, roll5, roll6, sum;
@property NSInteger totalScore;

@end

static NSString *TotalScoreKey = @"totalScore";

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *totalScoreDefault = [NSUserDefaults standardUserDefaults];
    if ([totalScoreDefault objectForKey:TotalScoreKey] != nil) {
        self.totalScore = [totalScoreDefault integerForKey:TotalScoreKey];
    } else {
        self.totalScore = 0;
        [totalScoreDefault setInteger:self.totalScore forKey:TotalScoreKey];
        [totalScoreDefault synchronize];
    }
    
    [self updateTotalScore];
}

- (void)updateTotalScore
{
    self.totalScoreLabel.text = [NSString stringWithFormat:@"Total Score: %ld", (long)self.totalScore];
}

- (void)updateRollScore
{
    self.sumLabel.text = [NSString stringWithFormat:@"Dice Total: %d", self.sum];
}

- (void)updateRollTaken:(NSMutableArray *)array
{
    int sum = 0;
    ScoringData *scoringData = [[ScoringData alloc] init];
    
    sum = [scoringData checkDiceForScore:array];
    
    if (sum == self.sum) {
        self.sum = 0;
        [self resetDieViews];
    } else {
        self.sum = sum;
    }
    [self updateRollScore];
}

- (void) resetDieViews
{
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

- (IBAction)bankButtonClicked:(id)sender
{
    NSUserDefaults *totalScoreDefault = [NSUserDefaults standardUserDefaults];
    
    self.totalScore += self.sum;
    [totalScoreDefault setInteger:self.totalScore forKey:TotalScoreKey];
    [totalScoreDefault synchronize];
    
    [self resetDieViews];
    
    self.sum = 0;
    [self updateRollScore];
    [self updateTotalScore];
}

- (IBAction)rollButtonClicked:(id)sender
{
    DiceData *dieData = [[DiceData alloc] init];
    NSMutableArray *dice = [NSMutableArray array];
    
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
    
    [self addDie:self.roll1 toArray:dice];
    [self addDie:self.roll2 toArray:dice];
    [self addDie:self.roll3 toArray:dice];
    [self addDie:self.roll4 toArray:dice];
    [self addDie:self.roll5 toArray:dice];
    [self addDie:self.roll6 toArray:dice];

    [self updateRollTaken:dice];
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

- (void)addDie:(int)die toArray:(NSMutableArray *)array
{
    NSNumber *dieNumber = [NSNumber numberWithInt:die];
    [array addObject:dieNumber];
}

@end
