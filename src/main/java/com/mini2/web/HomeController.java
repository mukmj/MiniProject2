package com.mini2.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mini2.web.bean.SignUpBean;


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
		} else {
			id = "";
		}
		
		req.setAttribute("id", id);
		
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
		//System.out.println(id + pw);
		session.insert("mini.signUp", sub);

		return "redirect:/loginView";
	}

	@RequestMapping(value = "/idTest", method = RequestMethod.POST)
	public String idTest(HttpServletRequest req, HttpServletResponse res) {
		String msg = "";
		String id2 = req.getParameter("id2");
		
		SignUpBean subList = (SignUpBean)session.selectList("mini.idCheck", id2);
		
		if(subList.getId().equals("")) {
			System.out.println(1);
		} else {
			System.out.println(2);
		}
//			for(int i = 0 ; i < subList.size(); i++) {
//				System.out.println(subList.get(i).getId());
//				if(subList.get(i).getId().equals(id2)) {
//					System.out.println("DB:" + subList.get(i).getId());
//					System.out.println("입력한 ID" + id2);
//					msg = "아이디 중복";
//				} else {
//					System.out.println("DB:" + subList.get(i).getId());
//					System.out.println("입력한 ID" +id2);
//					msg = "사용 가능";
//				}
//			}
		req.setAttribute("msg", msg);
		return "signUp";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(HttpServletRequest req, HttpServletResponse res, HttpSession hs) {
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");

		List<SignUpBean> infoList = session.selectList("mini.login");
		try {
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out;
			out = res.getWriter();
			for(int i = 0 ; i < infoList.size(); i++ ) {
				if(infoList.get(i).getId().equals(id) && infoList.get(i).getPw().equals(pw)) {
					out.println("<script>alert('로그인 성공'); location.href='/';</script>");
					hs.setAttribute("id", id);
				}else {
					out.println("<script>alert('로그인 실패'); location.href='/loginView'</script>");
				}
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession hs) {
		hs.invalidate();
		return "redirect:/";
	}
}
