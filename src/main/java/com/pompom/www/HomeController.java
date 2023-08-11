package com.pompom.www;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pompom.www.board.dto.BoardDTO;
import com.pompom.www.board.dto.PagingVO;
import com.pompom.www.board.service.BoardService;
import com.pompom.www.member.controller.VerifyRecaptcha;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {

	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,PagingVO vo) {
		logger.info("Welcome home! The client locale is {}.", locale);

		List<BoardDTO> mainQuestionsList = boardService.mainQuestionsList();
		model.addAttribute("mainQuestionsList", mainQuestionsList);
		return "home";
	}

	@ResponseBody
	@RequestMapping(value = "/verifyRecaptcha", method = RequestMethod.POST)
	public int VerifyRecaptcha(HttpServletRequest request) {
		VerifyRecaptcha.setSecretKey("6LeiYhcnAAAAAGavaafk7CjE0TSG2Y-W32za4n8o");
		String gRecaptchaResponse = request.getParameter("recaptcha");
		System.out.println(gRecaptchaResponse);
		// 0 = 성공, 1 = 실패, -1 = 오류
		try {
			if (VerifyRecaptcha.verify(gRecaptchaResponse)) {
				System.out.println("wow");
				return 0;
			} else {
				return 1;
			}
		} catch (IOException e) {
			e.printStackTrace();
			return -1;
		}
	}

}
