//
//  APPContentViewController.h
//  RSSreader
//
//  Created by Allen Hsiao on 13/03/2017.
//  Copyright © 2017 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APPContentViewController : UIViewController <NSXMLParserDelegate>

@property (copy, nonatomic) NSString *urlString;

@property (copy, nonatomic) NSString *titleString;

@end
