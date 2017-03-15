//
//  MyTapGestureRecognizer.h
//  ITIW
//
//  Created by ITIW on 9/24/14.
//  Copyright (c) 2014 ITIW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTapGestureRecognizer : UITapGestureRecognizer
{
    int tag;
    NSString *currentTile;
}
@property (readwrite, assign) int tag;
@property (nonatomic, retain) NSString *currentTitle;

@end
