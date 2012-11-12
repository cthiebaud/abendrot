package net.aequologica.cloud.jaxrs;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class ResourceTest {

    @Test
	public void test() {
		assertEquals("Hello, World!", new Resource().getIt());
	}
}
