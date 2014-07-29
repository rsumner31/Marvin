//
//  MARWindowMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 16/07/14.
//
//

#import "MARWindowMenu.h"

@implementation MARWindowMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Open in New Window"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@"@N"
                                                         command:^(MarvinManager *manager){
                                                             [manager openInNewWindow];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Move to New Window"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@"~@N"
                                                         command:^(MarvinManager *manager){
                                                             [manager moveToNewWindow];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Split Vertically"
                                                                    submenu:[self.class menuTitle]
                                                              keyEquivalent:@"^v"
                                                                    command:^(MarvinManager *manager){
                                                                        [manager splitViewVertically];
                                                                    }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Split Horizontally"
                                                        submenu:[self.class menuTitle]
                                                  keyEquivalent:@"@S"
                                                        command:^(MarvinManager *manager){
                                                            [manager splitViewHorizontally];
                                                        }];
        menuItem;
    })];



    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Window";
}

@end
