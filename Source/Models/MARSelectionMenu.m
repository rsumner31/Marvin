//
//  MARSelectionMenu.m
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import "MARSelectionMenu.h"

@implementation MARSelectionMenu

+ (NSArray *)items
{
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Line"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                            [manager selectLine];
                                                        }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Line Contents"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager) {
                                                             [manager selectLine];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Tag Context"
                                                                 submenu:[self.class menuTitle]
                                                           keyEquivalent:@""
                                                                 command:^(MarvinManager *manager) {
                                                                     [manager selectLine];
                                                                 }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Word"
                                                               submenu:[self.class menuTitle]
                                                         keyEquivalent:@""
                                                               command:^(MarvinManager *manager) {
                                                                   [manager selectLine];
                                                               }];
        menuItem;
    })];


    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Word Above"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWordAbove];
                                                         }];
        menuItem;
    })];


    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Word Below"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWordBelow];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Next Word"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWord];
                                                         }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select Previous Word"
                                                             submenu:[self.class menuTitle]
                                                       keyEquivalent:@""
                                                             command:^(MarvinManager *manager){
                                                                 [manager selectPreviousWord];
                                                             }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select String"
                                                                 submenu:[self.class menuTitle]
                                                           keyEquivalent:@""
                                                                 command:^(MarvinManager *manager){
                                                                     [manager selectLine];
                                                                 }];

        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Highlight Selection"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@"@$e"
                                                           command:^(MarvinManager *manager){
                                                               [manager highlightSelection];
                                                           }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select All Within Brackets - Forward"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@""
                                                           command:^(MarvinManager *manager){
                                                               [manager selectAllWithinBracketsForward];
                                                           }];
        menuItem;
    })];

    [items addObject:({
        MARMenuItem *menuItem = [[MARMenuItem alloc] initWithTitle:@"Select All Within Brackets - Backward"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@""
                                                           command:^(MarvinManager *manager){
                                                               [manager selectAllWithinBracketsBackward];
                                                           }];
        menuItem;
    })];

    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Selections";
}

@end
