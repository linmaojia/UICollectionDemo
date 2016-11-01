//
//  NetworkMacro.h
//  ETao
//
//  Created by AVGD on 15/9/22.
//  Copyright © 2015年 jacky. All rights reserved.
//

#define ClientId        @"0c73bc72abb5bed090f4e7f5bd558bfe"         //客户端ID
#define ClientSecret    @"beef7f43766ea1161ccac32e50c4a433"         //密钥

//本地环境
//#define LocalEnvironment
//测试环境
//#define testingEnvironment
//正式环境
#define OfficialEnvironment

/**
 *  APIURL 服务器地址
 *  ApiKey 可选
 */

#ifdef LocalEnvironment
#define APIURL              @"http://192.168.0.49:9000"
#define ApiKey              @"900000001"
#endif

#ifdef testingEnvironment
#define APIURL              @"http://121.40.85.110:9050"
#define ApiKey              @"900000002"
#endif

#ifdef OfficialEnvironment
#define APIURL              @"http://etaoapi.edsmall.cn"
#define ApiKey              @"900000003"
#endif

#pragma mark - 了解E淘(版本新特性界面)
#define APIKnowETao                     [APIURL stringByAppendingString:@"/v1/etao/knowEtaoImgs"]
#define APINewfeature                   [APIURL stringByAppendingString:@"/v1/etao/homePages"]

#pragma mark - 注册

//注册验证码(验证码校验)
#define APIRegistrationCode             [APIURL stringByAppendingString:@"/v1/msm/registrationCode/"]
//注册
#define APIRegistration                 [APIURL stringByAppendingString:@"/v1/user"]

#pragma mark - 登录

//获取AuthorizationCode(获取权限码)
#define APIGetAuthorizationCode        [APIURL stringByAppendingString:@"/v1/oauth2/auth"]
//获取AccessToken(获取令牌)
#define APIGetAccessToken              [APIURL stringByAppendingString:@"/v1/oauth2/token"]

#pragma mark - 找回密码(重置密码)
//发送验证码到手机
#define APIFindPassword                 [APIURL stringByAppendingString:@"/v1/msm/sendMsg/"]
//更新密码
#define APIUpdatePassword               [APIURL stringByAppendingString:@"/v1/msm/updatePwd"]

#pragma mark - 淘淘淘
//淘淘淘首页
#define APIGetTTT                       [APIURL stringByAppendingString:@"/v2/ttt"]
//淘淘淘爆款推荐
#define APIGetTTTProducts               [APIURL stringByAppendingString:@"/v2/listBlast"]
//筛选商品列表
#define APIGetScreenGoodsList           [APIURL stringByAppendingString:@"/v2/product"]
//获取商品详情
#define APIGoodsDetails                 [APIURL stringByAppendingString:@"/v1/product/"]
//分品牌搜索
#define APIScreenBrand                  [APIURL stringByAppendingString:@"/v1/collection/brandstyle"]
//全局筛选列表
#define APIBuyScreenList                [APIURL stringByAppendingString:@"/v2/collection/list"]
//获取查询商品个数
#define APIBuyScreenCount               [APIURL stringByAppendingString:@"/v1/screening"]
//同系列产品
#define APISameProducts                 [APIURL stringByAppendingString:@"/v1/productSeries/"]

#pragma mark - 个人信息
//用户个人信息
#define APIUserInformation              [APIURL stringByAppendingString:@"/v1/user"]
//上传用户头像
#define APIUploadUserImage              [APIURL stringByAppendingString:@"/v1/user/upload"]
//修改用户信息
#define APIUserChange                   [APIURL stringByAppendingString:@"/v1/user"]

#pragma mark - 个人信息（收货地址）
//收货地址
#define APIGetAddressList               [APIURL stringByAppendingString:@"/v1/address"]
//地区列表
#define APIAreaList                     [APIURL stringByAppendingString:@"/v1/returnAddressList"]
//添加收货地址
#define APIAddAddress                   [APIURL stringByAppendingString:@"/v1/address"]
//删除收货地址
#define APIDeleteAddress                [APIURL stringByAppendingString:@"/v1/address/"]
//设置默认收货地址
#define APIDefultAddress                [APIURL stringByAppendingString:@"/v1/address/setDefault/"]
//获取默认收货地址
#define APIGetDefultAddress             [APIURL stringByAppendingString:@"/v1/getDefaultAddress"]

#pragma mark - 购物车
//购物车列表
#define APIGetShoppingCarList           [APIURL stringByAppendingString:@"/v1/cart/"]
//修改购物车
#define APIShoppingCarCountChange       [APIURL stringByAppendingString:@"/v1/cart/"]
//删除购物车
#define APIShoppingCarDelete            [APIURL stringByAppendingString:@"/v1/cart/"]
//添加购物车
#define APIAddShopingCar                [APIURL stringByAppendingString:@"/v1/cart"]
//获取购物车商品数量
#define APIShoppingCarCount             [APIURL stringByAppendingString:@"/v1/cartQty"]

#pragma mark - 订单
//添加订单
#define APIOrderAdd                     [APIURL stringByAppendingString:@"/v1/order"]
//删除订单
#define APIOrderDelete                  [APIURL stringByAppendingString:@"/v1/order/"]
//取消订单
#define APIOrderClose                   [APIURL stringByAppendingString:@"/v1/order/"]
//订单列表
#define APIGetOrderList                 [APIURL stringByAppendingString:@"/v1/order/"]
//订单详情
#define APIOrderDetails                 [APIURL stringByAppendingString:@"/v1/order/"]
//订单确认
#define APIOrderConfirm                 [APIURL stringByAppendingString:@"/v1/order/finish/"]
//订单再购买
#define APIOrderBuyAgain                [APIURL stringByAppendingString:@"/v1/order/recart/"]

#pragma mark - 收藏
//添加商品收藏
#define APICollectAdd                   [APIURL stringByAppendingString:@"/v1/collection/addProduct/"]
//获取商品收藏列表
#define APICollectGoodsList             [APIURL stringByAppendingString:@"/v1/collection/product?rowsPerPage=10&pageNumber="]
//添加品牌收藏
#define APIBrandAdd                     [APIURL stringByAppendingString:@"/v1/collection/addBrand/"]
//获取品牌收藏列表
#define APICollectBrandsList            [APIURL stringByAppendingString:@"/v1/collection/brand?rowsPerPage=10&pageNumber="]
//获取浏览历史列表
#define APICollectHistoryList           [APIURL stringByAppendingString:@"/v1/collection/record?rowsPerPage=10&pageNumber="]
//删除商品收藏
#define APICollectDelete                [APIURL stringByAppendingString:@"/v1/collection/product/"]
//删除店铺收藏
#define APIBrandDelete                  [APIURL stringByAppendingString:@"/v1/collection/brand/"]
//删除历史记录
#define APIHistoryDelete                [APIURL stringByAppendingString:@"/v1/collection/clearBrowse/"]
//删除所有历史记录
#define APIHistoryAllDelete             [APIURL stringByAppendingString:@"/v1/collection/clearBrowse"]

#pragma mark - 认证
//ETao认证信息获取
#define APIApproveETaoInformation       [APIURL stringByAppendingString:@"/v1/etao/authentic"]
//ETao认证上传认证个人资料
#define APIApproveUser                  [APIURL stringByAppendingString:@"/v1/etao/authentic"]
//ETao认证上传认证图片
#define APIApproveImage                 [APIURL stringByAppendingString:@"/v1/etao/authentic/upload"]
//商城认证信息获取
#define APIApproveMallInformation       [APIURL stringByAppendingString:@"/v1/eds/authentic"]
//商城认证上传认证个人资料
#define APIApproveUserMall              [APIURL stringByAppendingString:@"/v1/eds/authentic"]
//商城认证上传认证图片
#define APIApproveImageMall             [APIURL stringByAppendingString:@"/v1/eds/authentic/upload"]

#pragma mark - 支付
//获取支付URL
#define APIPay                          [APIURL stringByAppendingString:@"/v1/alipay/instantcredit/mobile?orderIds="]

#pragma mark - 店铺信息
//店铺信息
#define APIShopInformation              [APIURL stringByAppendingString:@"/v1/instore/"]
//店铺所有商品
#define APIShopAllProduct               [APIURL stringByAppendingString:@"/v1/brandProductList/"]
//店铺新品
#define APIShopNewProduct               [APIURL stringByAppendingString:@"/v1/newAddProduct/"]
//公司信息
#define APIShopCompanyInformation       [APIURL stringByAppendingString:@"/v1/mer/"]
//客服信息
#define APIShopServices                 [APIURL stringByAppendingString:@"/v1/cserver/"]

#pragma mark - 帮助中心
//帮助中心
#define APIHelpCenter                   @"http://wiki.edsmall.cn/?p=33228"
//EDS和E淘账号区别
#define APIDifference                   @"http://wiki.edsmall.cn/?p=33226"
//E淘协议
#define APIProtocol                     @"http://wiki.edsmall.cn/?p=33615"

#pragma mark - 退款
//上传退款申请
#define APIDrawbackInformation          [APIURL stringByAppendingString:@"/v1/refundForAndroid"]
//上传退款凭证
#define APIDrwabackImage                [APIURL stringByAppendingString:@"/v1/refund/uploadForAndroid/"]
//删除退款凭证
#define APIDrawbackDeleteImage          [APIURL stringByAppendingString:@"/v1/refund/deleteImg/"]
//获取退款详细资料
#define APIRefundDetails                [APIURL stringByAppendingString:@"/v1/refund/"]
//修改退款信息
#define APIRefundChangeInformation      [APIURL stringByAppendingString:@"/v1/refund/update"]
//修改退款图片
#define APIRefundChangeImage            [APIURL stringByAppendingString:@"/v1/refund/updateImg/"]
//撤销退款
#define APIRefundCancel                 [APIURL stringByAppendingString:@"/v1/cancelRefund/"]


#pragma mark - 垃圾代码
#define APIRefundProccessImg            [APIURL stringByAppendingString:@"/v1/refundProccessImg"]
#define APIRefundCSImg                  [APIURL stringByAppendingString:@"/v1/refundCSImg"]
