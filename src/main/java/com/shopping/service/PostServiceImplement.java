package com.shopping.service;

import com.shopping.dao.PostDao;
import com.shopping.entity.Post;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class PostServiceImplement implements PostService{
    @Autowired
    private PostDao postDao;
    @Override
    public List<Post> getPostByProductId(int productId){
        return postDao.getPostByProductId(productId);
    }
   @Override
    public void addPost(Post post)
   {
       postDao.addPost(post);
   }
   @Override
   public Post getPostByPostId(int postId){return postDao.getPostByPostId(postId);};
}
