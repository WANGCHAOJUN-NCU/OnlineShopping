package com.shopping.controller;

import com.alibaba.fastjson.JSONArray;
import com.shopping.entity.Post;
import com.shopping.service.PostService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PostController {
    @Resource
    private PostService postService;
    @RequestMapping(value = "/getPostByProductId",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> getPost(int productId){
        List<Post> PostList = postService.getPostByProductId(productId);
        String Posts = JSONArray.toJSONString(PostList);
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",Posts);
        return resultMap;
    }

    @RequestMapping(value = "/addPost",method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> addPost(int userId, int productId,String title, String content){
            String result = null;
            Post post=new Post();
            post.setUserId(userId);
            post.setProductId(productId);
            Date date = new Date();
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
            post.setTime(sf.format(date));
            post.setTitle(title);
            post.setContent(content);
            postService.addPost(post);
            result = "success";
        Map<String,Object> resultMap = new HashMap<String,Object>();
        resultMap.put("result",result);
        return resultMap;
    }

    @RequestMapping(value = "/postDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> postDetail(int id, HttpSession httpSession) {
        System.out.println("I am here!" + id);
        Post post = postService.getPostByPostId(id);
        System.out.println(post.toString());
        httpSession.setAttribute("postDetail", post);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("result", "success");
        return resultMap;
    }
    @RequestMapping(value = "/post_detail")
    public String post_detail() {
        return "post_detail";
    }
}
