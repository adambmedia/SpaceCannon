//
//  CrunchInstrument.m
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "CrunchInstrument.h"

@implementation CrunchInstrument
- (instancetype)init
{
    self = [super init];
    if (self) {
        //InstrumentNote *note = [[InstrumentNote alloc] init];
        
        AKCrunch *crunch = [[AKCrunch alloc] initWithDuration:akp(0.1) amplitude:akp(0.9)];
        [crunch setOptionalCount:akpi(53)];
        [crunch setOptionalDampingFactor:akp(0.83)];
        [self connect:crunch];
        
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:crunch];
    }
    return self;
}

@end
