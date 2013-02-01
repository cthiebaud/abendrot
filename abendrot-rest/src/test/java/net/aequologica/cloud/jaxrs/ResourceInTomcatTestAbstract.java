package net.aequologica.cloud.jaxrs;

import static org.junit.Assert.assertEquals;

import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import javax.servlet.ServletException;

import net.aequologica.cloud.servlet.Listener;

import org.apache.catalina.Host;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.LifecycleState;
import org.apache.catalina.core.StandardHost;
import org.apache.catalina.startup.Tomcat;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.jboss.shrinkwrap.impl.base.exporter.zip.ZipExporterImpl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ning.http.client.AsyncHttpClient;
import com.ning.http.client.Response;

public class ResourceInTomcatTestAbstract {
	
	static Logger log = LoggerFactory.getLogger(Resource.class);

	static final String name        = "tordneba"; // just something else than abendrot to test if abendrot is hard-coded somwhere. 
	static final String mWorkingDir = System.getProperty("java.io.tmpdir");

	// cf. http://www.hostettler.net/blog/2012/04/09/embedded-jee-web-application-integration-testing-using-tomcat-7/
	
	Tomcat mTomcat;
	
	@Before
	public void setup() throws IOException, LifecycleException, ServletException {
		
		log.info("##################### {} ################", mWorkingDir);

		mTomcat = new Tomcat();
		
		mTomcat.setPort(findFreePort());
		mTomcat.setBaseDir(mWorkingDir);
		
		Host host = mTomcat.getHost();
		if (host instanceof StandardHost) {
			((StandardHost)host).setUnpackWARs(false);
		}
		host.setAppBase(mWorkingDir);
		host.setAutoDeploy(true);
		host.setDeployOnStartup(true);

		// build archive
        WebArchive archive = ShrinkWrap.create(WebArchive.class); 
        archive.addPackage(Listener.class.getPackage());
        archive.addPackage(Resource.class.getPackage());
        
		File webApp = new File(mWorkingDir, archive.getName());
		log.info("§§§§§§§§§§§§§§§§§§§§§ {} §§§§§§§§§§§§§§§§", webApp.getAbsolutePath());
		webApp.deleteOnExit();
        new ZipExporterImpl(archive).exportTo(webApp, true);
        
        mTomcat.addWebapp("/"+name, webApp.getAbsolutePath());
        
		mTomcat.start();
	}

	@After
	public final void teardown() throws Throwable {
		if (mTomcat.getServer() != null && mTomcat.getServer().getState() != LifecycleState.DESTROYED) {
			if (mTomcat.getServer().getState() != LifecycleState.STOPPED) {
				mTomcat.stop();
			}
			mTomcat.destroy();
		}
	}

	@Test
	public void test() throws IOException, InterruptedException, ExecutionException {
		// cf. https://github.com/AsyncHttpClient/async-http-client 
		AsyncHttpClient asyncHttpClient = new AsyncHttpClient();
		Future<Response> f = asyncHttpClient.prepareGet("http://localhost:" + mTomcat.getConnector().getPort() + "/"+name+"/resources/hello").execute();
		Response r = f.get();

		assertEquals( 200, r.getStatusCode());
		assertEquals("Hello, World!", r.getResponseBody());
	}

	private static class SocketHolder implements Closeable {

		private final ServerSocket socket;

		public SocketHolder(ServerSocket socket) {
			this.socket = socket;
		}

		public ServerSocket getSocket() {
			return socket;
		}

		@Override
		public void close() throws IOException {
			socket.close();
		}
	}

	private static int findFreePort() throws IOException {
		// cf. https://gist.github.com/3429822
		try (SocketHolder holder = new SocketHolder(new ServerSocket(0))) {
			holder.getSocket().setReuseAddress(true);
			int port = holder.getSocket().getLocalPort();
			return port;
		}
	}

}
