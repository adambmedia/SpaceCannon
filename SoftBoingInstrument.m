//
//  SoftBoingInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/8/14.elf conn
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "SoftBoingInstrument.h"


@implementation SoftBoingInstrument


- (instancetype)init
{
    self = [super init];
    if (self) {
        //InstrumentNote *note = [[InstrumentNote alloc] init];
        
        AKStruckMetalBar *struckBar = [[AKStruckMetalBar alloc] initWithDecayTime:akp(1.52)
                                                           dimensionlessStiffness:akp(76.3)
                                                                highFrequencyLoss:akp(0.007)
                                                                   strikePosition:akp(0.15)
                                                                   strikeVelocity:akp(608)
                                                                      strikeWidth:akp(0.386)
                                                            leftBoundaryCondition:akpi(2)
                                                           rightBoundaryCondition:akpi(1)
                                                                        scanSpeed:akp(.23)];
        [self connect:struckBar];
        
        _auxilliaryOutput = [AKAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:struckBar];
    }
    return self;
}
@end

@implementation SoftBoing

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

@end