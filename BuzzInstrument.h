//
//  BuzzInstrument.h
//  Space Cannon
//
//  Created by Nicholas Arner on 11/14/14.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "AKFoundation.h"

@interface BuzzInstrument : AKInstrument

@end

@interface Buzz : AKNote
@property AKNoteProperty *frequency;

- (instancetype)initWithFrequency:(float)frequency;

@end