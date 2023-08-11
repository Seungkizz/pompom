package com.pompom.www.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.member.service.MailSendService;
import com.pompom.www.member.service.MemberService;
import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.service.UploadService;
import com.pompom.www.util.Auth;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@Log4j
public class MemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private UploadService uploadService;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private MailSendService mailService;

	// 이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);

	}

	// 회원가입 폼 이동
	@GetMapping("/registForm")
	public void registFrom() {
		System.out.println("registForm 전송");
	}

	// 회원가입
	@PostMapping("/regist")
	public String regist(MemberDTO memberDTO, RedirectAttributes rttr) {
		// memberDTO로 값 들어오는지 확인
		log.info("memberDTO >>>>> " + memberDTO);
		log.info("암호화 전 비밀번호 " + memberDTO.getPassword());
		// 들어온 memberDTO의 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(memberDTO.getPassword());
		// 암호화된 비밀번호 memberDTO에 넣어주기
		memberDTO.setPassword(encodedPw);
		// 사용중인 아이디 체크
		MemberDTO _memberDTO = memberService.idCheck(memberDTO.getMemberId());
		if(_memberDTO != null) {
			rttr.addFlashAttribute("duplicatedid", _memberDTO.getMemberId());
			return "redirect:regist";
		}else {
			log.info("암호화 후 비밀번호 " + memberDTO.getPassword());
			memberService.regist(memberDTO);
			rttr.addFlashAttribute("Success", "Success");
		}
		// 회원가입 완료시에만 사용하기위해서 addFlashAttribute 사용
		
		return "redirect:loginForm";
	}

	// 로그인 폼 이동
	@GetMapping("/loginForm")
	public void loginForm() {
		System.out.println("loginForm 전송");
	}

	// 로그인
	@PostMapping("/login")
	@ResponseBody
	public String login(MemberDTO member, HttpSession session, Model model) {
		System.out.println("login member >>> " + member);
		MemberDTO _member = memberService.findOneById(member.getMemberId());
		String result = "";
		if (_member != null) {
			System.out.println("_member >> " + _member);
			// 암호화된 비밀번호 비교시
			if (passwordEncoder.matches(member.getPassword(), _member.getPassword())) {
				session.setAttribute("auth", _member);
				result = "ok";
			} else {
				result = "fail";
			}
		}

		return result;

	}

	// 로그아웃
	@GetMapping("/logout")
	public String loginout(HttpSession session) {
		session.invalidate();

		return "redirect:/";

	}

	// 아이디 중복확인
	@GetMapping("/idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("memberId") String memberId) {
		System.out.println("memberId >>>> " + memberId);
		MemberDTO memberDTO = memberService.idCheck(memberId);
		System.out.println("memberDTO >>>> " + memberDTO);
		if (memberDTO != null) {
			return "useId";
		} else {
			return memberId;
		}
	}

	// 마이페이지이동
	@Auth
	@GetMapping("/myPage")
	public void myPage(HttpServletRequest request, HttpSession session, Model model) {
		session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("auth");
		memberDTO = memberService.findOneById(memberDTO.getMemberId());
		AttachDTO attachDTO = uploadService.selectAttach(memberDTO.getMemberId());

		if (attachDTO != null) {
			log.info("attachDTO >>>>> " + attachDTO);
			String fileCallPath = "/upload/" + attachDTO.getUploadpath() + "/" + attachDTO.getUuid() + "_"
					+ attachDTO.getFilename();
			log.info("fileCallPath >>> " + fileCallPath);
			model.addAttribute("fileCallPath", fileCallPath);
		}

		log.info(memberDTO);
		model.addAttribute("memberinfo", memberDTO);

	}

	// activity.jsp 반환
	@GetMapping("/activity")
	public void activityForm(HttpServletRequest request, HttpSession session, Model model) {
		session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("auth");
		memberDTO = memberService.findOneById(memberDTO.getMemberId());
		AttachDTO attachDTO = uploadService.selectAttach(memberDTO.getMemberId());

		if (attachDTO != null) {
			log.info("attachDTO >>>>> " + attachDTO);
			String fileCallPath = "/upload/" + attachDTO.getUploadpath() + "/" + attachDTO.getUuid() + "_"
					+ attachDTO.getFilename();
			log.info("fileCallPath >>> " + fileCallPath);
			model.addAttribute("fileCallPath", fileCallPath);
		}

		log.info(memberDTO);
		model.addAttribute("memberinfo", memberDTO);
	}

	@PostMapping("/nameUpdate/{newName:.+}/{memberId}")
	@ResponseBody
	public String nameUpdate(@PathVariable("newName") String newName, @PathVariable("memberId") String memberId) {
		log.info(newName);
		log.info(memberId);
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setName(newName);
		memberDTO.setMemberId(memberId);
		log.info("이름수정하는" + memberDTO);
		int result = memberService.nameUpdate(memberDTO);
		if (result > 0) {
			return "ok";
		}
		return "fail";

	}

}
