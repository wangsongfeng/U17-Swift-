# U17-Swift-
Swift学习练习项目

Swift学习1月31日：
1，配置了整个工程的结构，tabbar的搭建，
2，注意：好多Swift第三方都不支持Swift4，所以要选中pods-->targets>对应的第三方不支持的，选中-->Build Setting-->Swift launch lauguange 把Swift4.0改成Swift3.2；
3，好长时间没写IOS项目了，突然发现Xcode9 不能直接 在外面 拖 文件，不识别，需要 右键 --> add Files to ,就好比我要选图片就是刚开始一直不出来，
4，判断 当前 机型： UIDevice.current.userInterfaceIdiom == .phone

5，iOS tabbar的translucent属性 ：
        当我们把viewControllers加到tabbarController中时，tabbar是否会覆盖viewControllers下面的部分呢？
        这与tabbar的translucent属性有关，这个属性是半透明的意思，当设置为true时，tabbar就会覆盖viewControllers下面的部分，当设置为false时，tabbar便不会覆盖viewControllers下面的部分。
