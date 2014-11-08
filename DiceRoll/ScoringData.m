//
//  ScoringData.m
//  DiceRoll
//
//  Created by Matthew Voracek on 11/7/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "ScoringData.h"

@implementation ScoringData

- (int)checkDiceForScore:(NSArray *)dice
{
    NSMutableArray *counts = [NSMutableArray array];
    NSNumber *ones = @0;
    NSNumber *twos = @0;
    NSNumber *threes = @0;
    NSNumber *fours = @0;
    NSNumber *fives = @0;
    NSNumber *sixes = @0;
    int sum = 0;

    //sorting die values
    for (NSNumber *die in dice) {
        if ([die isEqual: @1]) {
            ones = [NSNumber numberWithInt:[ones intValue] + 1];
        } else if ([die isEqual: @2]) {
            twos = [NSNumber numberWithInt:[twos intValue] + 1];
        } else if ([die isEqual: @3]) {
            threes = [NSNumber numberWithInt:[threes intValue] + 1];
        } else if ([die isEqual: @4]) {
            fours = [NSNumber numberWithInt:[fours intValue] + 1];
        } else if ([die isEqual: @5]) {
            fives = [NSNumber numberWithInt:[fives intValue] + 1];
        } else if ([die isEqual: @6]) {
            sixes = [NSNumber numberWithInt:[sixes intValue] + 1];
        }
    }
    if (![ones isEqualToNumber:@0]) {
        [counts addObject:ones];
    }
    if (![twos isEqualToNumber:@0]) {
        [counts addObject:twos];
    }
    if (![threes isEqualToNumber:@0]) {
        [counts addObject:threes];
    }
    if (![fours isEqualToNumber:@0]) {
        [counts addObject:fours];
    }
    if (![fives isEqualToNumber:@0]) {
        [counts addObject:fives];
    }
    if (![sixes isEqualToNumber:@0]) {
        [counts addObject:sixes];
    }
    
    //scoring
    for (NSNumber *value in counts) {
        if ([value isEqualToNumber:@6]) {
            return 3000;
        }
        if ([value isEqualToNumber:@5]) {
            if ([ones isEqualToNumber:@1]) {
                return 2100;
            } else if ([fives isEqualToNumber:@5]) {
                return 2050;
            } else {
                return 2000;
            }
        }
        if (counts.count == 3 && [counts[0] isEqualToNumber:@2] && [counts[1] isEqualToNumber:@2] && [counts[2] isEqualToNumber:@2]) {
            return 1500;
        }
        if ([value isEqualToNumber:@1] && counts.count == 6) {
            return 1500;
        }
        if ([value isEqualToNumber:@4]) {
            if (counts.count == 2) {
                return 1500;
            } else {
                sum += 1000;
            }
        }
        if ([value isEqualToNumber:@3]) {
            if (counts.count == 2) {
                return 2500;
            }
            if ([ones isEqualToNumber:@3]) {
                sum += 300;
            }
            if ([twos isEqualToNumber:@3]) {
                sum += 200;
            }
            if ([threes isEqualToNumber:@3]) {
                sum += 300;
            }
            if ([fours isEqualToNumber:@3]) {
                sum += 400;
            }
            if ([fives isEqualToNumber:@3]) {
                sum += 500;
            }
            if ([sixes isEqualToNumber:@3]) {
                sum += 600;
            }
        }
    }
    
    if ([ones isEqualToNumber:@2] || [ones isEqualToNumber:@1]) {
        sum += (100 * [ones intValue]);
    }
    
    if ([fives isEqualToNumber:@2] || [fives isEqualToNumber:@1]) {
        sum += (50 * [fives intValue]);
    }

    return sum;
}

@end
