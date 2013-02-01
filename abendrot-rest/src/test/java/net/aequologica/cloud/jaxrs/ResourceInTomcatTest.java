package net.aequologica.cloud.jaxrs;

import static org.junit.Assert.assertEquals;

import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.junit.Test;

import com.ning.http.client.AsyncHttpClient;
import com.ning.http.client.Response;

public class ResourceInTomcatTest extends ResourceInTomcatTestAbstract {
	
	@Test
	public void test() throws IOException, InterruptedException, ExecutionException {
		// cf. https://github.com/AsyncHttpClient/async-http-client 
		AsyncHttpClient asyncHttpClient = new AsyncHttpClient();
		Future<Response> f = asyncHttpClient.prepareGet("http://localhost:" + mTomcat.getConnector().getPort() + "/"+name+"/resources/hello").execute();
		Response r = f.get();

		assertEquals( 200, r.getStatusCode());
		assertEquals("Hello, World!", r.getResponseBody());
	}

}
