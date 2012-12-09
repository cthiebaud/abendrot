package net.aequologica.cloud.persist;

import java.sql.Timestamp;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2012-12-09T02:55:50.118+0100")
@StaticMetamodel(Hello.class)
public class Hello_ {
	public static volatile SingularAttribute<Hello, Long> id;
	public static volatile SingularAttribute<Hello, String> username;
	public static volatile SingularAttribute<Hello, Integer> counter;
	public static volatile SingularAttribute<Hello, Timestamp> when;
}
