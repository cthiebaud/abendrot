package net.aequologica.cloud.jaxrs.util;

/**
 * borrowed from https://github.com/sapnwcloud/paulpredicts/blob/master/src/main/java/com/sap/pto/services/util/JsonIgnore.java
 */

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Indicates that a field should not be rendered in JSON
 */
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
public @interface JsonIgnore {

}
