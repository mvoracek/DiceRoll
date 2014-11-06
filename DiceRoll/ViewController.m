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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)rollButtonClicked:(id)sender
{
    DiceData *dieData = [[DiceData alloc] init];
    
    int roll1 = [dieData getDiceRoll];
    int roll2 = [dieData getDiceRoll];
    int roll3 = [dieData getDiceRoll];
    int roll4 = [dieData getDiceRoll];
    int roll5 = [dieData getDiceRoll];

    
    [self.firstDieView showDie:roll1];
    [self.secondDieView showDie:roll2];
    [self.thirdDieView showDie:roll3];
    [self.fourthDieView showDie:roll4];
    [self.fifthDieView showDie:roll5];
    
    int sum = roll1 + roll2 + roll3 + roll4 + roll5;
    
    self.sumLabel.text = [NSString stringWithFormat:@"Sum is %d", sum];
}

- (IBAction)dieTapped:(UITapGestureRecognizer *)sender
{
    if (sender.view.alpha == 1.0) {
        sender.view.alpha = 0.5;
    } else {
        sender.view.alpha = 1.0;
    }
}

@end
