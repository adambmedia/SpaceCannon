//
//  SoftBoingInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/8/14.
//  Copyright (c) 2014 Hear for Yourself. All rights reserved.
//

#import "AKFoundation.h"


@interface SoftBoingInstrument : AKInstrument

@property (readonly) AKAudio *auxilliaryOutput;

@end

@interface SoftBoing : AKNote
- (instancetype)init;

@end