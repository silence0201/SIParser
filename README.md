# HTMLParser
![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)  
HTMLParser:一个简单的Html解析器`Reference StackOverflow`

## 使用说明

### 导入
#### 手工导入

1. 将项目下`HTMLParser`导入项目中,
2. 点击`Bulid Phases`->`Link FrameWork and Libraries`,添加`libxml2.tbd`或`libxml2.dylib`
3. 在项目设置中`Bulid Setting`->`header search paths`,添加`$(SDKROOT)/usr/include/libxml2`

#### Pod安装

	pod 'SIHTMLParser', '~> 1.0'

### 使用

1. 导入头文件

	```objective-c
	#import "HTMLParser.h"
	```
	
2. 初始化Parser

	```objective-c
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"] ;
    NSData *htmlData = [NSData dataWithContentsOfFile:path] ;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:htmlData error:&error] ;
	```
	
3. 查询节点信息

	```objective-c
	HTMLNode *body = [parser body] ;
    
    NSArray *array = [body findChildrenOfClass:@"cell item"] ;
    NSArray *a = [array.firstObject findChildTags:@"a"] ;
    for (HTMLNode *node in a){
        NSLog(@"%@",[node contents]) ;
    }
	```
	
4. 更多使用请查看头文件说明

## HTMLParser
HTMLParser is available under the MIT license. See the LICENSE file for more info.