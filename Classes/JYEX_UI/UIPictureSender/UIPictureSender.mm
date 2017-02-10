//
//  UIPictureSender.m
//  JYEX
//
//  Created by zd on 13-12-24.
//  Copyright (c) 2013年 洋基科技. All rights reserved.
//

#import "UIPictureSender.h"
#import "CImagePicker.h"
#import "PubFunction.h"
#import "UIXCSelect.h"
#import "UIImageEditorVC.h"
#import "CommonAll.h"
#import "UIImage+Scale.h"
//#import "UIPresentImage.h"
#import "BizLogic_Note.h"
#import "UIAstroAlert.h"
#import "CImagePicker.h"
#import "UIPictureZLVC.h"
#import "GlobalVar.h"
#import "YcKeyBoardView.h"
#import "MJPhotoBrowser.h"
#import "HelpView.h"
#import "GlobalPictureCounter.h"
#import "Global.h"


#define kWinSize [UIScreen mainScreen].bounds.size


#define MAXCOUNT_PICTURESELECTED 30

@interface UIPictureSender ()<UITextViewDelegate,YcKeyBoardViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
}

/////
@property (nonatomic,retain) YcKeyBoardView *key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;

@end

@implementation UIPictureSender
@synthesize pictureList ;
@synthesize imageViewList ;
@synthesize pinLunLabelList ;
@synthesize currentXCName ;
@synthesize currentXCID ;
@synthesize currentXCUid;
@synthesize currentXCUsername;
@synthesize curEditSelectPicture ;
@synthesize EditSelect ;
@synthesize PictureFileList ;
@synthesize Wait ;
@synthesize PictureZL ;
@synthesize callDic ;
@synthesize msgParam;
@synthesize bussRequest;


- (void)dealloc
{
    NSLog(@"----UIPictureSender dealloc");
    
    [CPictureSelected ResetID] ;
    
    [self removeAllImageView] ;
    
    self.pictureList = nil ;
    self.imageViewList = nil ;
    self.currentXCName = nil ;
    self.currentXCID = nil;
    self.currentXCUid = nil;
    self.currentXCUsername = nil;
    self.pinLunLabelList = nil ;
    self.msgParam = nil;
    
    [self.bussRequest cancelBussRequest] ;
    self.bussRequest = nil ;
    
    SAFEREMOVEANDFREE_OBJECT(txfPicTYMS);
    SAFEREMOVEANDFREE_OBJECT(lbXCName) ;
    SAFEREMOVEANDFREE_OBJECT(lbAddXPInfo) ;
    SAFEREMOVEANDFREE_OBJECT(lbtitle) ;
    SAFEREMOVEANDFREE_OBJECT(btnBack) ;
    SAFEREMOVEANDFREE_OBJECT(btnNavFinish) ;
    SAFEREMOVEANDFREE_OBJECT(btnXCName) ;
    SAFEREMOVEANDFREE_OBJECT(ivFlag) ;
    SAFEREMOVEANDFREE_OBJECT(svPictureList) ;
    SAFEREMOVEANDFREE_OBJECT(m_lbXCType);
    
    [super dealloc] ;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        //[CImagePicker sharedInstance] ;
        bCameraFirst = YES ;
        self.pictureList = [NSMutableArray array] ;
        self.imageViewList = [NSMutableArray array] ;
        self.currentXCName = @"" ;
        self.currentXCID = @"";
        self.currentXCUid = TheCurUser.sUserID; //2014.9.26
        self.currentXCUsername = TheCurUser.sUserName; //2014.9.26
        self->EditSelect = NO ;
        [CPictureSelected ResetID] ;
        self->editor = nil ;
        //self->vWait = nil ;
        self->Wait = NO ;
        //self->waitWindow = nil ;
        self->PictureZL = 0 ;
        callDic = nil;
        self.pinLunLabelList = [NSMutableArray array] ;
    }
    return self;
}

- (void)showHelp
{
    NSString *strImgFile = @"" ;
    NSString *path = @"" ;
    int osType = 6 ;
    float osv = [[[UIDevice currentDevice] systemVersion] floatValue];
    if( osv < 7.0 )
    {
        osType = 6 ;
    }
    if( osv >= 8.0 )
    {
        osType = 8 ;
    }
    if( osv >= 7.0 && osv < 8.0 )
    {
        osType = 7 ;
    }
    
    switch (osType) {
        case 6:
            strImgFile = @"SendImageHelp6" ;
            path = [[NSBundle mainBundle] pathForResource:strImgFile ofType:@"png"];
            strImgFile = path;
            break;
        case 7:
            strImgFile = @"SendImageHelp7" ;
            path = [[NSBundle mainBundle] pathForResource:strImgFile ofType:@"png"];
            strImgFile = path;
            break ;
        case 8:
            strImgFile = @"SendImageHelp8" ;
            path = [[NSBundle mainBundle] pathForResource:strImgFile ofType:@"png"];
            strImgFile = path;
            break ;
        default:
            break;
    }
    
    /*
    NSString *showKey = @"JYEX_PICSEND_HeLP_SHOW";
    NSString *showValue = [[NSUserDefaults standardUserDefaults] objectForKey:showKey];
    if( showValue == nil || [showValue isEqualToString:@""] )
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:showKey];
        //显示帮助图片
        HelpView *hv = [[HelpView alloc] initWithFrame:CGRectMake(0,0,kWinSize.width,kWinSize.height)];
        hv->bgImgView.image = [UIImage imageWithContentsOfFile:strImgFile];
        [[[UIApplication sharedApplication] keyWindow] addSubview:hv];
        [hv release];
        return ;
    }
    
    if( ![showValue isEqualToString:@"1"] )
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:showKey];
        //显示帮助图片
        HelpView *hv = [[HelpView alloc] initWithFrame:CGRectMake(0,0,kWinSize.width,kWinSize.height)];
        hv->bgImgView.image = [UIImage imageWithContentsOfFile:strImgFile];
        [[[UIApplication sharedApplication] keyWindow] addSubview:hv];
        [hv release];
    }
    */
}


- (void)setXCInfo
{
    if( self.msgParam )
    {
        if ( self.msgParam.param1 && [self.msgParam.param1 isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = self.msgParam.param1;
            if ( dic ) {
                [self setXCName:dic];
                return;
            }
        }
    }
    
    //获取上次选择相册
    NSDictionary *dic = [self readXCParam];
    if (dic ) {
        [self setXCParamValue:dic];
        return;
    }
    
    //从网络读取
    [self QueryJYEXAlbumList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setXCInfo] ;
    [[GlobalPictureCounter getGlobalPictureCounterInstance] setPictureCount:0];
    self->curEditSelectPicture = 0 ;
    
    
    //NSLog( @"UiPictureSender.self count=%d",[self retainCount]) ;
    
    bFirst = YES;
    //[self onAddPicture:nil];
    
    //NSLog( @"UiPictureSender.self count=%d",[self retainCount]) ;
    
    int count = MAXCOUNT_PICTURESELECTED;
    NSString *str = [NSString stringWithFormat:@"还可添加%i张", count];
    [self updateAddPicInfo:str];
    
    [self showHelp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancel:(id)sender
{
    //NSLog( @"取消.self count=%d",[self retainCount]) ;
    //删除文件
    NSFileManager *fm = nil ;
    NSError *error = nil ;
    for( CPictureSelected *pic in self.pictureList )
    {
        fm = [NSFileManager defaultManager] ;
        [fm removeItemAtPath:pic.strPictureFileBig error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
        error = nil ;
        [fm removeItemAtPath:pic.strPictureFileSmall error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
    }
    [self.navigationController popViewControllerAnimated:YES] ;
}



- (IBAction)onOK:(id)sender
{
    NSLog( @"发表.") ;
    
    if ( [self.pictureList count] == 0 ) {
        [UIAstroAlert info:@"请先选择照片" :2.0 :NO :0 :NO];
        return;
    }
    
    if ( self.currentXCID == nil || [self.currentXCID isEqualToString:@""] ) {
        [UIAstroAlert info:@"请先选择相册" :2.0 :NO :0 :NO];
        return;
    }
    
    
    NSString *strTYPL = [NSString stringWithFormat:@"%@",txfPicTYMS.text];
    
    //生成图片文件保存到指定目录，并保存文件的名字
    BOOL result = NO ;
    for( CPictureSelected *pic in self.pictureList )
    {
        NSString *strDate = [CommonFunc getCurrentDate];//2014.9.18
        if( pic.strPinLun != nil && ![pic.strPinLun isEqualToString:@""])
        {
            strDate = pic.strPinLun ;
        }
        else
        {
            
            if( strTYPL != nil && ![strTYPL isEqualToString:@""])
            {
                strDate = strTYPL;
            }
        }
        
        result = [BizLogic addPic:pic.strFileName title:strDate albumname:self.currentXCName albumid:self.currentXCID uid:self.currentXCUid username:self.currentXCUsername] ;
        if( result == NO )
        {
            NSLog( @"保存上传文件:[%@]失败", pic.strFileName ) ;
        }
    }
    [self.navigationController popViewControllerAnimated:YES] ;
}


- (IBAction)onSelectXC:(id)sender
{
    NSLog( @"相册选择" ) ;
    
    [PubFunction SendMessageToViewCenter:NMJYEXSelectAlbum :0 :1 :[MsgParam param:self :@selector(setXCName:) :@"0" :0]];
    
    /*
    UIXCSelect *vc = [[UIXCSelect alloc] initWithNibName:@"UIXCSelect" bundle:nil];
    vc.callBackObject = self ;
    vc.callBackSel = @selector(setXCName:) ;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    */
}

- (IBAction)onAddPicture:(id)sender
{
    [[GlobalPictureCounter getGlobalPictureCounterInstance] setPictureCount:(int)[self.pictureList count]];
    if( [self.pictureList count] >=  MAXCOUNT_PICTURESELECTED)
    {
        [UIAstroAlert info:@"不能增加照片了，所选相片数量已达最大限制" :2.0 :NO :0 :NO];
        return ;
    }
    NSLog( @"添加照片" ) ;
    //self.Wait = YES ;
    //[self.pictureList removeAllObjects] ;
    CImagePicker *imagepicker = [CImagePicker sharedInstance] ;
    //imagepicker.maxCount = MAXCOUNT_PICTURESELECTED ;
    imagepicker.maxCount = MAXCOUNT_PICTURESELECTED - (int)[self.pictureList count] ;
    imagepicker.callObject = self ;
    imagepicker.callBack = @selector(pictureSelect:) ;
    [imagepicker selectImage:self];
    
    /*
    int i = 10 ;
    CGRect frame ;
    UIImageView *iv = nil ;
    for( i = 0 ; i < 180 ; i++ )
    {
        frame = [self getImageFrame:i] ;
        iv = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        iv.image = [UIImage imageNamed:@"btn_TouLan_Folder-3.png"] ;
        iv.backgroundColor = [UIColor redColor] ;
        iv.tag = i ;
        iv.userInteractionEnabled = YES ;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:) ];
        [iv addGestureRecognizer:singleTap] ;
        
        [singleTap release] ;
        [svPictureList addSubview:iv];
    }
    */
}

//add by zd 2015-01-12
- (IBAction)onAddPictureFromCamera:(id)sender
{
    if( [self.pictureList count] >=  MAXCOUNT_PICTURESELECTED)
    {
        [UIAstroAlert info:@"不能增加照片了，所选相片数量已达最大限制" :2.0 :NO :0 :NO];
        return ;
    }
    [self loadCamera] ;
    
    
    //MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    //browser.photos = photos; // 设置所有的图片
    //[browser show];
}

- (IBAction)onAddPictureFromAlbum:(id)sender
{
    if( [self.pictureList count] >=  MAXCOUNT_PICTURESELECTED)
    {
        [UIAstroAlert info:@"不能增加照片了，所选相片数量已达最大限制" :2.0 :NO :0 :NO];
        return ;
    }
    [self onAddPicture:sender];
}

//add by zd 2015-01-12
//更新还可增加多少张相片
- (void)updateAddPicInfo:(NSString*)info
{
    self->lbAddXPInfo.text = info ;
}

- (void)clickPicture:(id)sender
{
    int index = (int)((UIImageView*)((UITapGestureRecognizer*)sender).view).tag ;
    NSLog( @"单击相片[%i]", index ) ;
    self.curEditSelectPicture = index ;
    self.EditSelect = YES ;
    
    //UIActionSheet *asv = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"描述照片" otherButtonTitles:@"编辑照片",@"预览照片",@"删除照片",@"删除全部照片", nil];
    UIActionSheet *asv = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"描述照片" otherButtonTitles:@"编辑照片",@"删除照片",@"删除全部照片", nil];
    
     //[asv showInView:self.view];
    [asv showInView:[UIApplication sharedApplication].keyWindow] ;
    [asv release] ;
}

- (CGRect)getImageFrame:(int)index
{
    CGRect frame = CGRectMake(0, 0, 0, 0) ;
    int a,b ;
    float x,y,w,h;
    
    if( index < 0 ) return frame ;
    
    b = index % 4 ;
    a = (index - b) / 4 ;
    
    NSLog( @"(%i,%i)", a, b ) ;
    
    w = ( svPictureList.frame.size.width - 5 * 5 ) / 4 ;
    h = w ;
    
    x = 5 + (w+5) * b ;
    y = 5 + (h+5) * a ;
    
    frame = CGRectMake( x, y, w, h ) ;
    
    return frame ;
}

- (CGRect)getPinLunLabelFrame:(int)index
{
    CGRect frame = CGRectMake(0, 0, 0, 0) ;
    frame = [self getImageFrame:index];
    frame.origin.x = 0 ;
    frame.origin.y = 0 + frame.size.height - 16.0f;
    frame.size.height = 16.0f;
    return frame ;
}

- (void)pictureSelect:(NSMutableArray*)pictureArray
{
    CPictureSelected *picselect = nil ;
    
    
    for(ALAsset *obj in pictureArray )
    {
       if( ![self pictureIsSelected:obj] )
       {
           picselect = [[CPictureSelected alloc] init] ;
           [picselect initFileName];
           picselect.picAlasset = obj ;
           [self.pictureList addObject:picselect] ;
           [self saveSelectPicture:picselect] ;
           [picselect release];
           
       }
    }
    
    //将选择的相片显示出来
    NSLog( @"%@", self.pictureList ) ;
    
    //更新显示
    NSLog( @"start update view" ) ;
    [self performSelectorOnMainThread:@selector(updateImageViewAfterSelect) withObject:nil waitUntilDone:NO];
    
}


- (void)updateImageViewAfterSelect
{
    [self removeAllImageView ] ;
    
    UILabel *lbpl = nil ;
    
    int i = 0 ;
    CGRect frame ;
    UIImageView *iv = nil ;
    //CGImageRef  ref = nil ;
    UIImage *img = nil ;
    for(CPictureSelected *p in self.pictureList )
    {
        frame = [self getImageFrame:i] ;
        iv = [[[UIImageView alloc] initWithFrame:frame] autorelease];
        if( !p.editFlag )
        {
            /*
            ref = [p.picAlasset thumbnail];
            img = [[UIImage alloc] initWithCGImage:ref] ;
            img = [CImagePicker fixOrientation:img] ;
            iv.image = img ;
            [img release] ;
             */
            img = [UIImage imageWithContentsOfFile:p.strPictureFileSmall];
            iv.image = img ;
        }
        else
        {
            img = [UIImage imageWithContentsOfFile:p.strPictureFileSmall];
            iv.image = img ;
        }
        iv.tag = p.ID ;
        iv.userInteractionEnabled = YES ;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture:) ];
        [iv addGestureRecognizer:singleTap] ;
        [singleTap release] ;
        [svPictureList addSubview:iv] ;
        [self.imageViewList addObject:iv] ;
        
        //处理评论标签
        //lbpl = p.lbPinLun ;
        //if( lbpl == nil )
        {
            lbpl = [self createPinLunLabel:[self getPinLunLabelFrame:i]];
            [iv addSubview:lbpl] ;
            [self.pinLunLabelList addObject:lbpl] ;
            p.lbPinLun = lbpl;
            lbpl.text = p.strPinLun ;
            lbpl.hidden = YES ;
            [lbpl release];
        }
        if( p.strPinLun !=  nil && ![p.strPinLun isEqualToString:@""] )
        {
            lbpl.hidden = NO ;
        }
        
        i++ ;
    }
    
    [self->lbtitle setText:[NSString stringWithFormat:@"传照片(%i)", (int)[self.pictureList count]]] ;
    float h = [UIScreen mainScreen].bounds.size.width / 4.0 ;
    h = h * ([self.imageViewList count] / 3 + 1) ;
    CGSize size = {0,0} ;
    size = self->svPictureList.frame.size ;
    if( size.height < h )
    {
        [self->svPictureList setContentSize:CGSizeMake(size.width, h)] ;
    }
    
    //更新还可上传多少张相片
    int count = MAXCOUNT_PICTURESELECTED - (int)[self.pictureList count] ;
    NSString *str = [NSString stringWithFormat:@"还可添加%i张", count];
    [self updateAddPicInfo:str];
}


- (void)removeAllImageView
{
    for( UIImageView *v in self->imageViewList )
    {
        [v removeFromSuperview];
    }
    [self.imageViewList removeAllObjects];
    
}


/*
- (void)setXCName:(NSString*)name
{
    NSString *result = nil ;
    
    if( name == nil || name.length == 0 )
    {
        
        result = [NSString stringWithFormat:@"%@  [选择相册]", @"默认相册名称" ];
    }
    else
    {
        self.currentXCName = name ;
        result = [NSString stringWithFormat:@"%@  [选择相册]", name ];
    }
    [btnXCName setTitle: result forState:UIControlStateNormal];
}*/

- (void)setXCName:(NSDictionary*)dic
{
    [self setXCParamValue:dic];
    [self saveXCParam:dic];
    
}

-(void)setXCParamValue:(NSDictionary*)dic
{
    NSString *xcname = nil ;
    NSString *xcid = nil ;
    
    if( dic )
    {
        xcname = [dic objectForKey:@"albumname"] ;
        xcid = [dic objectForKey:@"albumid"] ;
        self.currentXCID = xcid ;
        self.currentXCName = xcname ;
        self.currentXCUid = [dic objectForKey:@"uid"]; //2014.9.26
        self.currentXCUsername = [dic objectForKey:@"nickname"]; //2014.9.26
        
        
        //统一的图片评论
        NSString *strTYPL = [self.callDic objectForKey:@"picTYPL"];
        if ( strTYPL )
            self->txfPicTYMS.text = strTYPL ;
    
        lbXCName.text = self.currentXCName ;
    
        TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
        if( [u isInfantsSchoolTeacher] || [u isMiddleSchoolTeacher] ){ //教师
            if (![TheCurUser.sUserID isEqualToString:self.currentXCUid]) {
                m_lbXCType.text = @"班级相册";
            }
            else {
                m_lbXCType.text = @"个人相册";
            }
        }
    }
}


-(void)saveXCParam:(NSDictionary *)dic
{
    //班级老师的班级相册
    TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
    if( [u isInfantsSchoolTeacher] || [u isMiddleSchoolTeacher] ){ //教师
        if (![TheCurUser.sUserID isEqualToString:self.currentXCUid]) {
            NSString *strKey = [NSString stringWithFormat:@"JYEX_XCXZINFO_CLASS_%@", TheCurUser.sUserID] ;
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:strKey];
            NSLog( @"%@", [[NSUserDefaults standardUserDefaults] objectForKey:strKey] ) ;
            return;
        }
    }
    
    //个人相册或学校相册
    NSString *strKey = [NSString stringWithFormat:@"JYEX_XCXZINFO_%@", TheCurUser.sUserID] ;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:strKey];
    NSLog( @"%@", [[NSUserDefaults standardUserDefaults] objectForKey:strKey] ) ;
    
}

-(NSDictionary *)readXCParam
{
    //班级老师的班级相册
    TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
    if( [u isInfantsSchoolTeacher] || [u isMiddleSchoolTeacher] ){ //教师
        if ([_GLOBAL getAlbumTypeFlag]) {
            NSString *strKey = [NSString stringWithFormat:@"JYEX_XCXZINFO_CLASS_%@", TheCurUser.sUserID] ;
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:strKey];
            return dic;
        }
    }
    
    //个人相册或学校相册
    NSString *strKey = [NSString stringWithFormat:@"JYEX_XCXZINFO_%@", TheCurUser.sUserID] ;
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:strKey];
    return dic;
}



#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CPictureSelected *pic = nil ;
    //CGImageRef ref ;
    UIImage *img = nil ;
    //int index = 0 ;
    
    if( buttonIndex == 0 )
    {
        //描述照片
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        if(self.key==nil){
            self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
        }
        self.key.delegate=self;
        [self.key.textView becomeFirstResponder];
        //编辑照片描述
        pic = [self findPictureSelected:self.curEditSelectPicture] ;
        if( pic.strPinLun != nil && ![pic.strPinLun isEqualToString:@""] )
        {
            self.key.textView.text = pic.strPinLun ;
        }
        //self.key.textView.text = @"评论下照片吧..." ;
        self.key.textView.returnKeyType=UIReturnKeyDone;
        [self.view addSubview:self.key];
        
    }
    else if( buttonIndex  == 1 )
    {
        NSLog( @"编辑相片。。。" ) ;
        
        pic = [self findPictureSelected:self.curEditSelectPicture] ;

        img = [UIImage imageWithContentsOfFile:pic.strPictureFileBig] ;
        CGSize size = img.size ;
        if( size.width > 640 && size.height > 640 )
        {
            [CommonFunc saveJYEXPic:img fileguid:pic.strFileName mode:@"L"];
            img = [UIImage imageWithContentsOfFile: pic.strPictureFileBig] ;
        }
        
        NSLog(@"src image:size=%@, scale=%.1f, orientation=%d",NSStringFromCGSize(img.size),
              img.scale,(int)img.imageOrientation);
        
        editor = [[CLImageEditor alloc] initWithImage:img];
        editor.delegate = self;
        [self presentViewController:editor animated:YES completion:nil];
    }
    /*
    else if( buttonIndex == 2 )
    {
        NSLog( @"预览照片" ) ;
        pic = [self findPictureSelected:self.curEditSelectPicture] ;
        self.EditSelect = NO ;
        UIPresentImage *vc = [[UIPresentImage alloc] initWithNibName:@"UIPresentImage" bundle:nil];
        index = (int)[self.pictureList indexOfObject:pic] ;
        vc.m_pos = index;
        vc.m_arrItem = self.PictureFileList ;
        [self.navigationController pushViewController:vc animated:NO];
        [vc release];
    }
    */
    else if( buttonIndex == 2 )
    {
        NSLog( @"删除照片" ) ;
        self.EditSelect = NO ;
        [self deleteSelectPicture] ;
    }
    else if( buttonIndex == 3 )
    {
        NSLog( @"删除全部照片" ) ;
        self.EditSelect = NO ;
        [self deleteAllPicture] ;
    }
    else
    {
        self.EditSelect = NO ;
    }
}

- (void)SetSelect:(BOOL)flag
{
    
    UIImageView *iv = nil ;
    
    if( flag == NO )
    {
        self->ivFlag.hidden = YES ;
        return ;
    }
    
    iv = [self findEditImageView:self.curEditSelectPicture];
    CGRect frame1 = iv.frame ;
    CGRect frame2 = CGRectMake( frame1.origin.x + frame1.size.width - ivFlag.frame.size.width,
                                frame1.origin.y + frame1.size.height - ivFlag.frame.size.height,
                                ivFlag.frame.size.width,
                                ivFlag.frame.size.height ) ;
    ivFlag.frame = frame2 ;
    ivFlag.hidden = NO ;
    [self->svPictureList bringSubviewToFront:ivFlag];
    
}

//选择取消
- (void)pictureIsCancel
{
    NSLog( @"取消" ) ;
    //if ( bFirst )
        //[self.navigationController popViewControllerAnimated:NO] ;
        
}

- (void)GetSelectedPictureList:(NSMutableDictionary*)dic
{
    if( dic != nil )
    {
        [dic setObject:self.pictureList forKey:@"SELECTLIST"];
    }
}


/*
- (void)saveSelectPicture
{
    UIImage *image = nil ;
    NSData *data = nil ;
    CGImageRef ref = nil ;
    BOOL ret = YES ;
    
    
    for( CPictureSelected *obj in self.pictureList )
    {
        if( !obj.editFlag )
        {
            ref = [[obj.picAlasset defaultRepresentation] fullResolutionImage];
            image = [[UIImage alloc] initWithCGImage:ref];
            data = UIImageJPEGRepresentation( image, 0.8 ) ;
            ret = [data writeToFile:obj.strPictureFileBig atomically:YES] ;
            if( !ret )
            {
                NSLog( @"保存图片：[%@]失败", obj.strPictureFileBig ) ;
            }
            ret = [UIImage createScreenWidthImageFile:image filename:obj.strPictureFileSmall] ;
            if( !ret )
            {
                NSLog( @"保存图片：[%@]失败", obj.strPictureFileSmall ) ;
            }
            [image release] ;
        }
    }
    
}
*/


- (void)saveSelectPicture:(CPictureSelected*)pic
{
    UIImage *image = nil ;
    //NSData *data = nil ;
    CGImageRef ref = nil ;
    //BOOL ret = YES ;
    
    CPictureSelected *obj = nil ;
    
    if( pic == nil ) return ;
    
    obj = pic ;
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init] ;
    
    if( !pic.editFlag )
    {
        ALAssetRepresentation *assetRep = [obj.picAlasset defaultRepresentation];
        ref = [assetRep fullResolutionImage];
        image = [UIImage imageWithCGImage:ref scale:assetRep.scale orientation:assetRep.orientation];
        image = [CImagePicker fixOrientation:image] ;//add by zd 2014-3-26
        
        //2014.9.18
        /*
        TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
        if ( [u isInfantsSchoolMaster] || [u isMiddleSchoolMaster] ||
             [u isInfantsSchoolTeacher] || [u isMiddleSchoolTeacher]) {
            [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"H"];//用原图
        }
        else*/
        {
            switch (self.PictureZL)
            {
                case 0:
                    [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
                    break;
                case 1:
                    [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"M"];
                    break ;
                case 2:
                    [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"H"];
                    break ;
                default:
                    [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
                    break;
            }
        }

    }
    
    [pool drain] ;
}

- (void)updateImageToImageView:(CPictureSelected*)pic
{
    
    if( pic != nil )
    {
       if( pic.editFlag )
       {
           UIImageView *iv = [self findEditImageView:pic.ID] ;
           if( iv != nil )
           {
               UIImage *img = [UIImage imageWithContentsOfFile:pic.strPictureFileSmall] ;
               iv.image = img ;
           }
       }
       else
       {
           //没有修改不用改变图片
       }
    }
    self.EditSelect = NO ;
    
}

//判断是否是选过的相片
- (BOOL)pictureIsSelected:(ALAsset*)pic
{
    BOOL result = NO ;
    
    if( pic == nil ) return YES ;
    
    bFirst = NO;
    
    if( [self.pictureList count] == 0 )
    {
        return NO ;
    }
    

    
    NSMutableArray *marray = [[NSMutableArray alloc] init] ;
    
    for( CPictureSelected *obj in self.pictureList )
    {
        if( obj.editFlag == NO )
        [marray addObject:obj.picAlasset] ;
    }
    
    result = [marray containsObject:pic] ;
    
    [marray release] ;
    
    return result ;
}

- (CPictureSelected*)findPictureSelected:(int) ID
{
    CPictureSelected *p = nil ;
    
    for( CPictureSelected *obj in self.pictureList )
    {
        if( obj.ID == ID )
        {
            p = obj ;
            break ;
        }
    }
    
    return p ;
}

- (UIImageView*)findEditImageView:(int)ID
{
    UIImageView *iv = nil ;
    
    if( [self.imageViewList count] == 0 )
    {
        return nil ;
    }
    
    for( UIImageView *obj in self.imageViewList )
    {
       if( obj.tag == ID )
       {
           iv = obj ;
           break ;
       }
    }
    
    return iv ;
}


- (void)deleteSelectPicture
{
    UIImageView *iv = nil ;
    CPictureSelected *pic = nil ;
    NSFileManager *fm = nil ;
    NSError *error = nil ;
    
    iv = [self findEditImageView:self.curEditSelectPicture] ;
    pic = [self findPictureSelected:self.curEditSelectPicture] ;
    
    //删除图片文件
    if( pic != nil )
    {
        fm = [NSFileManager defaultManager] ;
        [fm removeItemAtPath:pic.strPictureFileBig error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
        error = nil ;
        [fm removeItemAtPath:pic.strPictureFileSmall error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
    }
    
    [self.imageViewList removeObject:iv] ;
    SAFEREMOVEANDFREE_OBJECT(iv) ;
    [self.pictureList removeObject:pic] ;
    
    int i = 0 ;
    for( UIImageView *obj in self.imageViewList    )
    {
        obj.frame = [self getImageFrame:i] ;
        i++ ;
    }
    self->lbtitle.text = [NSString stringWithFormat:@"传照片(%i)",(int)[self.pictureList count]] ;
    
    
    //更新还可上传多少张相片
    int count =(int)(MAXCOUNT_PICTURESELECTED - [self.pictureList count]) ;
    NSString *str = [NSString stringWithFormat:@"还可添加%i张", count];
    [self updateAddPicInfo:str];
    
}

- (void)deleteAllPicture
{
    NSFileManager *fm = nil ;
    NSError *error = nil ;
    
    for( UIImageView *obj in self.imageViewList )
    {
        [obj removeFromSuperview] ;
    }
    
    for( CPictureSelected *pic in self.pictureList )
    {
        fm = [NSFileManager defaultManager] ;
        [fm removeItemAtPath:pic.strPictureFileBig error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
        error = nil ;
        [fm removeItemAtPath:pic.strPictureFileSmall error:&error] ;
        if( error != nil )
        {
            NSLog( @"%@", error ) ;
        }
        
    }
    
    [self.imageViewList removeAllObjects] ;
    [self.pictureList removeAllObjects] ;
    self->lbtitle.text = [NSString stringWithFormat:@"传照片(%i)",(int)[self.pictureList count]] ;
    
    
    //更新还可上传多少张相片
    int count = (int)(MAXCOUNT_PICTURESELECTED - [self.pictureList count]) ;
    NSString *str = [NSString stringWithFormat:@"还可添加%i张", count];
    [self updateAddPicInfo:str];
    
}

#pragma CLImageEditorDelegate
- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image
{
    imageTemp = image ;
    NSLog( @"didFinishEdittingWithImage" ) ;

    
    //直接保存
    CPictureSelected *pic = nil ;
    
    pic = [self findPictureSelected:self.curEditSelectPicture] ;
    if( self->imageTemp != nil )
    {
        pic.editFlag = YES ;
        [CommonFunc saveJYEXPic:imageTemp fileguid:pic.strFileName mode:@"L"];
    }
    
    [self updateImageToImageView:pic] ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
    
    
}

- (void)imageEditorDidCancel:(CLImageEditor*)editor
{
    NSLog( @"imageEditorDidCancel" ) ;
    [self dismissViewControllerAnimated:YES completion:nil] ;
    if( self->editor != nil )
    {
        [self->editor release] ;
        self->editor = nil ;
    }
    self.EditSelect = NO ;
}

- (void)imageEditor:(CLImageEditor*)editor willRestoreImageView:(UIImageView*)image canceled:(BOOL)canceled;
{
    NSLog( @"willRestoreImageView" ) ;
}
- (void)imageEditor:(CLImageEditor*)editor didRestoreImageView:(UIImageView*)image canceled:(BOOL)canceled
{
    NSLog( @"didRestoreImageView" ) ;
}

/*
#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSData *data = nil ;
    BOOL ret ;
    CPictureSelected *pic = nil ;
    
    pic = [self findPictureSelected:self.curEditSelectPicture] ;
    
    if( buttonIndex == 0 )
    {
        NSLog( @"保存图片" ) ;
        if( self->imageTemp != nil )
        {
            pic.editFlag = YES ;
            data = UIImageJPEGRepresentation( self->imageTemp , 1.0 ) ;
            ret = [data writeToFile:pic.strPictureFileBig atomically:YES] ;
            if( !ret )
            {
                NSLog( @"保存图片：[%@]失败", pic.strPictureFileBig ) ;
            }
            ret = [UIImage createScreenWidthImageFile:self->imageTemp filename:pic.strPictureFileSmall] ;
            if( !ret )
            {
                NSLog( @"保存图片：[%@]失败", pic.strPictureFileSmall ) ;
            }
        }
        
    }

    [self updateImageToImageView:pic] ;
    [self dismissViewControllerAnimated:YES completion:NO] ;

}
*/

- (NSArray*)GetPictureFileList
{
    
    NSMutableArray *marray = [NSMutableArray array];
    
    for( CPictureSelected *obj in self.pictureList )
    {
        //[marray addObject:obj.strFileName] ;
        [marray addObject:obj.strPictureFileBig] ;
    }
    
    return marray ;
}

- (void)setWait:(BOOL)wait
{
    self->Wait = wait ;
    
    if( wait == YES )
    {
        [UIAstroAlert info:@"正常处理图片数据，请稍候!" :YES :NO];
        //if( self->vWait )
        //{
            //self->vWait.hidden = NO ;
        //}
        //else
        //{
           // CGRect windowRect = CGRectMake(0,200.0, [[UIScreen mainScreen] bounds].size.width, 60.0) ;
           // UIWindow *waitW = [[UIWindow alloc] initWithFrame:windowRect] ;
            //waitW.windowLevel = UIWindowLevelAlert ;
           // waitW.backgroundColor = [UIColor blueColor] ;
            //UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  320.0, 320.0*0.618)] ;
            //v.backgroundColor = [UIColor blueColor] ;
           // self->vWait = v ;
            //[waitWindow addSubview:v] ;
            //[waitW makeKeyAndVisible] ;
            //self->waitWindow = waitW ;
            
            /*
            //UIWindow *window =
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0,  320.0, 320.0*0.618)] ;
            v.backgroundColor = [UIColor blueColor] ;
            //v.hidden = YES ;
            UIWindow *w = [UIApplication sharedApplication].keyWindow ;
            //[w addSubview:v] ;
            [w.viewForBaselineLayout addSubview:v] ;
            //[w.rootViewController.view addSubview:v] ;
            
            //v.center = w.center ;
            [w bringSubviewToFront:v] ;
            //v.hidden = NO ;
            self->vWait = v ;
             */
        //}
        //////////////////////////////////
        
    }
    else
    {
        [UIAstroAlert infoCancel] ;
        //SAFEREMOVEANDFREE_OBJECT(vWait) ;
        //if( self->waitWindow )
        //{
        //    [waitWindow release] ;
         //   self->waitWindow = nil ;
        //}
        ////////////////////////////////
        
    }
    
}

- (void)updatePictureZL:(NSNumber*) pzl
{
    int zl = [pzl intValue] ;
    
    self->PictureZL = zl ;
    
    switch (zl) {
        case 0:
            lbTPZL.text = @"普通" ;
            break;
        case 1:
            lbTPZL.text = @"高清" ;
            break ;
        case 2:
            lbTPZL.text = @"原图" ;
            break ;
        default:
            break;
    }
    
    //[self performSelectorOnMainThread:@selector(reSavePicture) withObject:nil waitUntilDone:YES] ;
    [self performSelectorInBackground:@selector(reSavePicture) withObject:nil] ;
    
}


- (IBAction)onPictureZL:(id)sender
{
    UIPictureZLVC *vc = [[UIPictureZLVC alloc] initWithNibName:@"UIPictureZLVC" bundle:nil] ;
    vc.callbackObject = self ;
    vc.callbackSEL = @selector(updatePictureZL:) ;
    vc.curPictureZL = self.PictureZL ;
    [self.navigationController pushViewController:vc animated:YES] ;
    [vc release] ;
}

- (void)reSavePicture
{
    __block UIImage *image = nil ;
    __block CGImageRef ref = nil ;
    
    
    [UIAstroAlert info:@"正在处理，请稍候！" :YES :NO];
    NSLog(@"正在处理，请稍候！....");
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for( CPictureSelected *obj in self.pictureList )
        {
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
            if( !obj.editFlag )
            {
                ALAssetRepresentation *assetRep = [obj.picAlasset defaultRepresentation];
                ref = [assetRep fullResolutionImage];
                image = [UIImage imageWithCGImage:ref scale:assetRep.scale orientation:assetRep.orientation];
                image = [CImagePicker fixOrientation:image] ;//add by zd 2014-3-26
                
                //2014.9.18
                TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
                if ( [u isInfantsSchoolMaster] || [u isMiddleSchoolMaster] ||
                    [u isInfantsSchoolTeacher] || [u isMiddleSchoolTeacher]) {
                    [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"H"];//用原图
                }
                else {
                    switch (self.PictureZL)
                    {
                        case 0:
                            [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
                            break;
                        case 1:
                            [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"M"];
                            break ;
                        case 2:
                            [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"H"];
                            break ;
                        default:
                            [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
                            break;
                    }
                }
            }
            
            [pool drain];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // update UI
            [UIAstroAlert infoCancel];
            [self updateImageViewAfterSelect] ;
        });
    });

}


-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}

-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    //接口请求
    NSLog( @"输入内容为：[%@]", contentView.text ) ;
    NSString *str = [NSString stringWithFormat:@"%@",contentView.text] ;
    if( str != nil && ![str isEqualToString:@""])
    {
        CPictureSelected *pic = nil ;
        pic = [self findPictureSelected:self.curEditSelectPicture] ;
        if( pic != nil )
        {
            pic.strPinLun = str ;
            pic.lbPinLun.text = str ;
            pic.lbPinLun.hidden = NO ;
        }
    }
}


#pragma mark-
#pragma mark UIImagePickerControllerDelegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    bCameraFirst = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];//恢复状态栏
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if( [mediaType isEqualToString:@"public.image"] )
    {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        /*
        NSString *strGuid = [CommonFunc createGUIDStr] ;
        
        switch (self.PictureZL)
        {
            case 0:
                [CommonFunc saveJYEXPic:image fileguid:strGuid mode:@"L"];
                break;
            case 1:
                [CommonFunc saveJYEXPic:image fileguid:strGuid mode:@"M"];
                break ;
            case 2:
                [CommonFunc saveJYEXPic:image fileguid:strGuid mode:@"H"];
                break ;
            default:
                [CommonFunc saveJYEXPic:image fileguid:strGuid mode:@"L"];
                break;
        }*/
        
        //将相片加入到列表中
        CPictureSelected *pic = [[CPictureSelected alloc] init] ;
        pic.editFlag = YES ;
        [pic initFileName] ;
        
        switch (self.PictureZL)
        {
            case 0:
                [CommonFunc saveJYEXPic:image fileguid:pic.strFileName mode:@"L"];
                break;
            case 1:
                [CommonFunc saveJYEXPic:image fileguid:pic.strFileName mode:@"M"];
                break ;
            case 2:
                [CommonFunc saveJYEXPic:image fileguid:pic.strFileName mode:@"H"];
                break ;
            default:
                [CommonFunc saveJYEXPic:image fileguid:pic.strFileName mode:@"L"];
                break;
        }
        
        [self.pictureList addObject:pic] ;
        
        [self updateImageViewAfterSelect] ;
    }
    /*
     //直接保存
     CPictureSelected *pic = nil ;
     
     pic = [self findPictureSelected:self.curEditSelectPicture] ;
     if( self->imageTemp != nil )
     {
     pic.editFlag = YES ;
     [CommonFunc saveJYEXPic:imageTemp fileguid:pic.strFileName mode:@"L"];
     }
     
     [self updateImageToImageView:pic] ;
     */
    
    
    //拍照获取相片
    /*
     switch (self.PictureZL)
     {
     case 0:
     [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
     break;
     case 1:
     [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"M"];
     break ;
     case 2:
     [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"H"];
     break ;
     default:
     [CommonFunc saveJYEXPic:image fileguid:obj.strFileName mode:@"L"];
     break;
     }
     */
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];//恢复状态栏
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)loadCamera
{
    
#if TARGET_IPHONE_SIMULATOR
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
        
        return;
    }
#else
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES]; //隐藏状态栏
        return;
    }
#endif
    
    
}

- (IBAction)textFiledReturnEditing:(id)sender
{
    [sender resignFirstResponder];
}


- (UILabel*)createPinLunLabel:(CGRect)frame
{
    UILabel *lb = nil ;
    
    lb = [[UILabel alloc] initWithFrame:frame] ;
    
    lb.backgroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.0f alpha:0.6] ;
    lb.textColor = [UIColor redColor];
    lb.font = [UIFont systemFontOfSize:10.0f];
    lb.textAlignment = NSTextAlignmentCenter ;
    lb.text = @"未评论";
    
    
    return lb ;
}


//查询相册列表
-(void)QueryJYEXAlbumList
{
    //先判断网络是否通，不通则加载本地数据
    if( [[Global instance] getNetworkStatus] == NotReachable )
    {
        return ;
    }
    
    [bussRequest cancelBussRequest];
    self.bussRequest = [BussMng bussWithType:BMJYEXQueryAlbumList];
    
    [bussRequest request:self :@selector(syncCallback_QueryJYEXAlbumList:) :nil];
    return;
}


- (void)syncCallback_QueryJYEXAlbumList:(TBussStatus*)sts
{
	[bussRequest cancelBussRequest];
	self.bussRequest = nil;
	
    
	if ( sts.iCode != 200) //成功
	{
		[UIAstroAlert info:sts.sInfo :2.0 :NO :LOC_MID :NO];
        
        LOG_ERROR(@"Err:query album");
        return;
	}
    
    NSDictionary *dict =(NSDictionary *)(sts.rtnData);
    //add by zd 2015-01-12
    //将获得的相册列表信息缓存
    NSString *strKey = [NSString stringWithFormat:@"JYEX_XCLIST_%@", TheCurUser.sUserID] ;
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:strKey];
    NSLog( @"%@", [[NSUserDefaults standardUserDefaults] objectForKey:strKey] ) ;
    
    [self getFirstAlbum:dict];
    
}


-(void)getFirstAlbum:(NSDictionary *)dict
{
    NSLog(@"%@",dict);
    
    NSArray *arrSchool = [dict objectForKey:@"school"];
    NSArray *arrMyself = [dict objectForKey:@"myself"];
    NSArray *arrAllClass = [dict objectForKey:@"class"];
    

    //班级老师的班级相册
    TJYEXLoginUserInfo *u = (TJYEXLoginUserInfo*)TheCurUser;
    
    if( [u isInfantsSchoolMaster] || [u isMiddleSchoolMaster] ){ //园长
        if ( arrSchool && [arrSchool count] > 0 )
        {
            NSDictionary *dic = [arrSchool objectAtIndex:0];
            [self setXCParamValue:dic];
            [self saveXCParam:dic];
        }
        return;
    }
    
    
    //家长或老师选择发到个人相册
    if ( arrMyself &&
        ( ( ([u isInfantsSchoolTeacher]||[u isMiddleSchoolTeacher]) && [_GLOBAL getAlbumTypeFlag]==0) ||
         ([u isInfantsSchoolParent]||[u isMiddleSchoolParent])
         )
        )
    {
        if( [arrMyself count] > 0 )
        {
            NSDictionary *dic = [arrMyself objectAtIndex:0];
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
            
            [mdic setObject:TheCurUser.sUserID forKey:@"uid"];
            [mdic setObject:TheCurUser.sUserName forKey:@"nickname"];
            [self setXCParamValue:mdic];
            [self saveXCParam:mdic];
        }
        return;
    }
    
    //班级相册
    if ( arrAllClass &&
        ( ([u isInfantsSchoolTeacher]||[u isMiddleSchoolTeacher]) && [_GLOBAL getAlbumTypeFlag]==1)
        )
    {
        if( [arrAllClass count] > 0 )
        {
            for (NSDictionary *dic in arrAllClass)
            {
                NSString *strName = [dic objectForKey:@"nickname"];
                NSLog(@"class %@:",strName);
                NSString *strUid = [dic objectForKey:@"uid"];
                NSArray *arrClass = [dic objectForKey:@"album"];
                if ( arrClass )
                {
                    for( NSDictionary *dic1 in arrClass )
                    {
                        NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic1];
                        [mdic setObject:strUid forKey:@"uid"];
                        [mdic setObject:strName forKey:@"nickname"];
                        [self setXCParamValue:mdic];
                        [self saveXCParam:mdic];
                        return;
                    }
                }
            }
        }
    }
    
    return;
    
    
}



@end
