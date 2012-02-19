//
//  AnATerritory.h
//  AnA2
//
//  Created by Brad Chruszcz on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnATerritory : NSObject {
    NSString *name;
    NSString *capitol;
    NSInteger value;
    NSInteger nativeFaction;
    NSInteger controllingFaction;
}

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *capitol;
@property NSInteger value;
@property NSInteger nativeFaction;
@property NSInteger controllingFaction;

@end
