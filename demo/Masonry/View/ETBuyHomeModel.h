//
//  ETBuyHomeModel.h
//  Masonry
//
//  Created by LXY on 16/5/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETHotProductsModel.h"

@class Bannders, Dict, Styles,Types,Spaces,Hot;
@interface ETBuyHomeModel : NSObject

@property (nonatomic,strong) NSArray <Bannders *> *bannders;
@property (nonatomic,strong) Dict *dict;

@end



@interface Dict :NSObject
@property (nonatomic,strong) NSArray <Styles *> *styles;
@property (nonatomic,strong) NSArray <Types *> *types;
@property (nonatomic,strong) NSArray <Spaces *> *spaces;
@property (nonatomic,strong) NSArray <Hot *> *hot;


@end

@interface SuperDict : NSObject
@property (nonatomic,strong) NSString *picUri;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *dcId;
@property (nonatomic,strong) NSString *type;
@end


@interface Styles :SuperDict

@end

@interface Types :SuperDict

@end

@interface Spaces :SuperDict

@end

@interface Hot :SuperDict

@end


@interface Bannders : NSObject
@property (nonatomic,strong) NSString *picUri;
@end
