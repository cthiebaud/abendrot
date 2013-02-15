package net.aequologica.cloud.jaxrs.model;

public class Embedded {

	private String text = "I'm embedded!";

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public String toString() {
		return text;
	}

}