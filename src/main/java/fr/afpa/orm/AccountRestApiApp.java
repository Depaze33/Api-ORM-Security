package fr.afpa.orm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Configuration;

/**
 * Classe principale du projet.
 * TODO ajouter l'annotation @SpringBootApplication à la classe
 * 
 * Cette annotation est FONDAMENTALE pour activer la recherche automatique des beans dans les différents packages de l'
 * 
 * Documentation -> https://medium.com/@boris.alexandre.rose/springbootapplication-ab08032a7049
 * 
 */
@Configuration
@SpringBootTest
@EntityScan
@SpringBootApplication
public class AccountRestApiApp {
    public static void main(String[] args) {
        SpringApplication.run(AccountRestApiApp.class, args);
    }
}
