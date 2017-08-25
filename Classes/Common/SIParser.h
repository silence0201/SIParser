//
//  SIParser.h
//  SIParser
//
//  Created by 杨晴贺 on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SINode.h"

#ifdef SIParserDebug
#define SIParserLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define SIParserLog(format, ...)
#endif

extern NSString *const SIParserDomain;

@interface SIParser : NSObject

- (SINodeList *)nodeListWithString:(NSString *)inString filter:(id<SINodeFilter>)inFilter;

@end

@interface SIParser (Error)

- (NSError *)errorWithCode:(NSInteger)code UserInfo:(NSDictionary *)userInfo;

@end
