// 导入express模块
const express = require("express");
// 导入连接池对象
const pool = require("../pool");
// 用express框架下的Router模块创建路由器
var router = express.Router();


// 功能一：登录功能
router.get("/login", (req, res) => {
  // 获取参数
  var uname = req.query.uname;
  var upwd = req.query.upwd;
  // console.log(uname);
  // console.log(upwd);
  // 后端验证用户名 用户密码与服务器端的一致
  // sql查询语句
  var sql = "select id from bks_login where uname=? and upwd=md5(?)";
  pool.query(sql, [uname, upwd], (err, result) => {
    if (err) throw err;
    if (result.length == 0) {
      res.send({
        code: -1,
        msg: "用户名或密码有误",
      });
    } else {
      // 当用户登录成功的时候，我们需要在session中记录用户的登录信息
      // 将bks_login中的id赋值给浏览器中的session会话保存，作为共享数据  !!!
      req.session.uid = result[0].id;
      res.send({
        code: 1,
        msg: "登录成功",
        data: {
          id: result[0].id,
          uname
        },
      })
    }
  })

});

//功能十：退出功能
router.get('/logout', (req, res) => {

  //移除当前session.uid
  req.session.uid = "";
  res.send({
    code: 0,
    msg: "成功退出"
  });
})

// 功能二:注册功能
router.get("/register", (req, res) => {
  // 获取前端发送的数据
  var uname = req.query.uname;
  var upwd = req.query.upwd;
  var email = req.query.email;
  // console.log(uname);
  // console.log(upwd);
  // console.log(email);
  // 后端 对获得的前端数据进行验证
  // 验证账号是否已被注册
  var sqlExists = "select id from bks_login where uname=?";
  pool.query(sqlExists, [uname], (err, result) => {
    if (err) throw err;
    if (result.length > 0) {
      res.send({
        code: 0,
        msg: "此用户名已存在"
      });
      return;
    } else {
      // 没有被注册才可以进行插入语句
      var sql = "insert into bks_login values(?,?,md5(?),?,?)";
      pool.query(sql, [null, uname, upwd, email, null], (err, result) => {
        if (err) throw err;
        if (result.affectedRows > 0) {
          res.send({
            code: 1,
            msg: "注册成功"
          });
        } else {
          res.send({
            code: -1,
            msg: "注册失败"
          })
        }
      })
    }
  })


});

// 功能三：加载服务器端首页标配数据
router.get("/index/brand", (req, res) => {
  var sql = "select bid,img from bks_index_brand_img";
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      res.send({
        code: 1,
        data: result
      });
    } else {
      res.send({
        code: -1,
        data: "查询失败"
      })
    }
  })
});

//功能四:获取服务端轮播图数据
router.get("/index/carousel", (req, res) => {
  var sql = "select cid,img,href,title from bks_index_carousel";
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      res.send({
        code: 1,
        data: result
      })
    } else {
      res.send({
        code: -1,
        data: "查询失败"
      })
    }
  })
});

//功能五:获取首页导航数据
router.get("/index/nav", (req, res) => {
  var sql = "select * from bks_index_navgation";
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      res.send({
        code: 1,
        data: result
      });
    } else {
      res.send({
        code: -1,
        data: "查询失败"
      })
    }
  })
});

//功能六:获取首页热门推荐数据
router.get("/index/hot", (req, res) => {
  var sql = "select * from bks_index_hot";
  pool.query(sql, [], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      res.send({
        code: 1,
        data: result
      });
    } else {
      res.send({
        code: -1,
        data: "查询失败"
      })
    }
  })
});

//功能七:获取首页每日推荐数据
router.get("/index/recommend", (req, res) => {
  //获取参数
  var pno = req.query.pno;
  var psize = req.query.psize;
  //设置默认值
  //如果没有传值
  if (!pno) {
    pno = 1
  };
  if (!psize) {
    psize = 4
  };
  //查询数据
  var sql = "select pid,title,price,img,href from bks_index_product limit ?,?";
  // 下一次从第几个开始查询
  var offset = (pno - 1) * psize;
  //注意啊 传过来的是字符串
  psize = parseInt(psize);
  pool.query(sql, [offset, psize], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      //将查询到的数据放入一个对象中
      var obj = {
        code: 1,
        data: result
      };
      //修改成员==>
      // obj.data=result;
      var sql = "select count(*) as c from bks_index_product";
      pool.query(sql, (err, result) => {
        if (err) throw err;
        //向上取整,求总页数
        var pc = Math.ceil(result[0].c / psize);
        //添加成员
        obj.pc = pc;
        res.send(obj);
        //  console.log(obj); 
      })
    } else {
      res.send({
        code: -1,
        data: "查询失败"
      })
    }

  
  });


});

//功能八:指定用户插入购物车数据
router.get('/mysort', (req, res) => {
  //当用户要操作购物车时，需要根据登录时就已经保存的session.uid，判断用户是否登录
  // console.log(req.session.uid);
  var uid = req.session.uid;
  // console.log(uid);
  if (!uid) {
    res.send({
      code: -1,
      msg: "您尚未登录，请登录后操作"
    });
    return;
  };
  let img = req.query.img;
  let price = req.query.price;
  let count = req.query.count;
  let title = req.query.title;
  // console.log(title);
  // console.log(img);
  // console.log(price);
  // console.log(count);
  //插入购物车表
  var sql = "insert into bks_cart values(?,?,?,?,?,?)";
  pool.query(sql, [null, img, price, title, count, uid], (err, result) => {
    if (err) throw err;
    // console.log(result);
    res.send({
      code: 1,
      msg: "成功加入购物车"
    });
  })
});

//功能九:查询指定用户购物车
router.get('/mycart', (req, res) => {
  var uid = req.session.uid;
  // console.log(uid);
  if (!uid) {
    res.send({
      code: -1,
      msg: "您尚未登录，请登录后操作"
    });
    return;
  };
  var sql = 'select img,price,title,count from bks_cart where uid=?';
  pool.query(sql, [uid], (err, result) => {
    if (err) throw err;
    // console.log(result);
    if (result.length > 0) {
      res.send({
        code: 1,
        msg: "查询成功",
        data: result
      });
    } else {
      res.send({
        code: -1,
        msg: "查询失败"
      });
    }
  })
});

//功能十一:查询分类中对应的列表
router.get("/mysort/cuhkChild",(req,res)=>{
  var sql='select lcid,title,img,price from bks_product_lists_cuhkchild';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

router.get("/mysort/youngchild",(req,res)=>{
  var sql='select lyid,title,img,price from bks_product_lists_youngchild';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

router.get("/mysort/baby",(req,res)=>{
  var sql='select lbid,title,img,price from bks_product_lists_baby';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

router.get("/mysort/sport",(req,res)=>{
  var sql='select lspid,title,img,price from bks_product_lists_sport';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

router.get("/mysort/accessory",(req,res)=>{
  var sql='select laid,title,img,price from bks_product_lists_accessory';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

router.get("/mysort/shoes",(req,res)=>{
  var sql='select lsid,title,img,price from bks_product_lists_shoes';
  pool.query(sql,(err,result)=>{
    if(err) throw err;
    if(result.length>0){
      res.send({code:1,msg:"查询成功",result});
    }else{
      res.send({code:-1,msg:"查询失败"});
    }
  });
});

//功能十二:查询不同类对应的详情页数据
router.get('/details/cuhkChild',(req,res)=>{
  let id=req.query.id;
  // console.log(id);
  var sql= 'select id,carouselImg,title,price,detailImg from bks_product_details_cuhkChild where pid=?';
  pool.query(sql,[id],(err,result)=>{
    if(err) throw err;
    // console.log(result);
    if(result.length>0){
      res.send({code:1,status:200,result});
    }else{
      res.send({code:-1,status:404});
    }
  });

  
})

//导出路由器
module.exports = router;