package com.shopping.controller;

import com.shopping.service.PostService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class PostController {
    @Resource
    private PostService postService;

}
