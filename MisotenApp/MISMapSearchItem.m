//
//  MISMapSearchItem.m
//  MisotenApp
//
//  Created by Masataka Nakagawa on 2016/10/15.
//  Copyright © 2016年 Masataka Nakagawa. All rights reserved.
//

#import "MISMapSearchItem.h"

@implementation MISMapSearchItem

+(NSArray *)searchItemIconArray {
    NSArray *itemIconArray = [[NSArray alloc] initWithObjects:@"Monastery",@"Restaurant",@"Inn",@"Monastery",@"Restaurant",@"Inn",@"Monastery",@"Restaurant",@"Inn", nil];
    
    
    return itemIconArray;
}

+(NSArray *)searchItemStringArray {
    NSArray *itemStringArray = [[NSArray alloc] initWithObjects:@"ミュージアム",@"レストラン",@"アミューズ\nメントパーク",@"バー",@"カフェ",@"ホテル",@"洋服店",@"公園",@"名所案内", nil];
    return itemStringArray;
}

@end
