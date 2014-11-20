//
//  MenacingInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/20/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "MenacingInstrument.h"

@implementation MenacingInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

@end



@implementation MenacingNote


- (instancetype)init {
    self = [super init];
    if (self) {
        _pan = [[AKNoteProperty alloc] initWithValue:0.5 minimum:0 maximum:1];
        [self addProperty:_pan];
        self.duration.value = 1.0;
    }
    return self;
}


@end