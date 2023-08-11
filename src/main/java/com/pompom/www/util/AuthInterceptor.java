package com.pompom.www.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.resource.ResourceHttpRequestHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AuthInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 어노테이션 체크 - Controller에 @Auth 어노테이션이 있는지 확인

		boolean hasAnnotation = checkAnnotation(handler, Auth.class);

		if (hasAnnotation) {
			log.info(hasAnnotation + "Auth 어노테이션 확인");
			HttpSession session = request.getSession();
			if (session.getAttribute("auth") == null) {
				
				response.sendRedirect("/member/loginForm");
				return false;
			}else {
				
				return true;
			}
			
		}

		log.info("Auth 어노테이션이 없다.");
		return true;
	}

	private boolean checkAnnotation(Object handler, Class<Auth> authClass) {
		// js. html 타입인 view 과련 파일들은 통과한다.(view 관련 요청 = ResourceHttpRequestHandler)
		if (handler instanceof ResourceHttpRequestHandler) {
			return true;
		}

		HandlerMethod handlerMethod = (HandlerMethod) handler;

		// Auth anntotation이 있는 경우
		if (null != handlerMethod.getMethodAnnotation(authClass)
				|| null != handlerMethod.getBeanType().getAnnotation(authClass)) {
			return true;
		}

		// annotation이 없는 경우
		return false;
	}

}