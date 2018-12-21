package com.shopping.dao;

import com.shopping.entity.Reply;

import java.util.List;

public interface ReplyDao {
    public List<Reply> getReplyByPostId(int postId);
    public void addReply(Reply reply);
}
