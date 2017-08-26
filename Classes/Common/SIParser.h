//
//  SIParser.h
//  SIParser
//
//  Created by Silence on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SINode.h"

#ifdef SIParserDebug
#define SIParserLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define SIParserLog(format, ...)
#endif

extern NSString *const SIParserDomain;
typedef NSAttributedString *(^SINodeBlock)(SINode *node, NSDictionary *defaultStyles);

@interface SIParser : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *stylesMap;
@property (nonatomic, strong, readonly) NSMutableDictionary *nodeBlocksMap;

- (SINodeList *)nodeListWithString:(NSString *)inString;
- (NSAttributedString *)parseString:(NSString *)inString;

- (void)addStyle:(NSDictionary *)inStyle forTag:(NSString *)inTag;
- (void)removeStyleForTag:(NSString *)inTag;

- (void)addNodeBlock:(SINodeBlock)inNodeBlock forTag:(NSString *)inTag;
- (void)removeNodeBlockForTag:(NSString *)inTag;

@end

@interface SIParser (Error)

- (NSError *)errorWithCode:(NSInteger)code UserInfo:(NSDictionary *)userInfo;

@end
