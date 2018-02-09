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
        
        
        
2月8日：

    IOS 11 安全区域适配总结：
        IOS7之后增加了automaticallyAdjustsScrollViewInsets这个属性；主要是为了自动适配当有导航栏或者Tab bar时，自动增加內外边距，防止stateBar,navBar,tababr遮盖。当automaticallyAdjustsScrollViewInsets=YES 时，视图会自动适配，让试图都暴露在可视范围内
        iOS 11中Controller的automaticallyAdjustsScrollViewInsets属性被废弃了，取而代之的是安全区域，原理一样。
        IOS11之前tabView内容与外边距的距离是contentInset。之后是adjustedContentInset属性，
        
        如果你的APP中使用的是自定义的navigationbar，隐藏掉系统的             navigationbar，并且tableView的frame为(0,0,SCREEN_WIDTH, SCREEN_HEIGHT)开始，那么系统会自动调整SafeAreaInsets值为(20,0,0,0)，如果使用了系统的navigationbar，那么SafeAreaInsets值为(64,0,0,0)，如果也使用了系统的tabbar，那么SafeAreaInsets值为(64,0,49,0)
        
    什么情况下的tableView会发生上述问题
    
        1.如果设置了automaticallyAdjustsScrollViewInsets = YES，那么不会发生问题，一直都是由系统来调整内容的偏移量；
        2.当tableView的frame超出安全区域范围时，系统会自动调整内容的位置，SafeAreaInsets值会不为0，于是影响tableView的adjustContentInset值，于是影响tableView的内容展示，导致tableView的content下移了SafeAreaInsets的距离。SafeAreaInsets值为0时，是正常的情况。
    这个问题的解决方法有哪些？
        1. 重新设置tableView的contentInset值，来抵消掉SafeAreaInset值，因为内容下移偏移量 = contentInset + SafeAreaInset；
        如果之前自己设置了contentInset值为(64,0,0,0),现在系统又设置了SafeAreaInsets值为(64,0,0,0)，那么tableView内容下移了64pt，这种情况下，可以设置contentInset值为(0,0,0,0)，也就是遵从系统的设置了。
        2. 设置tableView的contentInsetAdjustmentBehavior属性
        3. 通过设置iOS 11新增的属性addtionalSafeAreaInset；
        
    if #available(iOS 11.0, *){
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
    } else {
        automaticallyAdjustsScrollViewInsets = false
    }
    
    http://blog.csdn.net/qq_33608748/article/details/78044761
    
2月9日 ：
        1.再一次证明了当导航控制器 为 透明或半透明的时候 ，就会影响 系统安全区域的自动布局，
        2.HMSegmentedControl的使用：类似于滑动视图标题，视图可以自己去实现，项目中用到的是UIPageViewController.关于UIPageViewController，之前的git中我也做过用法总结，不多赘述
        
        self.titleSegment = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"title 1",@"title 2"]];
        _titleSegment.frame = self.view.bounds;
        _titleSegment.selectedSegmentIndex = 0;
        _titleSegment.type = HMSegmentedControlTypeText;//风格样式
        _titleSegment.font = [UIFont systemFontOfSize:17];
        _titleSegment.selectionStyle =HMSegmentedControlSelectionStyleFullWidthStripe; // 选中样式
        _titleSegment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _titleSegment.textColor = [UIColor colorWithHex:@"a5b1c1"];
        _titleSegment.selectedTextColor = [UIColor colorWithHex:@"0064ab"];
        _titleSegment.selectionIndicatorColor = [UIColor clearColor];
        _titleSegment.backgroundColor = [UIColor clearColor];
        
        点击事件：
        segmented.addTarget(self, action:#selector(segmentControllChange(segment:)), for: .valueChanged)
        选中那个的序列号：
        segment.selectedSegmentIndex
        
        typedef enum {
        HMSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width // 下面的横条跟字体一般大
        HMSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment // 下面的横条跟按钮大小一般大
        HMSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment // 点击之后按钮背景会有凹陷效果
        HMSegmentedControlSelectionStyleArrow // An arrow in the middle of the segment pointing up or down depending on `HMSegmentedControlSelectionIndicatorLocation` // 选中出现个三角,枚举值,顶部出现,下部出现,不出现
        } HMSegmentedControlSelectionStyle; // 选中样式
        
        typedef enum {
        HMSegmentedControlSelectionIndicatorLocationUp, // 顶上出现
        HMSegmentedControlSelectionIndicatorLocationDown, // 底部出现
        HMSegmentedControlSelectionIndicatorLocationNone // No selection indicator // 不出现
        } HMSegmentedControlSelectionIndicatorLocation; // 选中出现一个三角
        
        typedef enum {
        HMSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed // 自动填充整个宽度
        HMSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset) // 根据最大文字算出宽度,自适应
        } HMSegmentedControlSegmentWidthStyle; // 设置按钮大小样式的
        
        typedef NS_OPTIONS(NSInteger, HMSegmentedControlBorderType) {
        HMSegmentedControlBorderTypeNone = 0,
        HMSegmentedControlBorderTypeTop = (1 << 0),
        HMSegmentedControlBorderTypeLeft = (1 << 1),
        HMSegmentedControlBorderTypeBottom = (1 << 2),
        HMSegmentedControlBorderTypeRight = (1 << 3)
        };
        
        enum {
        HMSegmentedControlNoSegment = -1   // Segment index for no selected segment
        };
        
        typedef enum {
        HMSegmentedControlTypeText,
        HMSegmentedControlTypeImages,
        HMSegmentedControlTypeTextImages
        } HMSegmentedControlType; // 选择按钮放的东西
        
        @interface HMSegmentedControl : UIControl
        
        @property (nonatomic, strong) NSArray *sectionTitles;
        @property (nonatomic, strong) NSArray *sectionImages;
        @property (nonatomic, strong) NSArray *sectionSelectedImages;
        
3.练习富文本的使用，再开一个demo
        
