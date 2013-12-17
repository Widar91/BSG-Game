package nl.tudelft.bsg.kpmgcities.db;

import nl.tudelft.bsg.kpmgcities.model.Player;

public class TestDB {
	
	public static void populateTestDB() {
		if(DBConnector.getInstance().getPlayers().size() == 0) {
			Player pl = new Player();
			pl.setName("Eddy");
			pl.setOffice("Amsterdam");
			pl.setDepartment("IT");
			DBConnector.getInstance().save(pl);
			
			Player pl2 = new Player();
			pl2.setName("Rambo");
			pl2.setOffice("Amsterdam");
			pl2.setDepartment("IT");
			DBConnector.getInstance().save(pl2);
		}
	}
	
}
