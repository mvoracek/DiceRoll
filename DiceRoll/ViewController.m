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
    
    [self.bankButton setUserInteractionEnabled:NO];
    [self.bankButton setAlpha:0.5];
    
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

- (void)updateRollTaken:(int)sum
{
//    int sum = 0;
//    ScoringData *scoringData = [[ScoringData alloc] init];
//    
//    sum += [scoringData checkDiceForScore:array];
    
    if (sum == 0) {
        self.sum = 0;
        [self resetDieViews];
        [self.bankButton setUserInteractionEnabled:NO];
        [self.bankButton setAlpha:0.5];
    } else {
        self.sum += sum;
        if (self.sum > 300) {
            [self.bankButton setUserInteractionEnabled:YES];
            [self.bankButton setAlpha:1.0];
        }
    }
    
    [self updateRollScore];
}

- (int)scoreDice:(NSMutableArray *)array {
    ScoringData *scoringData = [[ScoringData alloc] init];
    
    int sum = [scoringData checkDiceForScore:array];
    
    return sum;
}

- (void)resetDieViews
{
    [self resetForDieView:self.firstDieView];
    [self resetForDieView:self.secondDieView];
    [self resetForDieView:self.thirdDieView];
    [self resetForDieView:self.fourthDieView];
    [self resetForDieView:self.fifthDieView];
    [self resetForDieView:self.sixthDieView];
}

- (void) resetForDieView:(DiceView *)die
{
    //tried to fast enumerate, would not work
    [die setAlpha:1.0];
    [die setUserInteractionEnabled:YES];
    [die setBackgroundColor:[UIColor clearColor]];
    [die setIsHeldDie:NO];
    [die setDieHasPoints:NO];
    [die setRoll:0];
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
    NSMutableArray *dice = [NSMutableArray array];
    
    [self checkForHeldDie:self.firstDieView position:1 forDice:dice];
    [self checkForHeldDie:self.secondDieView position:2 forDice:dice];
    [self checkForHeldDie:self.thirdDieView position:3 forDice:dice];
    [self checkForHeldDie:self.fourthDieView position:4 forDice:dice];
    [self checkForHeldDie:self.fifthDieView position:5 forDice:dice];
    [self checkForHeldDie:self.sixthDieView position:6 forDice:dice];
    
    int sum = [self scoreDice:dice];
    
    BOOL diceAllHavePoints = YES;
    for (DiceView *die in dice) {
        if (!die.dieHasPoints) {
            diceAllHavePoints = NO;
        }
    }
    
    if (diceAllHavePoints) {
        [self resetDieViews];
    }
    
    [self updateRollTaken:sum];
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

- (void)checkForHeldDie:(DiceView *)dieView position:(int)dieNumber forDice:(NSMutableArray *)dice
{
    DiceData *dieData = [[DiceData alloc] init];
    
    dieView.dieNumber = dieNumber;
    
    if (dieView.isHeldDie) {
        if (!dieView.dieHasPoints) {
            //error
        } else {
            [dieView setUserInteractionEnabled:NO];
        }
    } else {
        dieView.roll = [self rollDie:dieData forView:dieView];
        [dice addObject:dieView];
    }
}

- (int)rollDie:(DiceData *)dieData forView:(DiceView *)die
{
    int roll = [dieData getDiceRoll];
    [die showDie:roll];
    return roll;
}

@end
