<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改商品</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/ajaxfileupload.js" type="text/javascript"></script><!--图片上传插件-->
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!--导航栏部分-->
<jsp:include page="include/header.jsp"/>

<!-- 中间内容 -->
<div class="container-fluid" style="color:white">
    <h1 class="title center">修改商品信息</h1>
    <br/>
    <div class="col-sm-offset-2 col-md-offest-2">
        <!-- 表单输入 -->
        <div  class="form-horizontal">
            <div class="form-group">
                <label for="productName" class="col-sm-2 col-md-2 control-label">商品名称</label>
                <div class="col-sm-6 col-md-6">
                    <input type="text" class="form-control" id="productName" placeholder="新商品" readonly />
                </div>
            </div>
            <div class="form-group">
                <label for="productDescribe" class="col-sm-2 col-md-2 control-label">商品描述</label>
                <div class="col-sm-6 col-md-6">
                    <textarea type="text" class="form-control" id="productDescribe" placeholder="新商品描述"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="keyWord" class="col-sm-2 col-md-2 control-label">关键词</label>
                <div class="col-sm-6 col-md-6">
                    <textarea type="text" class="form-control" id="keyWord" placeholder="新关键词"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="productPrice" class="col-sm-2 col-md-2 control-label">商品价格</label>
                <div class="col-sm-6 col-md-6">
                    <input type="text" class="form-control" id="productPrice" placeholder="仅限人民币" />
                </div>
            </div>
            <div class="form-group">
                <label for="productCount" class="col-sm-2 col-md-2 control-label">商品数量</label>
                <div class="col-sm-6 col-md-6">
                    <input type="text" class="form-control" id="productCount" placeholder="请勿输入非法数量" />
                </div>
            </div>
            <div class="form-group">
                <label for="productType" class="col-sm-2 col-md-2 control-label">商品类别</label>
                <div class="col-sm-6 col-md-6">
                    <select name="productType" class="form-control" id="productType">
                        <option value="1">衣服配饰</option>
                        <option value="2">数码产品</option>
                        <option value="3">书籍办公</option>
                        <option value="4">游戏周边</option>
                        <option value="5">生活用品</option>
                        <option value="6">化妆用品</option>
                        <option value="7">运动用品</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-6" id="imgPreSee">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-6">
                    <button class="btn btn-lg btn-primary btn-block" type="submit" style="background-color: #FF9800;" onclick="startUpdate()">修改商品</button>
                </div>
            </div>
        </div>
        <br/>
    </div>
        <br/>
    </div>
</div>

<!--尾部-->
<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">
    initData();
    function initData() {
        var productDetailId = ${productDetail.id};
        var productDetail = getProductDetailById(productDetailId);
        document.getElementById("productName").value = productDetail.name;
        document.getElementById("productDescribe").value = productDetail.description;
        document.getElementById("keyWord").value = productDetail.keyWord;
        document.getElementById("productPrice").value = productDetail.price;
        document.getElementById("productCount").value = productDetail.counts;
        document.getElementById("productType").value = productDetail.type;
    }
    function startUpdate() {
        var loading = layer.load(0,{time: 1*1000});
        var productDetail = {};
        productDetail.name = document.getElementById("productName").value;
        productDetail.description = document.getElementById("productDescribe").value;
        productDetail.keyWord = document.getElementById("keyWord").value;
        productDetail.price= document.getElementById("productPrice").value;
        productDetail.counts = document.getElementById("productCount").value;
        productDetail.type = document.getElementById("productType").value;
        if(productDetail.name === ''){
            layer.msg('商品名不能为空',{icon:2});
            return;
        }
        else if(productDetail.name >= 20){
            layer.msg('商品名不超过20个字符',{icon:2});
            return;
        }
        if(productDetail.keyWord === ''){
            layer.msg('关键字不能为空',{icon:2});
            return;
        }
        else if(productDetail.keyWord >= 15){
            layer.msg('关键字不超过15个字符',{icon:2});
            return;
        }
        if(productDetail.price === ''){
            layer.msg('商品价格不能为空',{icon:2});
            return;
        }
        if(productDetail.counts === ''){
            layer.msg('商品数量不能为空',{icon:2});
            return;
        }

        var productResult = null;
        $.ajax({
            async : false, //设置同步
            type : 'POST',
            url : '${cp}/doProductUpdate',
            data : productDetail,
            dataType : 'json',
            success : function(result) {
                productResult = result.result;
            },
            error : function(result) {
                layer.alert('修改失败!');
            }
        });
        if(productResult === 'success'){
            layer.close(loading);
            layer.msg('修改成功',{icon:1});
            window.location.href="${cp}/main";
        }
        else if(productResult === 'fail'){
            layer.msg('服务器异常',{icon:2});
        }
    }
    function getProductDetailById(id) {
        var productResult = "";
        var product = {};
        product.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getProductById',
            data: product,
            dataType: 'json',
            success: function (result) {
                productResult = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        productResult = JSON.parse(productResult);
        return productResult;
    }

</script>
</body>
</html>