package net.aequologica.cloud.persist;

import javax.annotation.Generated;
import javax.persistence.metamodel.SetAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="Dali", date="2013-01-25T21:16:36.852+0100")
@StaticMetamodel(Address.class)
public class Address_ {
	public static volatile SingularAttribute<Address, Long> id;
	public static volatile SingularAttribute<Address, String> ip4;
	public static volatile SetAttribute<Address, Hello> hellos;
}
