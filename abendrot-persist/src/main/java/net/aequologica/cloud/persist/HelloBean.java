package net.aequologica.cloud.persist;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Stateless
public class HelloBean implements HelloDao {

	private final static Logger log = LoggerFactory.getLogger(HelloBean.class);      
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Hello> getAll() {
		log.debug("entity manager = {}", em);
		
		@SuppressWarnings("unchecked")
		List<Hello> hellos = (List<Hello>)em.createNamedQuery("allHellos").getResultList();
		
		Collections.sort(hellos, new Comparator<Hello>() {
			@Override
			public int compare(Hello o1, Hello o2) {
				return o2.getWhen().compareTo(o1.getWhen()); // latest first
			}
		});
		
		return hellos;
	}

	@Override
	public Hello fromUsername(String username) {
		Query query = em.createNamedQuery("helloFromUsername");
		query.setParameter("username", username);
		Hello hello = null;
		try {
			hello = (Hello)query.getSingleResult();
		} catch (NoResultException ignored) {
			log.error("NoResultException in helloFromUsername", ignored);
		}
		
		return hello;
	}

//	@TransactionAttribute
	@Override
	public Hello save(Hello hello) {
		hello = em.merge(hello);
		return hello;
	}
	
}
