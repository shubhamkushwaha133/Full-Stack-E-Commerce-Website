package model;

public class Message {
    private int id;
    private String email;
    private String subject;
    private String body;

    // Constructors
    public Message() {}

    public Message(int id, String email, String subject, String body) {
        this.id = id;
        this.email = email;
        this.subject = subject;
        this.body = body;
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

    
}
