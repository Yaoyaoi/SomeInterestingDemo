# SomeInterestingDemo
受到[allenwong](https://github.com/allenwong)的[30DaysofSwift](https://github.com/allenwong/30DaysofSwift)的启发，参考了他的项目，和Sam Lu的[100 Days of Swift](http://samvlu.com/index.html)，用Objective-C完成几个了我感兴趣的几个小demo

##Project 1 AnimatedSplash
* 实现了Facebook的开启动画。   
* 把小鸟当成 Mask 来用，用CAKeyframeAnimation，设定3个Bounds的值，进行过渡就可以实现放大动画

##Project 2 GetMyLocation
* 实现了显示用户经纬度以及国家省份城市的功能（注：在国外无法使用，我也不知道为啥）
* 使用了CoreLocation Framework
* 需要在info.plist中添加Privacy - Location Always Usage Description 和Privacy - Location When In Use Usage Description来获取定位的许可，并且在Background Modes 中勾选Location updates。

##Project 3 SetTheDate
* 学习了UIDatePicker的使用