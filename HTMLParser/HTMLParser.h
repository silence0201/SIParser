//
//  HTMLParser.m
//  HTMLParserDemo
//
//  Reference StackOverflow
//  Created by 杨晴贺 on 21/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>


typedef NS_ENUM(NSInteger,HTMLNodeType) {
    HTMLHrefNode,
    HTMLTextNode,
    HTMLUnkownNode,
    HTMLCodeNode,
    HTMLSpanNode,
    HTMLPNode,
    HTMLLiNode,
    HTMLUlNode,
    HTMLImageNode,
    HTMLOlNode,
    HTMLStrongNode,
    HTMLPreNode,
    HTMLBlockQuoteNode,
};

@interface HTMLNode : NSObject{
@public
    xmlNode *_node ;
}

- (instancetype)initWithXMLNode:(xmlNode *)xmlNode ;

- (HTMLNode *)findChildOfClass:(NSString *)className ;

- (NSArray *)findChildrenOfClass:(NSString *)className ;

- (HTMLNode *)findChildWithAttribute:(NSString *)attribute matchingName:(NSString *)className allowPartial:(BOOL)partial ;

- (NSArray *)findChildrenWithAttribute:(NSString *)attribute matchingName:(NSString *)className allowPartial:(BOOL)partial ;

- (NSString *)getAttributeNamed:(NSString *)name ;

- (NSArray *)findChildTags:(NSString *)tagName ;

- (HTMLNode *)findChildTag:(NSString *)tagName ;

- (HTMLNode *)firstChild ;

- (NSString *)contents ;

- (NSString *)allContents ;

- (NSString *)rawContents ;

- (HTMLNode *)nextSibling ;

- (HTMLNode *)previousSibling ;

- (NSString *)className ;

- (NSString *)tagName ;

- (HTMLNode *)parent ;

- (NSArray*)children ;

- (HTMLNodeType)nodetype ;


//C functions for minor performance increase in tight loops
NSString * getAttributeNamed(xmlNode * node, const char * nameStr);
void setAttributeNamed(xmlNode * node, const char * nameStr, const char * value);
HTMLNodeType nodeType(xmlNode* node);
NSString * allNodeContents(xmlNode*node);
NSString * rawContentsOfNode(xmlNode * node);

@end

@interface HTMLParser : NSObject{
@public
    htmlDocPtr _doc ;
}

- (instancetype)initWithContentsOfURL:(NSURL*)url error:(NSError**)error ;
- (instancetype)initWithData:(NSData*)data error:(NSError**)error ;
- (instancetype)initWithString:(NSString*)string error:(NSError**)error ;

- (HTMLNode*)doc;

- (HTMLNode*)body;

- (HTMLNode*)html;

- (HTMLNode*)head;

@end
