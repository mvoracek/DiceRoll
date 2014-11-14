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
    NSMutableArray *ones = [NSMutableArray array];
    NSMutableArray *twos = [NSMutableArray array];
    NSMutableArray *threes = [NSMutableArray array];
    NSMutableArray *fours = [NSMutableArray array];
    NSMutableArray *fives = [NSMutableArray array];
    NSMutableArray *sixes = [NSMutableArray array];
    int sum = 0;

    //sorting die values
    for (DiceView *die in dice) {
        if (die.roll == 1) {
            [ones addObject:die];
        } else if (die.roll == 2) {
            [twos addObject:die];
        } else if (die.roll == 3) {
            [threes addObject:die];
        } else if (die.roll == 4) {
            [fours addObject:die];
        } else if (die.roll == 5) {
            [fives addObject:die];
        } else if (die.roll == 6) {
            [sixes addObject:die];
        }
    }
    if (ones.count != 0) {
        [counts addObject:ones];
    }
    if (twos.count != 0) {
        [counts addObject:twos];
    }
    if (threes.count != 0) {
        [counts addObject:threes];
    }
    if (fours.count != 0) {
        [counts addObject:fours];
    }
    if (fives.count != 0) {
        [counts addObject:fives];
    }
    if (sixes.count != 0) {
        [counts addObject:sixes];
    }
    
    //scoring
    if (counts.count == 3) {
        BOOL isAllPairs = YES;
        for (NSMutableArray *checkForPairs in counts) {
            if (checkForPairs.count != 2) {
                isAllPairs = NO;
            }
        }
        if (isAllPairs == YES) {
            for (DiceView *die in dice) {
                [self setDieForPoints:die];
            }
            return 1500;
        }
    }
    
    for (NSMutableArray *array in counts) {
        if (array.count == 6) {
            for (DiceView *die in dice) {
                [self setDieForPoints:die];
            }
            return 3000;
        }
        if (array.count == 5) {
            if (ones.count == 1) {
                for (DiceView *die in dice) {
                    [self setDieForPoints:die];
                }
                return 2100;
            } else if (fives.count == 1) {
                for (DiceView *die in dice) {
                    [self setDieForPoints:die];
                }
                return 2050;
            } else {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                return 2000;
            }
        }
        if (counts.count == 6) {
            for (DiceView *die in dice) {
                [self setDieForPoints:die];
            }
            return 1500;
        }
        if (array.count == 4) {
            if (counts.count == 2) {
                for (DiceView *die in dice) {
                    [self setDieForPoints:die];
                }
                return 1500;
            } else {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 1000;
            }
        }
        if (array.count == 3) {
            if (counts.count == 2) {
                for (DiceView *die in dice) {
                    [self setDieForPoints:die];
                }
                return 2500;
            }
            if (ones.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 300;
            }
            if (twos.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 200;
            }
            if (threes.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 300;
            }
            if (fours.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 400;
            }
            if (fives.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 500;
            }
            if (sixes.count == 3) {
                for (DiceView *die in array) {
                    [self setDieForPoints:die];
                }
                sum += 600;
            }
        }
    }
    
    if (ones.count == 2 || ones.count == 1) {
        for (DiceView *die in ones) {
            [self setDieForPoints:die];
        }
        sum += (100 * ones.count);
    }
    
    if (fives.count == 2 || fives.count == 1) {
        for (DiceView *die in fives) {
            [self setDieForPoints:die];
        }
        sum += (50 * fives.count);
    }

    return sum;
}

- (void)setDieForPoints:(DiceView *)die
{
    [die setDieHasPoints:YES];
    [die setBackgroundColor:[UIColor redColor]];
}

@end
