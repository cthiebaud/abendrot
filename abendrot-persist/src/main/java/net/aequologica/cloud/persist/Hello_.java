package net.aequologica.cloud.persist;

import java.sql.Timestamp;
import javax.annotation.Generated;
import javax.persistence.metamodel.SetAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2013-01-25T21:15:56.884+0100")
@StaticMetamodel(Hello.class)
public class Hello_ {
	public static volatile SingularAttribute<Hello, Long> id;
	public static volatile SingularAttribute<Hello, String> username;
	public static volatile SingularAttribute<Hello, Integer> counter;
	public static volatile SingularAttribute<Hello, Timestamp> when;
	public static volatile SetAttribute<Hello, Address> addresses;
}
