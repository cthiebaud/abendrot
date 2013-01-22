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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebFilter("/socialhello.jsp")
public final class PersistFilter implements Filter {
	
	private final static Logger log = LoggerFactory.getLogger(PersistFilter.class);      

	@EJB
	HelloDao  helloDao;

	@Override
	public void init(FilterConfig fConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		try {
			request.setAttribute("helloDao", helloDao);
			log.debug("request.setAttribute(\"helloDao\", {})", helloDao);
			
			String username = ((HttpServletRequest)request).getRemoteUser();
			log.debug("username = {}", username);
			
			Hello hello = helloDao.fromUsername(username);
			log.debug("hello = {}", hello);
			if (hello == null) {
				hello = new Hello();
				hello.setUsername(username);
			} else {
				hello.bumpCounter();
			}
			hello = helloDao.save(hello);
			log.debug("hello (after save)= {}", hello);
			
			chain.doFilter(request, response);
			
		} finally {
			request.removeAttribute("helloDao");
			log.debug("request.removeAttribute(\"helloDao\")");
		}
	}

	@Override
	public void destroy() {
	}

}
