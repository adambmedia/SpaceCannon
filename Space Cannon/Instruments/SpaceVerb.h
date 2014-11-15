//
//  SpaceVerb.h
//  Space Cannon
//
//  Created by Aurelius Prochazka on 11/14/14.
//  Copyright (c) 2014 Hear For Yourself. All rights reserved.
//

#import "AKFoundation.h"

@interface SpaceVerb : AKInstrument

- (instancetype)initWithInstrument1:(AKAudio *)inst1
                        instrument2:(AKAudio *)inst2
                        instrument3:(AKAudio *)inst3;
@end
