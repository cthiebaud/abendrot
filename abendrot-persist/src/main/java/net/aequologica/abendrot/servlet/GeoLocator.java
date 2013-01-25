package net.aequologica.abendrot.servlet;

import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

import net.aequologica.cloud.persist.Address;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GeoLocator {

	ObjectMapper mapper = new ObjectMapper();


	public void locate(Address address) {
		try {
			URLConnection urlConnection = new URL("http://freegeoip.net/json/"+address.getIp4()).openConnection();
			
			@SuppressWarnings("unchecked")
			Map<String,Object> userData = mapper.readValue(urlConnection.getInputStream(), Map.class);
			
			System.out.println(userData);
			
		} catch (Exception e) {
		}
		
	}
}
