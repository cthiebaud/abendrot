package net.aequologica.cloud.jaxrs.model;

import java.util.Date;

import com.google.common.base.Objects;
import com.google.common.collect.ComparisonChain;
import com.google.common.collect.Ordering;

public class Output implements Comparable<Output> {
	private Long id;
	private String name;
	private Date date;
	private Embedded embedded = new Embedded();

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
	public Embedded getEmbedded() {
		return embedded;
	}
	public void setEmbedded(Embedded embedded) {
		this.embedded = embedded;
	}

	
	@Override
	public String toString() {
		return Objects.toStringHelper(this.getClass())
				.add("id", 		 this.id)
				.add("name", 	 this.name)
				.add("date", 	 this.date)
				.add("embedded", this.embedded)
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
		if (object instanceof Output) {
			final Output other = (Output) object;
			return Objects.equal(getName(), other.getName());
		} else {
			return false;
		}
	}

	@Override
	public int compareTo(Output that) {
		if (that == null) {
			return -1;
		}
		return ComparisonChain.start()
				.compare(this.name, that.name, Ordering.natural().nullsFirst())
				.result();
	}
}
