package net.aequologica.cloud.jaxrs.model;

import java.util.Date;

import com.google.common.base.Objects;
import com.google.common.collect.ComparisonChain;
import com.google.common.collect.Ordering;

public class Input implements Comparable<Input> {
	private Long id;
	private String name;
	private Date date;

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return Objects.toStringHelper(this.getClass())
				.add("id", 			getId())
				.add("name", 		getName())
				.add("date", 		getDate())
				.toString();
	}

	@Override
	public int hashCode() {
		return Objects.hashCode(
				getName()
			);
	}

	@Override
	public boolean equals(Object object) {
		if (object instanceof Input) {
			final Input other = (Input) object;
			return Objects.equal(getName(), other.getName());
		} else {
			return false;
		}
	}

	@Override
	public int compareTo(Input that) {
		if (that == null) {
			return -1;
		}
		return ComparisonChain.start()
				.compare(this.name, that.name, Ordering.natural().nullsFirst())
				.result();
	}
}
