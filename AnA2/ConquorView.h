
//
//  ConquorView.h
//  AnA2
//
//  Created by Brad Chruszcz on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConquorView : UITableViewController{
	NSArray *territoryList;
    NSMutableArray *sectionsArray;
	UILocalizedIndexedCollation *collation;
}
@property (nonatomic, retain) NSArray *territoryList;


@end