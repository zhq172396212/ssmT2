package com.xt.service;

import com.github.pagehelper.PageInfo;
import com.xt.utils.JsonUtil;
import com.xt.vo.Blog;

public interface BlogService {

    JsonUtil<PageInfo<Blog>> findAllBlog(Integer pageNumber,Integer pageSize );

    JsonUtil addBlog(Blog b);

	JsonUtil delBlog(int id);


}
