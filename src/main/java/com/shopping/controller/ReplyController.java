package com.shopping.controller;

import com.shopping.entity.Post;
import com.shopping.service.PostService;
import com.shopping.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ReplyController {
    @Autowired private ReplyService replyService;
    @Autowired private PostService postService;
//    @RequestMapping(value = "/postDetail", method = RequestMethod.POST)
//    @ResponseBody
//    public Map<String, Object> postDetail(int id, HttpSession httpSession) {
//        System.out.println("I am here!" + id);
//        Post post = postService.getPostByPostId(id);
//        httpSession.setAttribute("postDetail", id);
//        Map<String, Object> resultMap = new HashMap<String, Object>();
//        resultMap.put("result", "success");
//        return resultMap;
//    }
//    @RequestMapping(value = "/post_detail")
//    public String post_detail() {
//        return "reply_detail";
//    }

}
