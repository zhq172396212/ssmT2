package com.xt.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xt.dao.BlogMapper;
import com.xt.service.BlogService;
import com.xt.utils.JsonUtil;
import com.xt.vo.Blog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BlogServiceImpl implements BlogService {

    @Autowired
    private BlogMapper mapper;

    /*
    * 如果当前存在事务，则加入该事务；如果当前没有事务，则创建一个新的事务。这是默认值。*/
    @Transactional(readOnly = true,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil<PageInfo<Blog>> findAllBlog(Integer pageNumber,Integer pageSize ) {
        PageHelper.startPage(pageNumber,pageSize,"b_id desc");
        List<Blog> allBlog = mapper.findAllBlog();
        PageInfo<Blog>  page = new PageInfo<>(allBlog);
        JsonUtil jsonUtil = new JsonUtil("OK",page,"0");
        return jsonUtil;
    }

    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil addBlog(Blog b) {
        JsonUtil jsonUtil = new JsonUtil();
        int rows = mapper.insert(b);
        if (rows>0)
            jsonUtil.setMsg("OK");
        else
            jsonUtil.setErrorCode("500");
        return jsonUtil;
    }
    
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    @Override
    public JsonUtil delBlog(int id) {
        JsonUtil jsonUtil = new JsonUtil();
        int rows = mapper.deleteByPrimaryKey(id);
        if (rows>0)
            jsonUtil.setMsg("OK");
        else
            jsonUtil.setErrorCode("500");
        return jsonUtil;
    }
}
