package com.xt.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xt.service.BlogService;
import com.xt.utils.JsonUtil;
import com.xt.vo.Blog;

import java.util.List;

import org.aspectj.weaver.JoinPointSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("blog")
public class BlogController {

    @Autowired
    private BlogService service;

    @RequestMapping("/find")
    public @ResponseBody JsonUtil<PageInfo<Blog>> getBlogs(Integer pageNumber,Integer pageSize ){

        return  service.findAllBlog(pageNumber,pageSize);
    }


    @RequestMapping("/addBlog")
    public @ResponseBody JsonUtil  addBlog(Blog blog){

        return  service.addBlog(blog);
    }
    

    @RequestMapping("/delBlog")
    public @ResponseBody JsonUtil  delBlog(String[] bId){
    	JsonUtil json = new JsonUtil();
    	try {
    		for(String b:bId) {
        		service.delBlog(Integer.parseInt(b));
        	}
    	 
		} catch (Exception e) {
			json.setMsg(e.getMessage());
			json.setErrorCode("500");
			 e.printStackTrace();
		}
    	
    	return json;
    }
    
}
