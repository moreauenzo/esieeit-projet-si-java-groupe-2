package com.esiee.project;

/**
 * Point d'entrée de l'application TaskFlow (Projet SI Java - ESIEE-IT).
 */
public class App {

    static final String INIT_MESSAGE = "Projet SI Java - init OK";

    public static String getInitMessage() {
        return INIT_MESSAGE;
    }

    public static void main(String[] args) {
        System.out.println(getInitMessage());
    }
}
