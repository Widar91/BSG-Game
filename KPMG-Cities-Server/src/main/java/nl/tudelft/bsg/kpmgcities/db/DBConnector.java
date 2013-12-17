package nl.tudelft.bsg.kpmgcities.db;

import java.io.Serializable;
import java.util.List;

import nl.tudelft.bsg.kpmgcities.model.ChallengeQuestion;
import nl.tudelft.bsg.kpmgcities.model.Player;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class DBConnector {
	
	public static DBConnector instance = null; 
	
	private SessionFactory sessionFactory;
	private ServiceRegistry serviceRegistry;

	private Session session;
	
	private DBConnector(){
		sessionFactory = configureSessionFactory();
	}

	public static DBConnector getInstance() {
		if(instance == null)
			instance = new DBConnector();
		
		return instance;
	}
	
    private SessionFactory configureSessionFactory() throws HibernateException {
        Configuration configuration = new Configuration();
        configuration.configure();
        serviceRegistry = new ServiceRegistryBuilder().applySettings(
                        configuration.getProperties()).buildServiceRegistry();
        sessionFactory = configuration.buildSessionFactory(serviceRegistry);
        return sessionFactory;
    }
    
    private Session getSession() {
    	if(session == null || !session.isOpen())
    		session = openSession();
    	return session;
    }
	
    private Session openSession() {
    	return sessionFactory.openSession();
    }
	
    private void closeSession() {
    	if(session != null && session.isOpen())
    	session.close();
    }
    
    public void close() {
    	session.close();
    	sessionFactory.close();
    }
    
    public void save(Serializable obj) {
    	closeSession();
    	Session session = openSession();
    	
    	Transaction transaction = null;
    	try {
    		transaction = session.beginTransaction();
    		session.saveOrUpdate(obj);
    		transaction.commit();
    	}
    	catch (RuntimeException e) {
    		System.err.println(e.getMessage());
            if (transaction != null)
                    transaction.rollback();
    	}
    	finally {
    		session.close();
    	}
    }
    
    public Player getPlayer(String username, String pwd) {
    	return (Player) getSession()
    					.createQuery("from Player where name = :name")
    					.setParameter("name", username)
    					.uniqueResult();
    }
    
    @SuppressWarnings("unchecked")
	public List<Player> getPlayers() {
		return getSession()
				.createQuery("from Player")
				.list();
	}
    
    @SuppressWarnings("unchecked")
	public List<ChallengeQuestion> getChallengeQuestions() {
		return getSession()
				.createQuery("from ChallengeQuestion")
				.list();
	}
    
}
