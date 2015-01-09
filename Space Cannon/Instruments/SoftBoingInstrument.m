//
//  SoftBoingInstrument.m
//  Space Cannon
//
//  Created by Nicholas Arner on 11/8/14.elf conn
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "SoftBoingInstrument.h"

@implementation SoftBoingInstrument

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        SoftBoing *softBoing = [[SoftBoing alloc]init];
        [self addNoteProperty:softBoing.pan];
        [self addNoteProperty:softBoing.amplitude];
        
        AKStruckMetalBar *struckBar = [[AKStruckMetalBar alloc] initWithDecayTime:akp(1.52)
                                                           dimensionlessStiffness:akp(76.3)
                                                                highFrequencyLoss:akp(0.007)
                                                                   strikePosition:akp(0.15)
                                                                   strikeVelocity:akp(608)
                                                                      strikeWidth:akp(0.386)
                                                            leftBoundaryCondition:AKStruckMetalBarBoundaryConditionPivoting
                                                           rightBoundaryCondition:AKStruckMetalBarBoundaryConditionClamped
                                                                        scanSpeed:akp(0.23)];
        [self connect:struckBar];
        
        AKPanner *panner = [[AKPanner alloc] initWithInput:[struckBar scaledBy:softBoing.amplitude]];
        panner.pan = softBoing.pan;
        [self connect:panner];
        
        _auxilliaryOutput = [AKStereoAudio globalParameter];
        [self assignOutput:_auxilliaryOutput to:panner];
        
    }
    return self;
}
@end


@implementation SoftBoing

- (instancetype)init {
    self = [super init];
    if (self) {
        _pan = [[AKNoteProperty alloc] initWithValue:0.0 minimum:-1 maximum:1];
        [self addProperty:_pan];
        _amplitude = [[AKNoteProperty alloc] initWithValue:1.0 minimum:0 maximum:1];
        [self addProperty:_amplitude];
        self.duration.value = 1.0;
    }
    return self;
}

- (instancetype)initWithPan:(float)pan
{
    self = [self init];
    if (self) {
        _pan.value = pan;
    }
    return self;
}

@end
