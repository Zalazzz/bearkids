-- vue_server 创建目录
-- 单独创建目录，不同于脚手架目录
-- 设置uft8的编码方式
set names utf8;

-- 删除数据库，如果已存在bearkids数据库
drop database if exists bearkids;

-- 建库
create database bearkids charset=utf8;

-- 进入bearkids数据库
use bearkids;

-- 建表
create table bks_login(
  id int primary key auto_increment,
  uname varchar(50),
  upwd varchar(32),
  email varchar(32),
  avatar varchar(128)
);

-- 添加数据
insert into bks_login values(
  null,"tom",md5('123'),null,null
);

insert into bks_login values(
  null,"jerry",md5('123'),null,null
);

-- 导入数据
-- 从首页开始==>向列表页==>详情页开始建表
-- 从首页开始的每个按钮都和后面两张表相关

-- 分析:
  -- 1.首页轮播图的张图片点击都能指向详情页对应的商品
  -- 2.首页导航的每张图片点击都能指向对应的列表页
  -- 3.首页商品的每张图片点击都能指向对应的详情页

-- 首页 index

-- 首页顶部标题
create table bks_index_brand_img(
  bid int primary key auto_increment,
  img varchar(255)
);

insert into bks_index_brand_img values
(null,'imgs/index/1538297460210814.png');



-- 首页轮播图广告商品
create table bks_index_carousel(
  cid int primary key auto_increment,
  img varchar(255),
  title varchar(64),
  href varchar(128)
);

-- 首页轮播广告商品导入数据
insert into bks_index_carousel values
(null,'imgs/index/tmp1533718735_1741369_s.jpg','轮播广告商品1','product_details.html?pid=12'),
(null,'imgs/index/tmp1522029707_1656014_s.jpg','轮播广告商品1','product_details.html?pid=15'),
(null,'imgs/index/tmp1538293878_1734504_s.jpg','轮播广告商品1','product_details.html?pid=1'),
(null,'imgs/index/tmp1532592561_1734504_s.jpg','轮播广告商品2','product_details.html?pid=2');


-- 首页导航
create table bks_index_navgation(
  nid int primary key auto_increment,
  title varchar(64),
  img varchar(255),
  href varchar(128)
);

-- 首页导航数据导入,指向列表页
insert into bks_index_navgation values
  (null,"当季热销","imgs/index/6704947_1532592777.png","product_list.html?hid=1"),
  (null,"女童","imgs/index/6704933_1532592765.png","product_list.html?hid=2"),
  (null,"男童","imgs/index/6704915_1532592747.png","product_list.html?hid=3"),
  (null,"配饰","imgs/index/6704907_1532592734.png","product_list.html?hid=4"),
  (null,"鞋子","imgs/index/6704900_1532592721.png","product_list.html?hid=5"),
  (null,"运动","imgs/index/6704892_1532592710.png","product_list.html?hid=6"),
  (null,"婴儿","imgs/index/6704888_1532592698.png","product_list.html?hid=7"),
  (null,"裙子","imgs/index/6704880_1532592687.png","product_list.html?hid=8");

  -- 热门推荐
  create table bks_index_hot(
    hotid int primary key auto_increment,
    img varchar(255),
    href varchar(128)
  );

  -- 导入数据
  insert into bks_index_hot values
  (null,"imgs/index/5b5984b5de4b5.jpg","#"),
  (null,"imgs/index/5b5984a8e2def.jpg","#"),
  (null,"imgs/index/5b59849ac100e.jpg","#");

-- 首页商品 推荐列表
create table bks_index_product(
  pid int primary key auto_increment,
  title varchar(64),
  price decimal(16,2),
  img varchar(255),
  href varchar(128)
);

-- 首页商品导入数据,指向详情页
insert into bks_index_product values
(null,"婴童纯棉半袖T恤",75.00,"imgs/index/6705619_1532593788.jpg","product_detail.html?pid=3"),
(null,"婴童纯棉半袖T恤",93.00,"imgs/index/6705630_1532593801.jpg","product_detail.html?pid=4"),
(null,"婴童纯棉半袖T恤",199.00,"imgs/index/6705637_1532593812.jpg","product_detail.html?pid=5"),
(null,"婴童纯棉半袖T恤",250.00,"imgs/index/6705646_1532593826.jpg","product_detail.html?pid=6"),
(null,"婴童纯棉半袖T恤",99.00,"imgs/index/6705655_1532593838.jpg","product_detail.html?pid=7"),
(null,"婴童纯棉半袖T恤",58.00,"imgs/index/6705662_1532593851.jpg","product_detail.html?pid=8"),
(null,"婴童纯棉半袖T恤",110.00,"imgs/index/5b5984b5de4b5.jpg","product_detail.html?pid=9"),
(null,"婴童纯棉半袖T恤",132.00,"imgs/index/5b5984a8e2def.jpg","product_detail.html?pid=10"),
(null,"婴童纯棉半袖T恤",154.00,"imgs/index/5b59849ac100e.jpg","product_detail.html?pid=11");

/************************/

desc  bks_product_lists_body;
-- 列表页product_list
-- 1.创建-->配饰表
create table bks_product_lists_accessory(
  laid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
-- 导入数据
insert into bks_product_lists_accessory values
(null,"女童宝宝公主小孩春秋幼儿1-3岁2鸭舌帽",45.00,"imgs/lists/accessory/3797090_1521533485.jpg"),
(null,"女童手拎包冰雪奇缘爱莎公主配饰包索菲亚小包女孩",92.63,"imgs/lists/accessory/3796970_1521533238.jpg"),
(null,"儿童眼镜框无镜片眼镜眼镜架儿童摄影配饰",61.39,"imgs/lists/accessory/3796851_1521533049.jpg"),
(null,"儿童配饰男童双肩背包儿童包包男中大童书包小学生双肩包",199.00,"imgs/lists/accessory/3796728_1521532837.jpg"),
(null,"儿童卡通雨伞",89.00,"imgs/lists/accessory/3796536_1521532635.jpg"),
(null,"纯棉纱布吸汗巾(10条装)垫背巾婴儿隔汗巾",186.78,"imgs/lists/accessory/3796221_1521532377.jpg"),
(null,"儿童配饰遮阳帽18新品潮流童帽",78.36,"imgs/lists/accessory/3795986_1521532148.jpg"),
(null,"儿童帽子棒球帽春夏网眼帽男童遮阳帽秋款女童太阳帽",66.66,"imgs/lists/accessory/3795802_1521531910.jpg"),
(null,"新款秋冬男童遮阳鸭舌帽平檐帽太阳帽",68.21,"imgs/lists/accessory/3795627_1521531697.jpg"),
(null,"精装男童领结儿童领结韩版配饰小西装礼服衬",56.98,"imgs/lists/accessory/3795473_1521531469.jpg");

-- 2.创建-->婴童表
create table bks_product_lists_baby(
  lbid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
insert into bks_product_lists_baby values
(null,"新生儿内衣两件套",199.98,"imgs/lists/baby/3691905_1521187548.jpg"),
(null,"婴儿衣服 宝宝套装春秋 男女婴幼童纯色亲肤前开套装上衣长裤",256.12,"imgs/lists/baby/3691449_1521187230.jpg"),
(null,"针织长款宝宝新生儿连体衣服",169.69,"imgs/lists/baby/3672913_1521167602.jpg"),
(null,"婴儿套装春秋装两件套婴幼儿服装宝宝衣服外出服",269.63,"imgs/lists/baby/3671636_1521166102.jpg"),
(null,"婴儿衣服套装新生儿礼盒纯棉初生幼儿内衣宝宝和尚服",188.88,"imgs/lists/baby/3670715_1521163885.jpg"),
(null,"婴儿连体衣外出服",99.99,"imgs/lists/baby/3671435_1521165730.jpg"),
(null,"婴儿衣服新生儿连体衣服装春秋季婴儿连体睡衣",69.99,"imgs/lists/baby/3671093_1521164830.jpg"),
(null,"婴儿衣服秋冬宝宝连体衣纯棉新生儿哈衣小圆领",167.26,"imgs/lists/baby/3670923_1521164390.jpg"),
(null,"婴儿衣服春秋冬装宝宝衣服婴儿内衣婴儿连体衣",168.36,"imgs/lists/baby/3670576_1521163539.jpg"),
(null,"童泰婴儿衣服新生儿和尚服初生儿纯棉内衣套装0-3个月",256.96,"imgs/lists/baby/3662952_1521107454.jpg");


-- 3.创建--> 中大童表
create table bks_product_lists_cuhkChild(
  lcid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
insert into bks_product_lists_cuhkChild values
(null,"春连帽儿童运动休闲针织上衣",168.36,"imgs/lists/cuhkChild/3690422_1521186540.jpg"),
(null,"春季新款男小童羽绒风衣儿童",178.23,"imgs/lists/cuhkChild/3690145_1521186343.jpg"),
(null,"女童羽绒服2018春季款儿童羽绒夹克时尚连帽上衣",163.39,"imgs/lists/cuhkChild/3689830_1521186098.jpg"),
(null,"春季新款中大童外套长裤两件套装",167.89,"imgs/lists/cuhkChild/3689415_1521185836.jpg"),
(null,"儿童加厚保暖外套2017冬季新款摇粒绒两件套",189.89,"imgs/lists/cuhkChild/3688426_1521184828.jpg"),
(null,"童装女童中大童带帽2017秋季款儿童户外运动服风衣外套",99.36,"imgs/lists/cuhkChild/3688158_1521184433.jpg"),
(null,"女童打底衫条纹高领纯色套头衫针织衫",236.45,"imgs/lists/cuhkChild/3662519_1521106328.jpg"),
(null,"童装女童蝴蝶结长袖风衣外套上衣",248.63,"imgs/lists/cuhkChild/3662256_1521106057.jpg"),
(null,"男女童外套春秋保暖儿童外套连帽上衣外出服",159.95,"imgs/lists/cuhkChild/3661519_1521105331.jpg"),
(null,"男女童外套婴儿卫衣宝宝上衣外出服长袖开衫春秋",200.69,"imgs/lists/cuhkChild/3661256_1521105079.jpg");

-- 4.创建-->鞋表
create table bks_product_lists_shoes(
  lsid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
insert into bks_product_lists_shoes values
(null,"巴布豆童鞋女童鞋2018新款儿童运动鞋轻便透气网布鞋女鞋休闲",199.00,"imgs/lists/shoes/3698351_1521192661.jpg"),
(null,"毛毛虫儿童运动鞋 经典红",188.00,"imgs/lists/shoes/3698096_1521192386.jpg"),
(null,"男童鞋儿童运动鞋",133.97,"imgs/lists/shoes/3683263_1521179852.jpg"),
(null,"一脚蹬防滑保暖跑步鞋儿童运动鞋",169.69,"imgs/lists/shoes/3683187_1521179583.jpg"),
(null,"8春季新款儿童小白鞋皮鞋贝壳头休闲舒适男女童板鞋",156.33,"imgs/lists/shoes/3682641_1521178779.jpg"),
(null,"女童休闲跑步鞋儿童春季运动鞋子",189.96,"imgs/lists/shoes/3682135_1521178187.jpg"),
(null,"儿童运动鞋 男女时尚休闲鞋",146.96,"imgs/lists/shoes/3681984_1521177961.jpg"),
(null,"男童鞋 儿童运动鞋 女童休闲鞋 跑步鞋",78.89,"imgs/lists/shoes/3679085_1521172904.jpg"),
(null,"儿童运动鞋男童中大童运动鞋拼色跑鞋",96.36,"imgs/lists/shoes/3679029_1521172728.jpg"),
(null,"毛毛虫儿童运动鞋 经典红",256.45,"imgs/lists/shoes/3678946_1521172484.jpg");


-- 5.创建-->运动表
create table bks_product_lists_sport(
  lspid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
insert into bks_product_lists_sport values
(null,"儿童中大童短袖纯棉T恤打底衫小孩纯棉圆领夏装",200.36,"imgs/lists/sport/3696758_1521190865.jpg"),
(null,"运动套装女童套装2018春装新款中大童休闲韩版洋气小女孩",199.99,"imgs/lists/sport/3678854_1521172191.png"),
(null,"秋装新款休闲运动套装上衣+长裤韩版女2件套",169.78,"imgs/lists/sport/3678538_1521171743.jpg"),
(null,"女小童装18年春运动服套装",168.53,"imgs/lists/sport/3678362_1521171574.jpg"),
(null,"童装女小童运动套装针织运动两件套",111.99,"imgs/lists/sport/3678109_1521171379.jpg"),
(null,"春季男宝宝卫衣运动套装纯棉男童时尚棒球服两件套",148.98,"imgs/lists/sport/3677727_1521171161.jpg"),
(null,"女童套装儿童运动两件套套装女中大童套装36734741经典黑",155.69,"imgs/lists/sport/3677550_1521170979.jpg"),
(null,"童装女童套装春装2018新款小童中大童儿童套装女孩",97.65,"imgs/lists/sport/3677068_1521170522.jpg"),
(null,"童装男童套装春秋装2018新款运动卫衣儿童套装男女孩时尚连帽",259.68,"imgs/lists/sport/3676916_1521170365.jpg");

-- 6.创建-->幼小童表
create table bks_product_lists_youngChild(
  lyid int primary key auto_increment,
  title varchar(255),
  price decimal(16,2),
  img varchar(255)
);
insert into bks_product_lists_youngChild values
(null,"童装女童T恤纯棉圆领上衣休闲长袖外出服春秋款",145.55,"imgs/lists/youngChild/3695088_1521189510.jpg"),
(null,"迪士尼童装男童外套春秋男宝宝摇粒绒保暖连帽外套上衣",168.59,"imgs/lists/youngChild/3694322_1521189089.jpg"),
(null,"男童卫衣纯棉男宝宝外套长袖连帽上衣春秋款",158.79,"imgs/lists/youngChild/3693785_1521188750.jpg"),
(null,"卫衣运动套装纯棉男童套装棒球服春秋款",139.89,"imgs/lists/youngChild/3693462_1521188514.jpg"),
(null,"男女春秋套装纯棉外出服纯色宝宝带帽卫衣套装",169.66,"imgs/lists/youngChild/3692758_1521188157.jpg"),
(null,"童装2018夏新品女童运动风短袖套装潮宝宝休闲两件套",130.99,"imgs/lists/youngChild/3659564_1521103203.jpg"),
(null,"童装女童海军领套装夏季纯棉薄款宝宝短袖裙裤两件套 深柔粉",96.58,"imgs/lists/youngChild/3659410_1521102800.jpg"),
(null,"童装纯棉女童短袖套装T恤短裤休闲两件套2018年夏新品",153.69,"imgs/lists/youngChild/3658862_1521101917.jpg"),
(null,"童装2018夏新品女童荷叶袖套装宝宝纯棉背心短裤两件套 本白",96.36,"imgs/lists/youngChild/3658552_1521101474.jpg"),
(null,"童装2018春女童春秋内衣套装长袖睡衣 粉底彩点",196.35,"imgs/lists/youngChild/3658321_1521101167.jpg");


/***********购物车列表***********/
-- 购物车表：与用户表的id相关联，和商品列表的id相关联
create table bks_cart(
  id int primary key auto_increment,
  img varchar(255),
  price decimal(16,2),
  title varchar(255),
  count int,
  uid int
);




-- 详情页product_details
-- 创建product_details_cuhkChild(表
create table bks_product_details_cuhkChild(
  id int primary key auto_increment,
  title varchar(128),
  price decimal(16,2),
  carouselImg varchar(255),
  detailImg varchar(255),
  pid int
);

insert into bks_product_details_cuhkChild values
(null,
"春连帽儿童运动休闲针织上衣",
168.36,

"imgs/details/cuhkChild/3690489_1521186589.jpg,imgs/details/cuhkChild/3690489_1521186589.jpg,imgs/details/cuhkChild/3690489_1521186589.jpg,imgs/details/cuhkChild/3690489_1521186589.jpg",

"imgs/details/cuhkChild/1521186626493133.jpg,imgs/details/cuhkChild/1521186626786478.jpg,imgs/details/cuhkChild/1521186626182331.jpg,imgs/details/cuhkChild/1521186627588421.jpg",
1
),
(null,
"春季新款男小童羽绒风衣儿童",
178.23,

"imgs/details/cuhkChild/3690145_1521186343.jpg,imgs/details/cuhkChild/3690157_1521186358.jpg,imgs/details/cuhkChild/3690157_1521186358.jpg,imgs/details/cuhkChild/3690157_1521186358.jpg",

"imgs/details/cuhkChild/1521186414642496.jpg,imgs/details/cuhkChild/1521186414373570.jpg,imgs/details/cuhkChild/1521186415501640.jpg,imgs/details/cuhkChild/1521186416973533.jpg,imgs/details/cuhkChild/1521186416582237.jpg",
2
),
(null,"女童羽绒服2018春季款儿童羽绒夹克时尚连帽上衣",163.39,

"imgs/details/cuhkChild/3689830_1521186098.jpg,imgs/details/cuhkChild/3689856_1521186115.jpg,imgs/details/cuhkChild/3689883_1521186128.jpg,imgs/details/cuhkChild/3689900_1521186140.jpg",

"imgs/details/cuhkChild/1521186165687595.jpg,imgs/details/cuhkChild/1521186166247474.jpg,imgs/details/cuhkChild/1521186167629494.jpg,imgs/details/cuhkChild/1521186169927753.jpg,imgs/details/cuhkChild/1521186168288049.jpg,imgs/details/cuhkChild/1521186166183951.jpg,imgs/details/cuhkChild/1521186166306548.jpg",
3
),
(null,"春季新款中大童外套长裤两件套装",167.89,"imgs/details/cuhkChild/3689415_1521185836.jpg,imgs/details/cuhkChild/3689437_1521185851.jpg,imgs/details/cuhkChild/3689466_1521185865.jpg,imgs/details/cuhkChild/3689487_1521185879.jpg",

"imgs/details/cuhkChild/1521185935924633.jpg,imgs/details/cuhkChild/3689415_1521185836.jpg,imgs/details/cuhkChild/3689437_1521185851.jpg,imgs/details/cuhkChild/3689466_1521185865.jpg,imgs/details/cuhkChild/1521185937966518.jpg,imgs/details/cuhkChild/1521185938394608.jpg,imgs/details/cuhkChild/1521185938998493.jpg",
4
),
(null,"儿童加厚保暖外套2017冬季新款摇粒绒两件套",189.89,"imgs/details/cuhkChild/3688426_1521184828.jpg,imgs/details/cuhkChild/3688434_1521184847.jpg,imgs/details/cuhkChild/3688450_1521184873.jpg,imgs/details/cuhkChild/3688463_1521184894.jpg",

"imgs/details/cuhkChild/1521184944877921.jpg,imgs/details/cuhkChild/1521184951478622.jpg,imgs/details/cuhkChild/1521184947111583.jpg,imgs/details/cuhkChild/1521184946299729.jpg,imgs/details/cuhkChild/1521184948516320.jpg,imgs/details/cuhkChild/1521184950959630.jpg,imgs/details/cuhkChild/1521184952283519.jpg,imgs/details/cuhkChild/1521184954117021.jpg,imgs/details/cuhkChild/1521184955269925.jpg,imgs/details/cuhkChild/1521184956169116.jpg,imgs/details/cuhkChild/1521184957962173.jpg",
5
),
(null,"童装女童中大童带帽2017秋季款儿童户外运动服风衣外套",99.36,"imgs/details/cuhkChild/3688158_1521184433.jpg,imgs/details/cuhkChild/3688170_1521184449.jpg,imgs/details/cuhkChild/3688158_1521184433.jpg,imgs/details/cuhkChild/3688170_1521184449.jpg",

"imgs/details/cuhkChild/1521184528127816.jpg,imgs/details/cuhkChild/1521184529383098.jpg,imgs/details/cuhkChild/1521184529118676.jpg,imgs/details/cuhkChild/1521184529201370.jpg,imgs/details/cuhkChild/1521184530121973.jpg,imgs/details/cuhkChild/1521184530727284.jpg",
6
),
(null,"女童打底衫条纹高领纯色套头衫针织衫",236.45,"imgs/details/cuhkChild/3662519_1521106328.jpg,imgs/details/cuhkChild/3662524_1521106341.jpg,imgs/details/cuhkChild/3662526_1521106352.jpg,imgs/details/cuhkChild/662528_1521106365.jpg",

"imgs/details/cuhkChild/1521106394839102.jpg,imgs/details/cuhkChild/1521106395971795.jpg,imgs/details/cuhkChild/1521106396197850.jpg,imgs/details/cuhkChild/1521106396626906.jpg,imgs/details/cuhkChild/1521106397297721.jpg,imgs/details/cuhkChild/1521106397112461.jpg,imgs/details/cuhkChild/1521106399866961.jpg,imgs/details/cuhkChild/1521106399989883.jpg,imgs/details/cuhkChild/1521106400490845.jpg,imgs/details/cuhkChild/1521106400291286.jpg,imgs/details/cuhkChild/1521106400979192.jpg,imgs/details/cuhkChild/1521106401164179.jpg,imgs/details/cuhkChild/1521106401962171.jpg",
7
),
(null,"童装女童蝴蝶结长袖风衣外套上衣",248.63,"imgs/details/cuhkChild/3662256_1521106057.jpg,imgs/details/cuhkChild/3662279_1521106073.jpg,imgs/details/cuhkChild/3662289_1521106087.jpg,imgs/details/cuhkChild/3690829_1521186811.jpg",

"imgs/details/cuhkChild/1521106125674907.jpg,imgs/details/cuhkChild/1521106125914276.jpg,imgs/details/cuhkChild/1521106125356435.jpg,imgs/details/cuhkChild/1521106126972763.jpg,imgs/details/cuhkChild/1521106126643132.jpg,imgs/details/cuhkChild/1521106127772658.jpg,imgs/details/cuhkChild/1521106127614022.jpg,imgs/details/cuhkChild/1521106127590176.jpg,imgs/details/cuhkChild/1521106128166898.jpg,imgs/details/cuhkChild/1521106128882230.jpg,imgs/details/cuhkChild/1521106129110746.jpg,imgs/details/cuhkChild/1521106129601368.jpg",
8
),
(null,"男女童外套春秋保暖儿童外套连帽上衣外出服",159.95,"imgs/details/cuhkChild/3661519_1521105331.jpg,imgs/details/cuhkChild/3661533_1521105345.jpg,imgs/details/cuhkChild/3690740_1521186748.jpg,imgs/details/cuhkChild/3661519_1521105331.jpg,imgs/details/cuhkChild/3661533_1521105345.jpg,imgs/details/cuhkChild/3690740_1521186748.jpg",

"imgs/details/cuhkChild/1521105383892214.jpg,imgs/details/cuhkChild/1521105383549949.jpg,imgs/details/cuhkChild/1521105384192587.jpg,imgs/details/cuhkChild/1521105384456565.jpg,imgs/details/cuhkChild/1521105385945059.jpg,imgs/details/cuhkChild/1521105385681444.jpg,imgs/details/cuhkChild/1521105385309657.jpg",
9
),
(null,"男女童外套婴儿卫衣宝宝上衣外出服长袖开衫春秋",200.69,"imgs/details/cuhkChild/3661256_1521105079.jpg,imgs/details/cuhkChild/3661275_1521105093.jpg,imgs/details/cuhkChild/3661290_1521105110.jpg,imgs/details/cuhkChild/3690691_1521186717.jpg",

"imgs/details/cuhkChild/1521105158985156.jpg,imgs/details/cuhkChild/1521105158343458.jpg,imgs/details/cuhkChild/1521105159679925.jpg,imgs/details/cuhkChild/1521105159290392.jpg,imgs/details/cuhkChild/1521105160659056.jpg,imgs/details/cuhkChild/1521105160626039.jpg,imgs/details/cuhkChild/1521105161103217.jpg",
10
);
