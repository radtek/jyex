/***************************************************************************//**
 *  @file
 *  @brief Note项目错误码定义
 *
 *  <b>文件名</b>      : RetCode.h
 *  @n@n<b>版权所有</b>: 网龙天晴程序部应用软件开发组
 *  @n@n<b>作  者</b>  : maoxp
 *  @n@n<b>创建时间</b>: 2009-02-19 10:19:57
 *  @n@n<b>文件描述</b>:
 *  @version  版本        修改者        时间        描述@n
 *  @n        [版本号]    liuyy         2009-03-31  [描述]
 *  @n        [版本号]    maoxp         2009-02-19  [描述]
 *
 *******************************************************************************/

#ifndef __RET_CODE_H__
#define __RET_CODE_H__

#include <string>

#ifndef EXPAND_ERROR    // 只是声明
#define DEFINE_ERROR(e, code, msg) const int e = code;
#else                   // 设置错误码对应的错误信息
#define DEFINE_ERROR(e, code, msg) {mapErrorW[code] = _T(msg);mapErrorA[code] = (msg);}
#endif

// 获取错误信息
const char* GetErrorStringA(int iErrCode);


/* defines for interface return code */
/* 基本错误段 */
DEFINE_ERROR(RET_SUCCESS            , 0         , ("返回值正确"))
DEFINE_ERROR(RET_INVALID_PARAM      , 0x00000001, ("参数错误"))
DEFINE_ERROR(RET_FILE_NOT_EXIST     , 0x00000004, ("文件不存在"))
DEFINE_ERROR(RET_OUT_OF_MEM         , 0x00000005, ("内存不足"))
DEFINE_ERROR(RET_RECORD_EXIST       , 0x00000006, ("记录已存在"))
DEFINE_ERROR(RET_RECORD_NOT_EXIST   , 0x00000007, ("记录不存在"))

DEFINE_ERROR(RET_OVERRUN_TOTALDATASIZE      , 0x00000008, "用户上传笔记超过总容量限制")
DEFINE_ERROR(RET_OVERRUN_MONTH_DATASIZE     , 0x00000009, "用户上传笔记超过本月容量限制")
DEFINE_ERROR(RET_INVALID_CMDCODE            , 0x0000000A, "无效命令码")
DEFINE_ERROR(RET_CLIENT_VERSION_OLD			, 0x0000000B, "客户端的版本太低，必须升级后才能使用")

/* 业务层错误码 */
DEFINE_ERROR(RET_MAX_PATH_DEPTH     , 0x00000050, ("文件夹路径太深"))
DEFINE_ERROR(RET_SAVE_FILE_ERROR    , 0x00000051, ("写入文件失败"))
DEFINE_ERROR(RET_DELETE_FILE_ERROR  , 0x00000052, ("删除文件失败"))

DEFINE_ERROR(RET_DB_SAVE_ERROR      , 0x00000101, ("数据库存储失败"))
DEFINE_ERROR(RET_DB_LOAD_ERROR      , 0x00000102, ("数据库加载失败"))
DEFINE_ERROR(RET_DB_CREATE_ERROR    , 0x00000103, ("数据库创建失败"))

DEFINE_ERROR(RET_DB_COMMON_ERR      , 0x00000104, ("数据库错"))
DEFINE_ERROR(RET_DB_NO_SUCH_RECORD  , 0x00000105, ("记录不存在"))

DEFINE_ERROR(RET_CRYPT_NEED_PWD					, 0x00000106, ("数据被加密，要求输入密码"))
DEFINE_ERROR(RET_CRYPT_PWD_WRONG				, 0x00000107, ("不正确的密码"))
// DEFINE_ERROR(RET_CRYPT_FORBIDDEN				, 0x00000108, "不能进行加解密操作")
DEFINE_ERROR(RET_CRYPT_PWD_DOTCHG				, 0x00000109, ("不能进行修改密码操作"))
DEFINE_ERROR(RET_CRYPT_NEED_ENCRYPT				, 0x000001A0, ("需要加密"))
DEFINE_ERROR(RET_CRYPT_NEED_DECRYPT				, 0x000001A1, ("需要解密"))
DEFINE_ERROR(RET_DRAG_ENCATE2ENCATE_FORBIDDEN	, 0x000001A3, ("不能将一个加密的文件夹拖入另一个加密的文件夹中"))
DEFINE_ERROR(RET_DRAG_ENNOTE2ENCATE_FORBIDDEN	, 0x000001A4, ("不能将一个加密的NOTE拖入一个加密的文件夹中"))
DEFINE_ERROR(RET_ENCRYPT_FORBIDDEN				, 0x000001A5, ("自身或者子项已经被加密过了，不允许再次加密"))
DEFINE_ERROR(RET_DECRYPT_FORBIDDEN				, 0x000001A6, ("未加密，或者已经被解密过的项，不允许做解密操作"))
DEFINE_ERROR(RET_DONT_COPY2ENCRYPTFILE			, 0x000001A7, ("不能复制到加密的文件夹下"))
DEFINE_ERROR(RET_MASTERKEY_ERROR				, 0x000001A8, ("用户没有登录过，不能进行这个操作(MasterKey错误，字段不存在)"))
DEFINE_ERROR(RET_DATA_DESTROYED					, 0x000001A9, ("原始数据被破坏了，现在的数据可能对您的机器造成破坏"))
DEFINE_ERROR(RET_PART_SUCCESS					, 0X000001AA, ("部分数据解密失败，可能由于同步造成数据不一致"))
DEFINE_ERROR(RET_CRYPT_ERROR					, 0x000001AB, ("加解密失败，未知原因"))



/* 同步模块错误码段 */
DEFINE_ERROR(RET_SYNC_NOT_LOGIN     , 0x00000300, ("未登录用户的请求"))
DEFINE_ERROR(RET_SYNC_TABLE         , 0x00000301, ("表名不存在"))
DEFINE_ERROR(RET_SYNC_NOT_FOUND     , 0x00000302, ("记录不存在"))
DEFINE_ERROR(RET_SYNC_BASE_VER_ID   , 0x00000303, ("版本号不一致(冲突)"))
DEFINE_ERROR(RET_SYNC_ONLY_READ     , 0x00000304, ("只读共享，不能修改"))
DEFINE_ERROR(RET_SYNC_OTHER_OWNER   , 0x00000305, ("用户ID不一致，需要另起一包"))
DEFINE_ERROR(RET_SYNC_PACKET_FULL   , 0x00000306, ("此包已满，不能填数据了"))
DEFINE_ERROR(RET_SYNC_ERR_OPN		, 0x00000307, ("返回包的OPN与预期不符"))
DEFINE_ERROR(RET_USER_IN_LINE       , 0x00000308, ("用户重复登录"))
DEFINE_ERROR(RET_USER_RE_LOGIN      , 0x00000309, ("用户已登录"))
DEFINE_ERROR(RET_RE_SYNC			, 0x0000030A, ("正在同步中"))
DEFINE_ERROR(RET_SYNC_THREAD_FAIL	, 0x0000030B, ("同步线程创建失败"))
DEFINE_ERROR(RET_APP_SRV_NO_RSP		, 0x0000030C, ("应用服务器无响应"))
DEFINE_ERROR(RET_GA_SRV_NO_RSP		, 0x0000030C, ("登录服务器无响应"))

/* 网络层错误码段 */
DEFINE_ERROR(RET_NET_CREATE_FAIL    , 0x00000200, ("网络创建失败？？"))
DEFINE_ERROR(RET_NET_LOGIN_FAIL     , 0x00000201, ("网络登录失败？？"))
DEFINE_ERROR(RET_NET_SEND_FAIL      , 0x00000202, ("网络发送失败？？"))
DEFINE_ERROR(RET_NET_RECV_FAIL      , 0x00000203, ("网络接收失败？？"))
DEFINE_ERROR(RET_NET_FAIL           , 0x00000204, ("网络失败"))
DEFINE_ERROR(RET_USER_CANCEL        , 0x00000205, ("用户撤消"))
DEFINE_ERROR(RET_READ_BUF_ERROR     , 0x00000206, ("读缓冲区失败"))
DEFINE_ERROR(RET_WRITE_BUF_ERROR    , 0x00000207, ("写缓冲区失败"))
DEFINE_ERROR(RET_NET_NO_RECV_RSP    , 0x00000208, ("没收到响应"))
DEFINE_ERROR(RET_NET_BUF_SMALL      , 0x00000209, ("缓冲区太小"))

/* UI Error code */
DEFINE_ERROR(RET_DELETE_FILE_FAILED,			0x00001001, ("删除文件失败"))
DEFINE_ERROR(RET_CREATE_GUID_FAILED,			0x00001002, ("创建GUID失败"))
DEFINE_ERROR(RET_GUID_NULL_ERROR,				0x00001003, ("GUID值为空"))
DEFINE_ERROR(RET_GET_GUID_FAILED,				0x00001004, ("获取GUID值失败"))
DEFINE_ERROR(RET_SET_CUR_SEL_FAILED,			0x00001005, ("设置当前选择项失败"))
DEFINE_ERROR(RET_GET_ITEM_COUNT_FAILED,			0x00001006, ("获取项总数失败"))
DEFINE_ERROR(RET_NOTE_UPDATE_INFO_FAILED,		0x00001007, ("更新Note信息失败"))
DEFINE_ERROR(RET_DEL_TAG2NOTE_FAILED,			0x00001008, ("删除Tag2Note失败"))
DEFINE_ERROR(RET_ADD_TAG2NOTE_FAILED,			0x00001009, ("添加Tag2Note失败"))
DEFINE_ERROR(RET_PUTNOTETOTRASH_FAILED,			0x00001010, ("删除Note至垃圾箱失败"))
DEFINE_ERROR(RET_EDITOR_IS_OPENED,				0x00001011, ("编辑器已经打开"))
DEFINE_ERROR(RET_NOTE_DEL_FAILED,				0x00001012, ("删除指定的Note失败"))
DEFINE_ERROR(RET_NOTE_UNDEL_FAILED,				0x00001013, ("撤销删除失败"))

DEFINE_ERROR(RET_MSG_PARAM_ERROR,				0x00001101, ("消息参数错误"))

DEFINE_ERROR(RET_CATE_GET_LIST_FAILED,			0x00001201, ("获取Cate链表失败"))
DEFINE_ERROR(RET_CATE_GET_INFO_FAILED,			0x00001202, ("获取Cate信息失败"))
DEFINE_ERROR(RET_CATE_CANNOT_DELETE_FAILED,		0x00001203, ("Cate不能被删除"))
DEFINE_ERROR(RET_CATE_DELETE_VERBOTEN_FAILED,	0x00001204, ("删除禁止Cate失败"))
DEFINE_ERROR(RET_CATE_DELETE_DEFULT_DIR,		0x00001205, ("删除默认Cate"))
DEFINE_ERROR(RET_CATE_DELETE_FAILED,			0x00001206, ("删除Cate失败"))
DEFINE_ERROR(RET_CATE_GET_TRASH_FAILED,			0x00001207, ("获取垃圾箱的Cate失败"))
DEFINE_ERROR(RET_CATE_UPDATE_DIRINFO_FAILED,	0x00001208, ("更新Cate信息失败"))
DEFINE_ERROR(RET_CATE_DONT_MOVE,				0x00001209, ("不移动Cate"))
DEFINE_ERROR(RET_CATE_IS_EXIST,					0x00001210, ("Cate已经存在"))
DEFINE_ERROR(RET_CATE_DONT_DELETE,				0x00001211, ("询问是否删除Cate时，选择不删除"))
DEFINE_ERROR(RET_CATE_SHOW_NOTE_FAILED,			0x00001212, ("根据Cate显示Note失败"))
DEFINE_ERROR(RET_CATE_UPDATE_FAILED,			0x00001213, ("更新Cate失败"))
DEFINE_ERROR(RET_CATE_ADD_FAILED,				0x00001214, ("添加Cate失败"))
DEFINE_ERROR(RET_CATE_NAME_IS_EMPTY,			0x00001215, ("Cate名称为空"))
DEFINE_ERROR(RET_CATE_EMPTY_FAILED,				0x00001216, ("清空Cate失败"))
DEFINE_ERROR(RET_CATE_RENAME_FAILED,			0x00001217, ("Cate重命名失败"))
DEFINE_ERROR(RET_CATE_GET_SUBDIR_FAILED,		0x00001218, ("获取子Cate失败"))
DEFINE_ERROR(RET_CATE_SUB_LIST_NULL,			0x00001219, ("子Cate为空"))
DEFINE_ERROR(RET_CATE_DELETE_TREEITEM_FAILED,	0x00001220, ("删除Cate树的item失败"))
DEFINE_ERROR(RET_CATE_NAME_ERROR,				0x00001221, ("Cate名称错误"))
DEFINE_ERROR(RET_CATE_PUTTOTRASH_FAILED,		0x00001222, ("删除Cate至垃圾箱失败"))
DEFINE_ERROR(RET_CATE_MOVE_FAILED,				0x00001223, ("移动Cate失败"))

DEFINE_ERROR(RET_TAG_DELETE_DEFAULT_NULL,		0x00001301, "删除默认空标签")
DEFINE_ERROR(RET_TAG_RENAME_FAILED,				0x00001302, "Tag重命名失败")
DEFINE_ERROR(RET_TAG_DELETE_FAILED,				0x00001303, "删除Tag失败")
DEFINE_ERROR(RET_TAG_SHOW_NOTE_FAILED,			0x00001304, "根据Tag显示Note失败")
DEFINE_ERROR(RET_TAG_ADD_FAILED,				0x00001305, "添加Tag失败")
DEFINE_ERROR(RET_TAG_GET_LIST_FAILED,			0x00001306, "获取Tag列表失败")

DEFINE_ERROR(RET_TRASH_EMPTY_FAIED,				0x00001401, "清空回收站失败")
DEFINE_ERROR(RET_UPDATE_NOTE_CONTENT_FAILED,	0x00001402, "更新Note内容失败")

DEFINE_ERROR(RET_DATE_SHOW_NOTE_FAILED,			0x00001501, "根据日期显示Note失败")

DEFINE_ERROR(RET_ALL_SHOW_NOTE_FAILED,			0x00001601, "显示所有Note失败")

DEFINE_ERROR(RET_CUR_CATE_NAME_EXIST,			0x00001701, "当前输入的文件夹名称已经存在")
DEFINE_ERROR(RET_FROM_DB_QUERY_FAILED,			0x00001702, "查询数据库失败")

DEFINE_ERROR(RET_SYNED_FAILED,					0x00001801, "同步失败")
DEFINE_ERROR(RET_UPDATE_SYN_PROGRESS_FAILED,	0x00001802, "更新同步进度失败")
DEFINE_ERROR(RET_REFRESH_PIC_FAILED,			0x00001803, "更新图片失败")
DEFINE_ERROR(RET_UPDATE_NOTE_LIST_FAILED,		0x00001804, "更新Note列表失败")
DEFINE_ERROR(RET_FILTER_NOTE_TYPE_FAILED,		0x00001805, "过滤Note类型失败")
DEFINE_ERROR(RET_ADD_QUICK_WRITE_FAILED,		0x00001806, "添加随手记失败")
DEFINE_ERROR(RET_REFRESH_HTML_FAILED,			0x00001803, "更新Html页面失败")

DEFINE_ERROR(RET_ADD_PIC_FAILED,				0x00001901, "添加截图失败")
DEFINE_ERROR(RET_ADD_PAGE_FAILED,				0x00001902, "添加网页抓取失败")
DEFINE_ERROR(RET_ADD_REGION_FAILED,				0x00001903, "添加区域截图失败")
DEFINE_ERROR(RET_ADD_ELEMENT_FAILED,			0x00001904, "添加单元截图失败")
DEFINE_ERROR(RET_ADD_CTRL_FAILED,				0x00001905, "添加控件截图失败")

DEFINE_ERROR(RET_TREE_ITEM_EDIT_FAILED,			0x00002001, "项编辑错误")
DEFINE_ERROR(RET_TREE_ITEM_MSG_ERROR,			0x00002002, "项信息异常")
DEFINE_ERROR(RET_TREE_ITEM_SELECTED_FAILED,		0x00002003, "项的选择失败")
DEFINE_ERROR(RET_TREE_GET_PARENT_ITEM_FAILED,	0x00002004, "获取树的父结点失败")
DEFINE_ERROR(RET_TREE_PARENT_ITEM_ERROR,		0x00002005, "树型控件父项异常")

DEFINE_ERROR(RET_LIST_SHOW_ALL_FAILED,			0x00002101, "显示所有Note失败")
DEFINE_ERROR(RET_LIST_SET_CUR_SEL_FAILED,		0x00002102, "设置list当前选择失败")
DEFINE_ERROR(RET_LIST_INSERT_FAILED,			0x00002103, "ListView插入失败")
DEFINE_ERROR(RET_LIST_DELALLITEM_FAILED,		0x00002104, "ListView清空所有项失败")
DEFINE_ERROR(RET_LIST_GET_BY_TIME_FAILED,		0x00002105, "根据时间获取Note列表失败")
DEFINE_ERROR(RET_LIST_GET_BY_BLANKTAG_FAILED,	0x00002106, "根据空标签获取Note列表失败")
DEFINE_ERROR(RET_LIST_GET_BY_TYPE_FAILED,		0x00002107, "根据类型获取Note列表失败")
DEFINE_ERROR(RET_LIST_GET_BY_STATE_FAILED,		0x00002108, "根据状态获取Note列表失败")
DEFINE_ERROR(RET_LIST_SET_FAILED,				0x00002109, "设置笔记列表失败")
DEFINE_ERROR(RET_LIST_GET_NORMAL_NOTE_FAILED,	0x00002110, "获取正常状态Note失败")

DEFINE_ERROR(RET_HTML_VIEW_IS_NO_WINDOW,		0x00002201, "视图窗口没有准备好")

DEFINE_ERROR(RET_ARRAYNOTE_SIZE_ERROR,			0x00002301, "ArrayNote大小异常")
DEFINE_ERROR(RET_ARRAYNOTE_SORT_FAILED,			0x00002302, "ArrayNote排序失败")

DEFINE_ERROR(RET_GET_NOTE_GUID_FAILED,			0x00002401, "获取Note的GUID失败")
DEFINE_ERROR(RET_GET_NOTEINFO_FAILED,			0x00002402, "获取Note信息失败")
DEFINE_ERROR(RET_NOTEINFO_ERROR,				0x00002403, "Note信息异常")
DEFINE_ERROR(RET_CURRENT_PAGE_ERROR,			0x00002404, "当前页面值有误")
DEFINE_ERROR(RET_GET_NOTE_BYSTATE_FAILED,		0x00002405, "根据状态获取Note失败")
DEFINE_ERROR(RET_GET_NOTE_BYCATE_FAILED,		0x00002406, "根据目录获取Note失败")
DEFINE_ERROR(RET_GET_CATE_BYSTATE_FAILED,		0x00002407, "根据状态获取Cate失败")

DEFINE_ERROR(RET_CREATE_SHELL_ICON_FAILED,		0x00002501, "创建托盘图标失败")
DEFINE_ERROR(RET_DELETE_SHELL_ICON_FAILED,		0x00002502, "删除托盘图标失败")

DEFINE_ERROR(RET_FIND_MENU_ITEM_FAILED,			0x00002601, "查找菜单失败")

/* UI Mng Error Code */
DEFINE_ERROR(RET_READ_FILE_FAILED,				0x00003001,	"读取文件失败")
DEFINE_ERROR(RET_FILE_SIZE_ERROR,				0x00003002,	"文件大小异常")
DEFINE_ERROR(RET_SET_ITEM_DATA_FAILED,			0x00003003,	"设置Item数据失败")
DEFINE_ERROR(RET_SET_NOTE_DATA_FAILED,			0x00003004,	"设置Note数据失败")
DEFINE_ERROR(RET_INSERT_SEARCH_FAILED,			0x00003005,	"插入搜索内容失败")
DEFINE_ERROR(RET_FILE_ISNOT_EXIST,				0x00003006,	"文件不存在")
DEFINE_ERROR(RET_NO_CONTENT_NEED_UPDATE,		0x00003007,	"无内容需要更新")
DEFINE_ERROR(RET_SET_NOTE_LIST_FAILED,			0x00003008,	"设置Note列表错误")
DEFINE_ERROR(RET_NOTE_TYPE_ERROR,				0x00003009,	"Note类型异常")
DEFINE_ERROR(RET_CREATE_THUMBIMG_FAILED,		0x00003010,	"生成缩略图失败")
DEFINE_ERROR(RET_PARSE_HTML_FAILED,				0x00003011,	"解析Html文件失败")
DEFINE_ERROR(RET_DEL_OLDNOTE_FAILED,			0x00003016,	"删除旧的Note失败")
DEFINE_ERROR(RET_GET_FILE_PATH_FAILED,			0x00003017,	"获得文件路径失败")
DEFINE_ERROR(RET_LIST_IS_NULL,					0x00003018,	"无对应链表信息")
DEFINE_ERROR(RET_GET_ITEMLIST_FAILED,			0x00003019,	"获取Item列表失败")
DEFINE_ERROR(RET_GET_REMARK_BACKUPIMG_FAILED,	0x00003020,	"获取Remark原图失败")
DEFINE_ERROR(RET_GET_REMARK_LIST_FAILED,		0x00003021,	"获取Remark列表失败")
DEFINE_ERROR(RET_GET_DOWNLOADINFO_LIST_FAILED,	0x00003022,	"获取DownloadInfo列表失败")
DEFINE_ERROR(RET_SET_THUMBINFO_FAILED,			0x00003023,	"设置缩略图数据失败")
DEFINE_ERROR(RET_SAVE_REMARK_FAILED,			0x00003024,	"保存批注信息失败")
DEFINE_ERROR(RET_SYNC_FAILED,					0x00003025,	"同步失败")
DEFINE_ERROR(RET_SYNC_STOP_FAILED,				0x00003026,	"停止同步失败")
DEFINE_ERROR(RET_REMRAK_MERGPIC_FAILED,			0x00003027,	"合并Remark至图片失败")
DEFINE_ERROR(RET_GET_NOTECOUNT_BYCATE_FAILED,	0x00003028,	"根据Cate获取Note总数失败")
DEFINE_ERROR(RET_GET_NOTECOUNT_BYTAG_FAILED,	0x00003029,	"根据Tag获取Note总数失败")

DEFINE_ERROR(RET_NOTE_INFO_ERROR,				0x00003101,	"Note信息异常")
DEFINE_ERROR(RET_CATE_INFO_ERROR,				0x00003102,	"Cate信息异常")
DEFINE_ERROR(RET_ITEM_INFO_ERROR,				0x00003103,	"Item信息异常")
DEFINE_ERROR(RET_TAG_INFO_ERROR,				0x00003104,	"Tag信息异常")
DEFINE_ERROR(RET_REMARK_INFO_ERROR,				0x00003105,	"Remark信息异常")
DEFINE_ERROR(RET_COMMENT_INFO_ERROR,			0x00003106,	"Comment信息异常")

DEFINE_ERROR(RET_ADD_NOTE_FAILED,				0x00003200,	"添加Note失败")
DEFINE_ERROR(RET_ADD_PIC_NOTE_FAILED,			0x00003201,	"添加图片Note失败")
DEFINE_ERROR(RET_ADD_FLASH_FAILED,				0x00003202,	"添加Flash失败")
DEFINE_ERROR(RET_ADD_MUSIC_FAILED,				0x00003203,	"添加音频失败")
DEFINE_ERROR(RET_ADD_TAG_FAILED,				0x00003204,	"添加Tag失败")
DEFINE_ERROR(RET_ADD_COMMENT_FAILED,			0x00003205,	"添加Comment失败")
DEFINE_ERROR(RET_ADD_REMARK_FAILED,				0x00003206,	"添加Remark失败")
DEFINE_ERROR(RET_ADD_ITEM_FAILED,				0x00003207,	"添加Item失败")

DEFINE_ERROR(RET_GET_NOTELIST_FAILED,			0x00003301,	"获取NoteList失败")
DEFINE_ERROR(RET_GET_NOTELIST_BYCATE_FAILED,	0x00003302,	"根据Cate获取NoteList失败")
DEFINE_ERROR(RET_GET_NOTELIST_BYTAG_FAILED,		0x00003303,	"根据Tag获取NoteList失败")
DEFINE_ERROR(RET_GET_NOTELIST_BYSTATE_FAILED,	0x00003304,	"根据State获取NoteList失败")
DEFINE_ERROR(RET_GET_NOTELIST_BYTIME_FAILED,	0x00003305,	"根据Time获取NoteList失败")

DEFINE_ERROR(RET_UPDATE_SENCE_FAILED,			0x00003401,	"更新场景失败")
DEFINE_ERROR(RET_UPDATE_WEB_NOTE_FAILED,		0x00003402,	"更新网页Note失败")
DEFINE_ERROR(RET_UPDATE_PIC_NOTE_FAILED,		0x00003403,	"更新图片Note失败")
DEFINE_ERROR(RET_UPDATE_NOTE_INFO_FAILED,		0x00003404,	"更新Note信息失败")
DEFINE_ERROR(RET_UPDATE_ITEM_INFO_FAILED,		0x00003405,	"更新Item信息失败")

DEFINE_ERROR(RET_TREE_EMPTY_TRASH_FAILED,		0x00003501,	"删除回收站所有项目失败")
DEFINE_ERROR(RET_TREE_RECOVER_TRASH_FAILED,		0x00003502,	"还原回收站项目失败")

DEFINE_ERROR(RET_SNS_URL,						0x00003601,	"SNS服务器地址错误")
DEFINE_ERROR(RET_SNS_SRV_CONNECT,				0x00003602,	"连接SNS服务器失败")
DEFINE_ERROR(RET_SNS_SRV_NO_RSP,				0x00003603,	"SNS服务器没响应")
DEFINE_ERROR(RET_SNS_SRV_BAD_RSP,				0x00003604,	"SNS服务器返回未知结果")

DEFINE_ERROR(RET_MB_MSG_NULL_POINTER,			0x00004001,	"消息中非法空指针")
DEFINE_ERROR(RET_MB_MSG_ERR_LENGTH,			    0x00004002,	"消息长度有误")
DEFINE_ERROR(RET_MB_MSG_MEM_BAD_ALLOC,			0x00004003,	"消息处理分配内存出错")
DEFINE_ERROR(RET_MB_MSG_DECODE_ERR,			    0x00004004,	"消息解码失败")
DEFINE_ERROR(RET_MB_MSG_ENCODE_ERR,			    0x00004005,	"消息编码失败")
DEFINE_ERROR(RET_MB_ITEM_IS_NEWEST,			    0x00004006,	"笔记内容已是最新")
DEFINE_ERROR(RET_MB_MODIFY_DEFCATA,			    0x00004007,	"手机默认文件夹不允许修改")
DEFINE_ERROR(RET_MB_CHG_TO_THUMB,			    0x00004008,	"已经转化为缩略图")

DEFINE_ERROR(RET_UNKNOWN_ERR,					0xFFFFFFFF, "未知错误")

#endif  /* __RET_CODE_H__ */
