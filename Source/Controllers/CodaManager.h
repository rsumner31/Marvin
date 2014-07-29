//
//  CodaManager.h
//  Marvin
//
//  Created by Christoffer Winterkvist on 15/07/14.
//
//

#import <Foundation/Foundation.h>
#import "CodaPlugInsController.h"

@interface CodaManager : NSObject

@property (nonatomic, strong) CodaPlugInsController *pluginController;

- (NSString *)contents;
- (NSUInteger)documentLength;
- (NSUInteger)currentLineNumber;
- (NSRange)selectedRange;
- (NSRange)currentWordRange;
- (NSRange)previousWordRange;
- (void)setSelectedRange:(NSRange)range;
- (NSRange)lineContentsRange;
- (NSRange)lineRange;
- (void)beginUndoGrouping;
- (void)endUndoGrouping;
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)string;
- (NSString *)contentsOfRange:(NSRange)range;
- (NSRange)joinRange;
- (NSString*)currentLine;
- (void)insertText:(NSString *)string;
- (void)save;
- (NSString *)selectedText;
- (void)getLine:(NSInteger*)line column:(NSInteger*)column;
- (BOOL)hasSelection;
- (BOOL)emptySelection;
- (void)goToLine:(NSInteger)line column:(NSInteger)column;
- (NSString *)filename;
- (NSString *)path;
- (NSInteger)tabWidth;
- (NSRange)selectScope:(NSString *)delimiter;

@end
