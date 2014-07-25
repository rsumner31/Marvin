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

    MARMenuItem *selectLine = [[MARMenuItem alloc] initWithTitle:@"Select Line"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
        [manager selectLine];
    }];
    [items addObject:selectLine];

    MARMenuItem *selectLineContents = [[MARMenuItem alloc] initWithTitle:@"Select Line Contents"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectLine];
                                                         }];
    [items addObject:selectLineContents];

    MARMenuItem *selectTagContext = [[MARMenuItem alloc] initWithTitle:@"Select Tag Context"
                                                                 submenu:[self.class menuTitle]
                                                           keyEquivalent:@""
                                                                 command:^(MarvinManager *manager){
                                                                     [manager selectLine];
                                                                 }];
    [items addObject:selectTagContext];

    MARMenuItem *selectWord = [[MARMenuItem alloc] initWithTitle:@"Select Word"
                                                               submenu:[self.class menuTitle]
                                                         keyEquivalent:@""
                                                               command:^(MarvinManager *manager){
                                                                   [manager selectLine];
                                                               }];
    [items addObject:selectWord];

    MARMenuItem *selectWordAbove = [[MARMenuItem alloc] initWithTitle:@"Select Word Above"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWordAbove];
                                                         }];
    [items addObject:selectWordAbove];

    MARMenuItem *selectWordBelow = [[MARMenuItem alloc] initWithTitle:@"Select Word Below"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWordBelow];
                                                         }];
    [items addObject:selectWordBelow];

    MARMenuItem *selectNextWord = [[MARMenuItem alloc] initWithTitle:@"Select Next Word"
                                                         submenu:[self.class menuTitle]
                                                   keyEquivalent:@""
                                                         command:^(MarvinManager *manager){
                                                             [manager selectWord];
                                                         }];
    [items addObject:selectNextWord];

    MARMenuItem *selectPreviousWord = [[MARMenuItem alloc] initWithTitle:@"Select Previous Word"
                                                             submenu:[self.class menuTitle]
                                                       keyEquivalent:@""
                                                             command:^(MarvinManager *manager){
                                                                 [manager selectPreviousWord];
                                                             }];
    [items addObject:selectPreviousWord];

    MARMenuItem *selectString = [[MARMenuItem alloc] initWithTitle:@"Select String"
                                                                 submenu:[self.class menuTitle]
                                                           keyEquivalent:@""
                                                                 command:^(MarvinManager *manager){
                                                                     [manager selectLine];
                                                                 }];
    [items addObject:selectString];

    MARMenuItem *highlightSelection = [[MARMenuItem alloc] initWithTitle:@"Highlight Selection"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@"@$e"
                                                           command:^(MarvinManager *manager){
                                                               [manager highlightSelection];
                                                           }];
    [items addObject:highlightSelection];

    MARMenuItem *selectAllWithinBracketsForward = [[MARMenuItem alloc] initWithTitle:@"Select All Within Brackets - Forward"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@""
                                                           command:^(MarvinManager *manager){
                                                               [manager selectAllWithinBracketsForward];
                                                           }];
    [items addObject:selectAllWithinBracketsForward];

    MARMenuItem *selectAllWithinBracketsBackward = [[MARMenuItem alloc] initWithTitle:@"Select All Within Brackets - Backward"
                                                           submenu:[self.class menuTitle]
                                                     keyEquivalent:@""
                                                           command:^(MarvinManager *manager){
                                                               [manager selectAllWithinBracketsBackward];
                                                           }];
    [items addObject:selectAllWithinBracketsBackward];

    return [items copy];
}

+ (NSString *)menuTitle
{
    return @"Selections";
}

@end
