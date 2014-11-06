//
//  DiceData.m
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "DiceData.h"

@implementation DiceData

- (int)getDiceRoll
{
    int roll = (arc4random() % 6) + 1;
    
    return roll;
}

@end
