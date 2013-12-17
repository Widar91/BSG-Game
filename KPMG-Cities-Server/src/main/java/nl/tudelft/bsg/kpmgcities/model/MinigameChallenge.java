package nl.tudelft.bsg.kpmgcities.model;

import java.io.Serializable;

import javax.persistence.Entity;

@Entity
public class MinigameChallenge implements Serializable {

	private static final long serialVersionUID = -501835055891610384L;
	
	String question;
	String player;
	String opponent;

}
