package com.controller;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.frame.Service;
import com.frame.ServiceO;
import com.vo.BoardVO;
import com.vo.OrderDetailVO;
import com.vo.OrderVO;
import com.vo.ReviewVO;
import com.vo.UserVO;

@Controller
public class UserController {

	@Resource(name="uservice")
	Service<String, UserVO> uservice;
	
	@Resource(name = "bservice")
	Service<String, BoardVO> bservice;

	@Resource(name = "rservice")
	Service<String, ReviewVO> rservice;
	
	@Resource(name="oservice")
	ServiceO<String, OrderVO> oservice;
	
	@Resource(name="odservice")
	Service<String, OrderDetailVO> odservice;

	@RequestMapping("/uadd.mc")
	public ModelAndView add(ModelAndView mv) {
		mv.addObject("center", "user/add");
		mv.setViewName("main");
		return mv;
	}
	
	@RequestMapping("/uaddimpl.mc")
	public ModelAndView addimpl(UserVO user, ModelAndView mv,HttpServletResponse response, HttpSession session) {
		try {
			uservice.register(user);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('회원가입을 환영합니다! 다시 로그인해주세요'); location.href='main.mc'</script>");
			out.flush();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		mv.addObject("center","center");
		mv.setViewName("main");
		return mv;
	}

	@RequestMapping("/mypage.mc")
	public ModelAndView mypage(ModelAndView mv) {
		mv.addObject("center", "mypage/mypage_idx");
		mv.setViewName("main");
		return mv;
	}

	@RequestMapping(value = "/order_chk.mc")
	public ModelAndView orderchkview() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("center", "mypage/order_chk");
		mv.setViewName("main");
		return mv;
	}

	@RequestMapping(value = "/board_byme.mc")
	public ModelAndView boardview(HttpServletRequest request, HttpSession session) throws Exception {
		String id = (String) session.getAttribute("loginId");
		BoardVO v = new BoardVO();
		ReviewVO r = new ReviewVO();
		v.setUserid(id);
		r.setUserid(id);
		ArrayList<BoardVO> vo = bservice.getall(v);
		ArrayList<ReviewVO> vo2 = rservice.getall(r);
		ModelAndView mv = new ModelAndView();
		mv.addObject("blist", vo);
		mv.addObject("rlist", vo2);
		mv.addObject("center", "mypage/board_byme");
		mv.setViewName("main");
		return mv;
	}
	
	
	@ResponseBody
	@RequestMapping("/delChk.mc")
	public boolean delete(String id, String pwd)
			throws Exception {
		boolean data = false;
		UserVO dbUser = uservice.get(id);

		if (dbUser.getPwd().equals(pwd)) {
			data = true;
		}
		return data;
	}
	
	@RequestMapping("/del.mc")
	public String del(HttpSession session) throws Exception {
		String id = (String) session.getAttribute("loginId");
		uservice.remove(id);
		UserVO dbUser = uservice.get(id);
		
		if (session != null) {
			session.invalidate();
		}

		return "redirect:main.mc";
	}
	
	@RequestMapping("/uupdateimpl.mc")
	public String updateimpl(UserVO user) {
		try {
			uservice.modify(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String id = user.getUserid();
		return "redirect:mypage.mc";
	}
	
	@RequestMapping("/uupdate.mc")
	public ModelAndView update(ModelAndView mv, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		UserVO user = null;
		try {
			user = uservice.get(userId);
			mv.addObject("user", user);
			mv.addObject("center", "mypage/update");
			mv.setViewName("main");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	
	@RequestMapping("/ulist.mc")
	public ModelAndView list(ModelAndView mv, UserVO vo, HttpSession session) {
		String id = (String) session.getAttribute("loginid");
		if(!id.equals("admin")) {
			mv.setViewName("ilist.mc");
			return mv;
		}
		ArrayList<UserVO> list
		= null;
		try {
			list = uservice.getall(vo);
			mv.addObject("ulist", list);
			mv.addObject("center", "user/list");
			mv.setViewName("main");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/idChk.mc", method = RequestMethod.POST)
	public boolean idChk(String inputId) throws Exception {
		UserVO vo = uservice.get(inputId);
		if (vo == null)
			return true;
		else
			return false;
	}
}






