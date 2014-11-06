//
//  DiceView.m
//  DiceRoll
//
//  Created by Matthew Voracek on 11/5/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "DiceView.h"

@implementation DiceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.dieImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        [self addSubview:self.dieImage];
    }
    return self;
}

- (void)showDie:(int)num
{
    NSString *fileName = [NSString stringWithFormat:@"dice%d", num];
    self.dieImage.image = [UIImage imageNamed:fileName];
}

@end
