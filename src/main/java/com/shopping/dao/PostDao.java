package com.shopping.dao;

import com.shopping.entity.Post;

import java.util.List;

public interface PostDao {
    public List<Post> getPostByProductId(int productId);
    public void addPost(Post post);
    public Post getPostByPostId(int postId);

}
