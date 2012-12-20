package net.aequologica.abendrot.servlet;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import net.aequologica.cloud.persist.Hello;
import net.aequologica.cloud.persist.HelloDao;

@WebFilter("/socialhello.jsp")
public final class PersistFilter implements Filter {

	@EJB
	HelloDao  helloDao;

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			request.setAttribute("helloDao", helloDao);
			
			String username = ((HttpServletRequest)request).getRemoteUser();
			Hello hello = helloDao.fromUsername(username);
			if (hello == null) {
				hello = new Hello();
				hello.setUsername(username);
			} else {
				hello.bumpCounter();
			}
			hello = helloDao.save(hello);
			
			chain.doFilter(request, response);
			
		} finally {
			request.removeAttribute("helloDao");
		}
	}

	@Override
	public void destroy() {
	}

}
