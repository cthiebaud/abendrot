package net.aequologica.cloud.persist;

import static com.google.common.base.Objects.equal;
import static com.google.common.base.Objects.toStringHelper;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import com.google.common.base.Objects;

@Entity
@Table(name = "T_ADDRESS")
@NamedQueries({ @NamedQuery(name = "allAddresses" , query = "select a from Address a"), 
				@NamedQuery(name = "addressFromIP", query = "select a from Address a where a.ip4 = :ip4") 
})
public class Address {

	@Id
	@GeneratedValue
	private Long id;

	@Column(name = "A_IP4", unique = true, nullable = false, length = 40)
	private String ip4;

	@ManyToMany(mappedBy = "addresses")
	private Set<Hello> hellos = new HashSet<Hello>();

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIp4() {
		return ip4;
	}

	public void setIp4(String ip4) {
		this.ip4 = ip4;
	}

	public Set<Hello> getHellos() {
		return hellos;
	}

	public void addHello(Hello hello) {
		if (!this.hellos.contains(hello)) {
			this.hellos.add(hello);
		}
	}

	public void removeHello(Hello hello) {
		if (!this.hellos.contains(hello)) {
			this.hellos.remove(hello);
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (obj == null) {
			return false;
		}
		if (getClass() != obj.getClass()) {
			return false;
		}
		final Address other = (Address) obj;

		return equal(this.ip4, other.ip4);
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(this.ip4);
	}

	@Override
	public String toString() {
		return toStringHelper(this)
				.addValue(this.ip4)
				.toString();
	}
}
