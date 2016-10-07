

#ifndef ThirdPartShareDefines_h
#define ThirdPartShareDefines_h



//  http://www.umeng.com/  友盟账号密码 bruce@cgyyg.com Cg123456

//第三方登录及分享
#define WX_APP_ID @"wx9901c32e6080fe90"
#define WX_APP_SECRET @"b673df96347d02af80c85ef4084e7d9d"
#define WX_API(code) [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APP_ID,WX_APP_SECRET,code]

#define QQ_APP_ID @"101267345"
#define QQ_APP_Key @"07b168488647071c608659bdedb078e5"

#define Sina_APP_ID @"3483157153"
#define Sina_APP_Key @"2c828ddb693249d44064d5b6ccb433ba"

#define UMSocaial_APPKEY @"571205c467e58e6232000099"

#define FWPartnerID_pp @"4000104109100146162"


//设备
#define Devices_Systems @"Devices_systems"
#define Device_Token @"Device_Token"



#endif /* ThirdPartShareDefines_h */
