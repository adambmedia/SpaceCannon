//
//  LaserInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/17/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "LaserInstrument.h"

@implementation LaserInstrument

- (instancetype)init {
    return [super initWithFilename:@"Laser"];
}

@end

@implementation LaserNote

- (instancetype)initWithSpeed:(float)speed {
    self = [super init];
    if(self) {
        self.speed.value = speed;
    }
    return self;
}

@end