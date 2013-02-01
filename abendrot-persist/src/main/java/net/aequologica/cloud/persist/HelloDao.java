package net.aequologica.cloud.persist;

import java.util.List;

import javax.ejb.Local;

@Local
public interface HelloDao {
	
	 List<Hello> getAll();
	 Hello sayHello(String username, String ip);
}
