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
- (NSRange)joinRange;;
- (void)uppercase;
- (void)lowercase;

@end
