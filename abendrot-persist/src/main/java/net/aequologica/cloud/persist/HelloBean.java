package net.aequologica.cloud.persist;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import net.aequologica.abendrot.servlet.GeoLocator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Stateless
public class HelloBean implements HelloDao {

	private final static Logger log = LoggerFactory.getLogger(HelloBean.class);      
	
	@PersistenceContext
	private EntityManager em;

	private GeoLocator geoLocator = new GeoLocator();
	
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
	@TransactionAttribute
	public Hello sayHello(String username, String ip) {
		Hello hello = fromUsername(username);
		/*
		Address address = addressDao.fromIP(ip);
		if (address == null) {
			address = new Address();
			address.setIp4(ip);
			
			geoLocator.locate(address);
			
			address = addressDao.save(address);
		}
		Collection<Address> addresses = null;
			hello.setAddresses(addresses = new ArrayList<Address>());
			addresses = hello.getAddresses();
		assert(addresses != null);
		address = new Address();
		address.setIp4(ip);
		geoLocator.locate(address);
		
		if (!addresses.contains(addresses)) {
			addresses.add(address);
			hello.setAddresses(addresses);
		}
		
		
		 */
		Address address = new Address();
		address.setIp4(ip);
		geoLocator.locate(address);
		
		if (hello == null) {
			hello = new Hello();
			hello.setUsername(username);
		} else {
			hello.bumpCounter();
		}
		
		// hello.addAddress(address);
		
		hello = save(hello);
		
		return hello;
	}
	
	private Hello fromUsername(String username) {
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

	private Hello save(Hello hello) {
		hello = em.merge(hello);
		return hello;
	}

}
