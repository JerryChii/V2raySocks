# V2RaySocks
## 一个售卖v2Ray的whmcs插件
* 当前版本 0.8.2

## 支持的功能：
* 流量图表(已修复自动任务过于频繁导致记录过多的问题(目前记录频率：3小时一次(已经改为跟随WHMCS系统的自动任务进行，不需要手动设置))）
* 流量重置(每月开始，每月底，由结算日计算(已经改为跟随WHMCS系统的自动任务进行，不需要手动设置))
* 公告信息(已修复HTML问题)
* VMESS 二维码(已更新多端兼容)
* VMESS URL复制功能
* VMESS 订阅功能
* 随机UUID,重置UUID,复制UUID
* tls,伪装类型,Host,传输协议,路径,流量倍率,额外ID可在服务器设置中设置(不支持则留空)
* 线路列表格式修改，请还是注意修正！！！！
* 添加了API支持(V0.2)
* 修正了部分情况下API异常
* 优化了流量图表的显示(Tab显示)

## API
* API的校验密码可在api.php中修改
* API返回数据格式：
```
{
	"result" : "success",
	"email"  : "123@123.moe",
	"name"   : "1234",
	"package": [
		"0"  : [
			"package": "40g套餐",
			"uuid"   : "09FD9959-5F82-41F7-967F-87AFDF31AFF6",
			"usage"  : "1000",
			"traffic": "40960000000",
			"nodes"  :  [
							"0" : "hk1|127.0.0.1|8300|none|tls|233.233.com|/233|ws|1",
							"1" : "hk2|127.0.0.1|8300|none|tls|233.233.com|/233|ws|1"
						]
			],
		"1"  : [
			"package": "100g套餐",
			"uuid"   : "41DA057F-A3E6-424F-BEEC-38E0D58A6536",
			"usage"  : "10000",
			"traffic": "1099511627776",
			"nodes"  :  [
							"0" : "hk1|127.0.0.1|8300|none|tls|233.233.com|/233|ws|1"
						]
	]
}
```

## 注意事项
* 已更新自动流量更新功能以及自动重置流量功能。请注意刷新hook以保证模块正常运行！
* 需要更多支持，请开issue或者给我发邮件

## 当前适配的Manager版本以及支持的功能
* 版本 Gold - 1.1.2.3
* 拉取V2raySocks的数据库
* 通过数据库信息添加用户
* 通过数据库信息删除用户
* 上传流量至数据库
* 自动关闭超出流量的用户
* 支持流量倍率功能
* UUID重置自动更新
* 支持命令行参数启动
* 支持后台运行
* 支持日志保存
* 检测V2Ray进程并自动重启V2Ray
* 开启时检测V2Ray更新
* 自动检测并安装V2ray
* 获取系统内存状态
* 进程超时状态检测
* 远程状态监控

## Manager远程状态监控返回示例
* 访问 127.0.0.1:8888/status
```
{
	"LoadMin1":"0.00",
	"LoadMin5":"0.00",
	"LoadMin15":"0.00",
	"M2Version":"Gold - V1.1.2.3",
	"RX":"7332",
	"SelfMemoryUsed":"2",
	"Status":"Success",
	"SystemMemoryAll":"996",
	"SystemMemoryUsed":"684",
	"TX":"7444",
	"Timestamp":"1531112247",
	"Uptime":"93",
	"V2RayUsers":"7"
}
```

## 捐赠
ETH钱包 0xaD8ABb15e4B8B58f5FbEE9CAb42096c1d640C234  
链克钱包 0x4cfa7215324f2cc521beeb35c8a85c9afdbcda7e