//
//  SirenInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/18/14.
//  Copyright (c) 2014 AudioKit. All rights reserved.
//

#import "AKFoundation.h"

@interface SirenInstrument : AKInstrument

@property (nonatomic, strong) AKInstrumentProperty *pan;

@property (readonly) AKStereoAudio *auxilliaryOutput;

@end
