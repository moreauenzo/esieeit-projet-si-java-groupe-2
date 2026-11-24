package com.esiee.project;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;

class AppTest {

    @Test
    void sanity_check() {
        assertTrue(true, "Le projet est initialisé et les tests JUnit 5 s'exécutent");
    }

    @Test
    void init_message_is_correct() {
        assertEquals("Projet SI Java - init OK", App.getInitMessage());
    }
}
