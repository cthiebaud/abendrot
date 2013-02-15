package net.aequologica.cloud.jaxrs.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.junit.Test;

public class GsonMessageBodyHandlerTest {

	@Test
	public void test() {
		DateFormat iso8601Format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", Locale.US);
		DateFormat localFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", Locale.US);

		DateFormat[] array = new DateFormat[] { iso8601Format, localFormat };
		for (int i = 0; i < array.length; i++) {
			System.out.println(array[i] + " " + array[i].format(new Date()));

			String bad = "2013-02-15T12:45:51.417Z";
			String bad2 = "2013-02-15T13:12:34.630Z";
			String good = "2013-02-15T13:46:37Z";

			try {
				System.out.print(good + "   ? ");
				System.out.println(array[i].parse(good));
			} catch (ParseException e) {
				System.err.println(e.getMessage());
			}
			try {
				System.out.print(bad + "   ? ");
				System.out.println(array[i].parse(bad));
			} catch (ParseException e) {
				System.err.println(e.getMessage());
			}
		}

	}

}
