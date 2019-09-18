package com.mini2.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mini2.web.bean.SignUpBean;
import com.mini2.web.bean.WriteBean;


@Controller
public class HomeController {
	SignUpBean sub = new SignUpBean();
	
	@Autowired
	SqlSession session;
	
	@RequestMapping(value = "/")
	public String home(HttpServletRequest req, HttpSession hs) {
		String id = (String) hs.getAttribute("id");
		
		if(id != null) {
			System.out.println(id);
			req.setAttribute("id", id);
		} else {
			System.out.println("null임");
		}
		
		List<WriteBean> wbList = session.selectList("mini.select");
		
		req.setAttribute("wbList", wbList);
		
		return "home";
	}
	
	@RequestMapping("/loginView")
	public String loginView() {
		return "login";
	}
	
	@RequestMapping("/signUpView")
	public String signUpView() {
		return "signUp";
	}
	
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String signUp(HttpServletRequest req, HttpServletResponse res) {
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		sub.setId(id);
		sub.setPw(pw);

		session.insert("mini.signUp", sub);

		return "redirect:/loginView";
	}

	@RequestMapping(value = "/idTest", method = RequestMethod.POST)
	public String idTest(HttpServletRequest req, HttpServletResponse res) {
			String msg = "";
			String id2 = req.getParameter("id2");
			
			List<SignUpBean> subList = session.selectList("mini.idCheck", id2);
			
			if(subList.isEmpty()) {
				msg = "사용 가능한 ID입니다.";
				req.setAttribute("id2", id2);
			} else {
				msg = "중복된 ID입니다.";
			}
			req.setAttribute("msg", msg);
		return "signUp";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest req, HttpServletResponse res) {
		HttpSession hs = req.getSession();
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		SignUpBean sub = new SignUpBean();
		sub.setId(id);
		sub.setPw(pw);
		
		List<SignUpBean> infoList = session.selectList("mini.login", sub);
		
		try {
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out;
			out = res.getWriter();
			
			if(!infoList.isEmpty()) {
				out.println("<script>alert('로그인 성공'); location.href='/';</script>");
				hs.setAttribute("id", id);
			}else{
				out.println("<script>alert('로그인 실패'); location.href='/loginView'</script>");
			}	
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession hs) {
		hs.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(HttpServletRequest req, HttpServletResponse res) {
		HttpSession hs = req.getSession();
		
		String title = req.getParameter("title");
		String comment = req.getParameter("comment");
		String nickname = (String) hs.getAttribute("id");
		
		WriteBean wb = new WriteBean();
		wb.setTitle(title);
		wb.setComment(comment);
		wb.setNickname(nickname);
		
		session.insert("mini.insert", wb);
		
		return "redirect:/";
	}
	
	@RequestMapping("/delete")
	public String delete(HttpServletRequest req) {
		String no = req.getParameter("noPar");
		System.out.println(no);
		
		session.update("mini.delete", no);
		
		return "redirect:/";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest req, HttpServletResponse res) {
		String title = req.getParameter("title");
		String comment = req.getParameter("comment");
		String no = req.getParameter("num");
		
		WriteBean wb = new WriteBean();
		wb.setNo(no);
		wb.setTitle(title);
		wb.setComment(comment);
		
		session.update("mini.update", wb);
		
		System.out.println(no +"번" + title + ":" +comment);
		
		return "redirect:/";
	}
}
