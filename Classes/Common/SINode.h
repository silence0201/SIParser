//
//  SINode.h
//  SIParser
//
//  Created by Silence on 2017/8/25.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>

@class SINodeList;
@class SINode;
@interface SINode : NSObject

@property (nonatomic, assign) xmlNodePtr node;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *attributes;

- (instancetype)initWithXmlNode:(xmlNodePtr)inNode;
- (void)addAttributes:(NSDictionary *)inAttributes;

@end

@interface SINodeList : NSObject

- (void)addNode:(SINode *)node;
- (void)addNodeList:(SINodeList *)nodeList;
- (NSUInteger)count;
- (SINode *)nodeWithIndex:(NSInteger)index;
- (NSArray<SINode *> *)nodes;
- (SINode *)removeNodeWithIndex:(NSInteger)index;
- (void)removeAllNodes;
- (BOOL)containsNode:(SINode *)node;
- (BOOL)removeNode:(SINode *)node;

@end
