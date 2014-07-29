//
//  MARManipulationMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 16/07/14.
//
//

#import "MARTextMenu.h"

@implementation MARTextMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];

    [items addObject:({
        MARMenuItem *menuItem= [[MARMenuItem alloc] initWithTitle:@"Delete Line"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager deleteLine];
                                                         }];
         menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Duplicate Line"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager duplicateLine];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Join Line"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager joinLine];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Uppercase"
                                                       submenu:[self.class menuTitle]
                                                 keyEquivalent:@""
                                                       command:^(MarvinManager *manager){
                                                           [manager uppercase];
                                                       }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Lowercase"
                                                        submenu:[self.class menuTitle]
                                                  keyEquivalent:@""
                                                        command:^(MarvinManager *manager){
                                                            [manager lowercase];
                                                        }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Wrap in Brackets"
                                                        submenu:[self.class menuTitle]
                                                  keyEquivalent:@""
                                                        command:^(MarvinManager *manager){
                                                            [manager wrapInBrackets];
                                                        }];
        menuItem;
    })];

    return items;
}

+ (NSString *)menuTitle
{
    return @"Text";
}

@end
