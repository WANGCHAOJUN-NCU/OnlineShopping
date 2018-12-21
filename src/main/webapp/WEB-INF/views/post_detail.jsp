<%--
  Created by IntelliJ IDEA.
  User: haidai
  Date: 2018/12/20
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>帖子</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<jsp:include page="include/header.jsp"/>
<div class="row" style="background-color: #303F9F">
    <div class="col-sm-1 col-md-1 col-lg-1"></div>
    <div class="col-sm-10 col-md-10 col-lg-10">
        <table class="table CommentTable" border="0" id="Post" style="color: white;">
            </table>
        <table class="table CommentTable" border="0" id="Reply" style="color: white;">
        </table>
        <hr/>
        <div id="inputArea"></div>
    </div>
</div>
<%--<jsp:include page="include/foot.jsp"/>--%>
<script type="text/javascript">
    listPosts();
    listReply();
    function listPosts() {
        var Post = ${postDetail.id};
        var PostsTable = document.getElementById("Post");
        var html = "";

        PostsTable.innerHTML="";
        html += '<tr>' +
            '<th>' + "发帖人"+ '</th>' +
            '<td>' + "帖子标题"+ '</td>' +
            '<td>' + "发帖时间"+ '</td>'+
            '<td>' + "发帖内容"+ '</td>'+
        '</tr>';
            var user = getUserById(${postDetail.id});

            html += '<tr>' +
                '<td>' + user.nickName + '</td>' +
                '<td>'  +'${postDetail.title}' + '</td>' +
                '<td>' + '${postDetail.time}' + '</td>' +
                '<td>' + '${postDetail.content}' + '</td>' +
                '</tr>';

        PostsTable.innerHTML += html;
    }
    function listReply() {
        var Replies = getReply();
        var ReplyTable = document.getElementById("Reply");
        var html = "";
        ReplyTable.innerHTML="";
        document.getElementById("inputArea").value="";
        html += '<tr>' +
            '<th>' + "回复用户"+ '</th>' +
            '<td>' + "回复内容"+ '</td>' +
            '<td>' + "回复时间"+ '</td>' +
        '</tr>';
        for (var i = 0; i < Replies.length; i++) {
            html += '<tr>' +
                '<th>' + Replies[i].userId + '</th>' +
                '<td>' + Replies[i].content+ '</td>' +
                '<td>' + Replies[i].time + '</td>' +
                '</tr>';
        }
        ReplyTable.innerHTML += html;
        var inputArea = document.getElementById("inputArea");
        inputArea.innerHTML="";
        // if (getUserProductRecord() === "true") {
            var inputArea = document.getElementById("inputArea");
            html = '<div class="col-sm-12 col-md-12 col-lg-12">' +
                '<textarea class="form-control" rows="4" id="ReplyText"></textarea>' +
                '</div>' +
                '<div class="col-sm-12 col-md-12 col-lg-12">' +
                '<div class="col-sm-4 col-md-4 col-lg-4"></div>' +
                '<button class="btn btn-primary btn-lg CommentButton col-sm-4 col-md-4 col-lg-4" style="background-color: #FF9800;" onclick="addReply()">回复</button>' +
                '</div>';
            inputArea.innerHTML += html;
        //}

    }

    function getUserById(id) {
        var userResult = "";
        var user = {};
        user.id = id;
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getUserById',
            data: user,
            dataType: 'json',
            success: function (result) {
                userResult = result.result;
            },
            error: function (result) {
                layer.alert('查询错误');
            }
        });
        userResult = JSON.parse(userResult);
        return userResult;
    }

    function getReply() {
        var Reples = "";
        var post = {};
        post.postId = ${postDetail.id};
        $.ajax({
            async: false, //设置同步
            type: 'POST',
            url: '${cp}/getReply',
            data: post,
            dataType: 'json',
            success: function (result) {
                Reples = result.result;
            },
            error : function(XmlHttpRequest) {
                alert(XmlHttpRequest.responseText)
            }
        });
        Reples = eval("(" + Reples + ")");
        return Reples;

    }
    function addReply() {
        var inputText = document.getElementById("ReplyText").value;
        var Reply = {};
        Reply.userId = ${currentUser.id};
        Reply.postId = ${postDetail.id};
        Reply.content = inputText;
        var addResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addReply',
            data: Reply,
            dataType: 'json',
            success: function (result) {
                addResult = result.result;
            },
            error: function (result) {
                layer.alert('查询用户错误');
            }
        });
        if (addResult = "success") {
            layer.msg("回复成功", {icon: 1});
            window.location.href = "${cp}/post_detail";
        }
    }
</script>
</body>
</html>
