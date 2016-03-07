package com.aswinrkrishnan.hbaserein.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;


public class LoginInterceptor implements Interceptor {

	public String intercept(ActionInvocation invocation) throws Exception {

		final ActionContext context = invocation.getInvocationContext();

		//return invocation.invoke();
		if (context.getContext().getSession().containsKey("frank")) {
			return invocation.invoke();
		} else {
			return "loginAction";
		}
	}

	@Override
	public void destroy() {

	}

	@Override
	public void init() {

	}
}
