//
//  ViewController.m
//  HTMLParserDemo
//
//  Created by 杨晴贺 on 21/01/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "ViewController.h"
#import "HTMLParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"] ;
    NSData *htmlData = [NSData dataWithContentsOfFile:path] ;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:htmlData error:&error] ;
    HTMLNode *body = [parser body] ;
    
    NSArray *array = [body findChildrenOfClass:@"cell item"] ;
    NSArray *a = [array.firstObject findChildrenTag:@"a"] ;
    for (HTMLNode *node in a){
        NSLog(@"%@",[node contents]) ;
    }
}


@end
