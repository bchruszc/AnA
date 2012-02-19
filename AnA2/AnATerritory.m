//
//  AnATerritory.m
//  AnA2
//
//  Created by Brad Chruszcz on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AnATerritory.h"

@implementation AnATerritory

@synthesize name;
@synthesize capitol;
@synthesize controllingFaction;
@synthesize nativeFaction;
@synthesize value;

- (NSComparisonResult)compare:(AnATerritory *)otherObject {
    return [self.name compare:otherObject.name];
}

@end
