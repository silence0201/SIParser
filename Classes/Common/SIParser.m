//
//  SIParser.m
//  SIParser
//
//  Created by 杨晴贺 on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIParser.h"

NSString *const SIParserDomain = @"SIParserDomain";

@implementation SIParser

- (SINodeList *)nodeListWithString:(NSString *)inString filter:(id<SINodeFilter>)inFilter{
    return nil;
}

@end

@implementation SIParser (Error)

- (NSError *)errorWithCode:(NSInteger)code UserInfo:(NSDictionary *)userInfo{
    return [NSError errorWithDomain:SIParserDomain code:code userInfo:userInfo];
}

@end
