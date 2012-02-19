
//
//  ConquorView.m
//  AnA2
//
//  Created by Brad Chruszcz on 12-02-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConquorView.h"
#import "AnATerritory.h"

@implementation ConquorView

@synthesize territoryList;


- (void)viewDidLoad
{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// The number of sections is the same as the number of titles in the collation.
    return [[collation sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	// The number of time zones in the section is the count of the array associated with the section in the sections array.
	NSArray *timeZonesInSection = [sectionsArray objectAtIndex:section];
	
    return [timeZonesInSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// Get the time zone from the array associated with the section index in the sections array.
	NSArray *territoriesInSection = [sectionsArray objectAtIndex:indexPath.section];
	
	// Configure the cell with the time zone's name.
	AnATerritory *territory = [territoriesInSection objectAtIndex:indexPath.row];
    cell.textLabel.text = territory.name;
    NSString * iconName;
    switch (territory.controllingFaction) {
        case 1:
            iconName = @"russia_icon";
            break;
        case 2:
            iconName = @"germany_icon";
            break;
        case 3:
            iconName = @"england_icon";
            break;
        case 4:
            iconName = @"japan_icon";
            break;
        case 5:
            iconName = @"usa_icon";
            break;
        default:
            break;
    }
    if(iconName){
        NSString *path = [[NSBundle mainBundle] pathForResource:iconName ofType:@"png"];
        UIImage *theImage = [UIImage imageWithContentsOfFile:path];
        cell.imageView.image = theImage;
    }
    
    if(territory.controllingFaction != territory.nativeFaction){
        cell.detailTextLabel.text = @"Conquered";
    }
	
    return cell;
}

/*
 Section-related methods: Retrieve the section titles and section index titles from the collation.
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[collation sectionTitles] objectAtIndex:section];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [collation sectionIndexTitles];
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [collation sectionForSectionIndexTitleAtIndex:index];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setTerritoryList:(NSMutableArray *)newDataArray {
	if (newDataArray != territoryList) {
		territoryList = newDataArray;
	}
	if (territoryList == nil) {
		sectionsArray = nil;
	}
	else {
		[self configureSections];
	}
}


- (void)configureSections {
	
	// Get the current collation and keep a reference to it.
	self->collation = [UILocalizedIndexedCollation currentCollation];
	
	NSInteger index, sectionTitlesCount = [[collation sectionTitles] count];
	
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	// Set up the sections array: elements are mutable arrays that will contain the time zones for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
	}
	
	// Segregate the time zones into the appropriate arrays.
	for (AnATerritory *territory in territoryList) {
		// Ask the collation which section number the time zone belongs in, based on its locale name.
		NSInteger sectionNumber = [collation sectionForObject:territory collationStringSelector:@selector(name)];
		
		// Get the array for the section.
		NSMutableArray *sectionTimeZones = [newSectionsArray objectAtIndex:sectionNumber];
		
		//  Add the time zone to the section.
		[sectionTimeZones addObject:territory];
	}
	
	// Now that all the data's in place, each section array needs to be sorted.
	for (index = 0; index < sectionTitlesCount; index++) {
		
		NSMutableArray *timeZonesArrayForSection = [newSectionsArray objectAtIndex:index];
		
		// If the table view or its contents were editable, you would make a mutable copy here.
		NSArray *sortedTimeZonesArrayForSection = [collation sortedArrayFromArray:timeZonesArrayForSection collationStringSelector:@selector(name)];
		
		// Replace the existing array with the sorted array.
		[newSectionsArray replaceObjectAtIndex:index withObject:sortedTimeZonesArrayForSection];
	}
	
	self->sectionsArray = newSectionsArray;
}


@end