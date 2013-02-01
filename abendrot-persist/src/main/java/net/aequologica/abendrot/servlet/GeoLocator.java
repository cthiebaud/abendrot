package net.aequologica.abendrot.servlet;

import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

import net.aequologica.cloud.persist.Address;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GeoLocator {

	private final static Logger log = LoggerFactory.getLogger(GeoLocator.class);

	ObjectMapper mapper = new ObjectMapper();

	public void locate(Address address) {
		try {
			URLConnection urlConnection = new URL("http://freegeoip.net/json/" + address.getIp4()).openConnection();

			@SuppressWarnings("unchecked")
			Map<String, Object> userData = mapper.readValue(urlConnection.getInputStream(), Map.class);

			log.debug("http://freegeoip.net/json/{} returned {}", address.getIp4(), userData.toString());

		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
	}

	public static void main(String[] args) {
		Address address = new Address();
		address.setIp4("10.117.18.19");
		new GeoLocator().locate(address);
	}
}
