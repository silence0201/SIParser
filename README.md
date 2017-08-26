# HTMLParser
![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)  
SIParser:一个简单的Html/XML解析器

## 使用说明

### 导入
#### 手工导入

1. 将项目下`HTMLParser`导入项目中,
2. 点击`Bulid Phases`->`Link FrameWork and Libraries`,添加`libxml2.tbd`或`libxml2.dylib`
3. 在项目设置中`Bulid Setting`->`header search paths`,添加`$(SDKROOT)/usr/include/libxml2`

#### Pod安装

	pod 'SIParser', '~> 0.1.0'

### 使用

1. 导入头文件

	```objective-c
	#import "Parser.h"
	```
	
2. 初始化Parser

	```objective-c
    NSString *htmlString = @"<username>我是username自定义样式</username><password size='20'>我是password自定义样式，注意属性内容</password>";
    SIHTMLParser *htmlParser = [[SIHTMLParser alloc] init];
	```
	
3. 查询节点信息

	```objective-c
	SINodeList *nodes = [htmlParser nodeListWithString:htmlString];
	```
	
4. 转化为富文本

	```objective-c
	//自定义样式
    NSDictionary *customStyles = @{
                                   NSForegroundColorAttributeName: [UIColor orangeColor],
                                   NSBackgroundColorAttributeName: [UIColor blueColor]
                                   };
    [htmlParser addStyle:customStyles forTag:@"username"];
    NSAttributedString *attributedString = [htmlParser parseString:htmlString];
	```
	
4. 更多使用请查看头文件说明

## HTMLParser
SIParser is available under the MIT license. See the LICENSE file for more info.