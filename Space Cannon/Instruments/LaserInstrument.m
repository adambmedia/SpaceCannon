//
//  LaserInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/17/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "LaserInstrument.h"

@implementation LaserInstrument

- (instancetype)init {
    return [super initWithFilename:@"Laser"];
}

@end

@implementation LaserNote

- (instancetype)initWithSpeed:(float)speed pan:(float)pan {
    self = [super init];
    if(self) {
        self.speed.value = speed;
        self.pan.value = pan;
    }
    return self;
}

@end