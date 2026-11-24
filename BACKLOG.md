# BACKLOG : TaskFlow

> Projet SI Java, L2 ESIEE-IT, 2026-2027
> Équipe : Enzo MOREAU (PO), Edouard BREHERET (Lead Dev), Axel BATISTA, Thomas BOISSY, Jenoush JEGATHEESWARAN (QA)

---

## 1. Le produit

### Pitch

1. **Problème** : les étudiants et les petites équipes suivent leurs projets avec des notes éparpillées (messages, papier, tableurs) et perdent de vue ce qui reste à faire.
2. **Public visé** : étudiants, associations et petites équipes qui veulent un outil simple, sans la complexité des logiciels professionnels.
3. **Résultat attendu** : TaskFlow, une API sécurisée où chacun crée ses projets, y ajoute des tâches et suit leur avancement en un coup d'œil.

### Hypothèses et contraintes

| Type | Élément |
|------|---------|
| Contrainte | Projet Java orienté **API REST** (pas d'interface graphique obligatoire) |
| Contrainte | MVP réalisable en **9 séances** |
| Contrainte | **Authentification obligatoire** (inscription et connexion) |
| Contrainte | Chaque utilisateur ne voit et ne modifie **que ses propres données** |
| Hypothèse | Un projet appartient à un seul utilisateur (pas de partage dans le MVP) |
| Hypothèse | Une tâche appartient à un seul projet et a un statut : `TODO`, `IN_PROGRESS` ou `DONE` |
| Hypothèse | Le rôle `ADMIN` est attribué manuellement (pas d'écran de gestion des rôles) |

---

## 2. Acteurs

| Acteur | Description | Objectif | Permissions |
|--------|-------------|----------|-------------|
| **Visiteur** | Personne non connectée | Découvrir l'application et créer un compte | Voir la page d'accueil et la documentation de l'API, s'inscrire, se connecter |
| **Utilisateur** | Personne connectée | Organiser son travail | Gérer **ses** projets et **ses** tâches (CRUD), modifier son profil, se déconnecter |
| **Admin** | Utilisateur avec le rôle `ADMIN` | Superviser la plateforme | Tout ce que fait l'utilisateur, plus consulter la liste des comptes |

---

## 3. Modules

| Code | Module | Label | Stories |
|------|--------|-------|---------|
| A | Authentification et profil | `module/auth` | US-01 à US-04 |
| B | Gestion des projets | `module/project` | US-05 à US-08 |
| C | Gestion des tâches | `module/task` | US-09 à US-12 |
| D | Recherche et filtre | `module/search` | US-13, US-14 |
| E | Administration (bonus) | `module/admin` | US-15 |

---

## 4. User stories

Priorités : **Must** = indispensable au MVP, **Should** = important mais après le MVP, **Nice** = bonus.
Estimation : **S** = 1 à 2 h, **M** = 3 à 5 h, **L** = plus d'une séance (à découper).

| ID | Module | User story | Priorité | Estim. |
|----|--------|------------|----------|--------|
| US-01 | A | En tant que **visiteur**, je veux **créer un compte** avec mon email et un mot de passe afin de **pouvoir utiliser l'application**. | Must | M |
| US-02 | A | En tant que **visiteur**, je veux **me connecter** avec mon email et mon mot de passe afin d'**accéder à mes projets**. | Must | M |
| US-03 | A | En tant qu'**utilisateur**, je veux **me déconnecter** afin de **protéger mon compte sur un poste partagé**. | Should | S |
| US-04 | A | En tant qu'**utilisateur**, je veux **modifier mon profil** (nom, email) afin de **garder mes informations à jour**. | Should | S |
| US-05 | B | En tant qu'**utilisateur**, je veux **créer un projet** avec un nom et une description afin d'**y regrouper mes tâches**. | Must | S |
| US-06 | B | En tant qu'**utilisateur**, je veux **lister mes projets** afin d'**avoir une vue d'ensemble de mon travail**. | Must | S |
| US-07 | B | En tant qu'**utilisateur**, je veux **modifier un projet** afin de **corriger son nom ou sa description**. | Must | S |
| US-08 | B | En tant qu'**utilisateur**, je veux **supprimer un projet** afin de **retirer ce qui n'est plus utile**. | Should | S |
| US-09 | C | En tant qu'**utilisateur**, je veux **ajouter une tâche dans un projet** afin de **noter ce qu'il reste à faire**. | Must | M |
| US-10 | C | En tant qu'**utilisateur**, je veux **changer le statut d'une tâche** (À faire, En cours, Terminée) afin de **suivre l'avancement**. | Must | S |
| US-11 | C | En tant qu'**utilisateur**, je veux **modifier une tâche** (titre, description) afin de **préciser son contenu**. | Should | S |
| US-12 | C | En tant qu'**utilisateur**, je veux **supprimer une tâche** afin de **garder une liste propre**. | Should | S |
| US-13 | D | En tant qu'**utilisateur**, je veux **filtrer les tâches d'un projet par statut** afin de **voir rapidement ce qui reste à faire**. | Nice | S |
| US-14 | D | En tant qu'**utilisateur**, je veux **rechercher une tâche par mot-clé** afin de **la retrouver sans parcourir tous mes projets**. | Nice | M |
| US-15 | E | En tant qu'**admin**, je veux **lister tous les utilisateurs** afin de **superviser les comptes de la plateforme**. | Nice | S |

**Bilan** : 7 Must (le MVP), 5 Should, 3 Nice.

---

## 5. Critères d'acceptation (Given / When / Then)

Chaque story a un scénario nominal et un ou plusieurs scénarios d'erreur.

### Module A : Authentification et profil

#### US-01 : Créer un compte (Must, M)

- **Scénario 1 : inscription réussie**
  - **Given** je suis un visiteur
  - **When** je m'inscris avec un email valide et un mot de passe d'au moins 8 caractères
  - **Then** mon compte est créé avec le rôle `USER`
  - **And** je peux ensuite me connecter avec ces identifiants
- **Scénario 2 : email déjà utilisé**
  - **Given** un compte existe déjà avec l'email `enzo@exemple.com`
  - **When** je m'inscris avec ce même email
  - **Then** un message d'erreur indique que l'email est déjà utilisé
  - **And** aucun nouveau compte n'est créé
- **Scénario 3 : mot de passe trop court**
  - **Given** je suis un visiteur
  - **When** je m'inscris avec un mot de passe de moins de 8 caractères
  - **Then** un message d'erreur indique que le mot de passe doit contenir au moins 8 caractères
- **Scénario 4 : email invalide**
  - **Given** je suis un visiteur
  - **When** je m'inscris avec un email au format invalide (par exemple `enzo.exemple`)
  - **Then** un message d'erreur indique que le format de l'email est invalide

#### US-02 : Se connecter (Must, M)

- **Scénario 1 : connexion réussie**
  - **Given** j'ai un compte actif
  - **When** je me connecte avec mon email et mon mot de passe corrects
  - **Then** je suis authentifié et je reçois un jeton de session
  - **And** je peux accéder à mes projets
- **Scénario 2 : mot de passe incorrect**
  - **Given** j'ai un compte actif
  - **When** je me connecte avec un mot de passe incorrect
  - **Then** un message d'erreur générique « identifiants invalides » est affiché
  - **And** je ne suis pas authentifié
- **Scénario 3 : compte inexistant**
  - **Given** aucun compte n'existe avec l'email saisi
  - **When** j'essaie de me connecter
  - **Then** le même message générique « identifiants invalides » est affiché (on ne révèle pas si l'email existe)

#### US-03 : Se déconnecter (Should, S)

- **Scénario 1 : déconnexion réussie**
  - **Given** je suis connecté
  - **When** je me déconnecte
  - **Then** ma session est invalidée
  - **And** toute nouvelle requête avec l'ancien jeton est refusée
- **Scénario 2 : déconnexion sans être connecté**
  - **Given** je ne suis pas connecté
  - **When** je demande à me déconnecter
  - **Then** l'accès est refusé car aucune session n'est active

#### US-04 : Modifier son profil (Should, S)

- **Scénario 1 : modification réussie**
  - **Given** je suis connecté
  - **When** je modifie mon nom
  - **Then** mon nouveau nom est enregistré et visible dans mon profil
- **Scénario 2 : email déjà pris**
  - **Given** je suis connecté et un autre compte utilise l'email `thomas@exemple.com`
  - **When** je remplace mon email par `thomas@exemple.com`
  - **Then** un message d'erreur indique que l'email est déjà utilisé
  - **And** mon profil reste inchangé
- **Scénario 3 : accès sans connexion**
  - **Given** je ne suis pas connecté
  - **When** j'essaie de modifier un profil
  - **Then** l'accès est refusé

### Module B : Gestion des projets

#### US-05 : Créer un projet (Must, S)

- **Scénario 1 : création réussie**
  - **Given** je suis connecté
  - **When** je crée un projet avec le nom « Projet SI Java » et une description
  - **Then** le projet est enregistré et m'est associé
  - **And** il apparaît dans la liste de mes projets
- **Scénario 2 : nom manquant**
  - **Given** je suis connecté
  - **When** je crée un projet sans nom
  - **Then** un message d'erreur indique que le nom est obligatoire
  - **And** aucun projet n'est créé
- **Scénario 3 : accès sans connexion**
  - **Given** je ne suis pas connecté
  - **When** j'essaie de créer un projet
  - **Then** l'accès est refusé

#### US-06 : Lister ses projets (Must, S)

- **Scénario 1 : liste de mes projets**
  - **Given** je suis connecté et je possède 3 projets
  - **When** je consulte la liste de mes projets
  - **Then** les 3 projets sont affichés avec leur nom et leur description
- **Scénario 2 : isolation des données**
  - **Given** je suis connecté et un autre utilisateur possède 2 projets
  - **When** je consulte la liste de mes projets
  - **Then** les projets de l'autre utilisateur n'apparaissent pas
- **Scénario 3 : aucun projet**
  - **Given** je suis connecté et je n'ai encore créé aucun projet
  - **When** je consulte la liste de mes projets
  - **Then** une liste vide est renvoyée, sans erreur

#### US-07 : Modifier un projet (Must, S)

- **Scénario 1 : modification réussie**
  - **Given** je suis connecté et je possède le projet « Projet SI Java »
  - **When** je renomme ce projet en « TaskFlow »
  - **Then** le nouveau nom est enregistré
  - **And** il est visible quand je relis le projet
- **Scénario 2 : projet d'un autre utilisateur**
  - **Given** je suis connecté et le projet visé appartient à un autre utilisateur
  - **When** j'essaie de le modifier
  - **Then** l'accès est refusé et le projet reste inchangé
- **Scénario 3 : projet inexistant**
  - **Given** je suis connecté
  - **When** j'essaie de modifier un projet qui n'existe pas
  - **Then** un message d'erreur indique que le projet est introuvable

#### US-08 : Supprimer un projet (Should, S)

- **Scénario 1 : suppression réussie**
  - **Given** je suis connecté et je possède un projet contenant des tâches
  - **When** je supprime ce projet
  - **Then** le projet et ses tâches sont supprimés
  - **And** il n'apparaît plus dans la liste de mes projets
- **Scénario 2 : projet d'un autre utilisateur**
  - **Given** je suis connecté et le projet visé appartient à un autre utilisateur
  - **When** j'essaie de le supprimer
  - **Then** l'accès est refusé et le projet est conservé

### Module C : Gestion des tâches

#### US-09 : Ajouter une tâche dans un projet (Must, M)

- **Scénario 1 : ajout réussi**
  - **Given** je suis connecté et je possède un projet
  - **When** j'ajoute la tâche « Rédiger le README » à ce projet
  - **Then** la tâche est créée avec le statut `TODO`
  - **And** elle apparaît dans la liste des tâches de ce projet, associée au bon projet
- **Scénario 2 : titre manquant**
  - **Given** je suis connecté et je possède un projet
  - **When** j'ajoute une tâche sans titre
  - **Then** un message d'erreur indique que le titre est obligatoire
- **Scénario 3 : projet inexistant ou d'un autre utilisateur**
  - **Given** je suis connecté
  - **When** j'ajoute une tâche à un projet qui n'existe pas ou qui ne m'appartient pas
  - **Then** l'opération est refusée et aucune tâche n'est créée

#### US-10 : Changer le statut d'une tâche (Must, S)

- **Scénario 1 : changement réussi**
  - **Given** je suis connecté et une de mes tâches a le statut `TODO`
  - **When** je passe son statut à `IN_PROGRESS`
  - **Then** le nouveau statut est enregistré et visible dans la liste des tâches
- **Scénario 2 : statut invalide**
  - **Given** je suis connecté et je possède une tâche
  - **When** je lui attribue un statut qui n'existe pas (par exemple `FINISHED`)
  - **Then** un message d'erreur liste les statuts autorisés : `TODO`, `IN_PROGRESS`, `DONE`
  - **And** le statut reste inchangé

#### US-11 : Modifier une tâche (Should, S)

- **Scénario 1 : modification réussie**
  - **Given** je suis connecté et je possède une tâche
  - **When** je modifie son titre et sa description
  - **Then** les modifications sont enregistrées et visibles quand je relis la tâche
- **Scénario 2 : titre vidé**
  - **Given** je suis connecté et je possède une tâche
  - **When** je remplace son titre par un texte vide
  - **Then** un message d'erreur indique que le titre est obligatoire
- **Scénario 3 : tâche d'un autre utilisateur**
  - **Given** je suis connecté et la tâche appartient au projet d'un autre utilisateur
  - **When** j'essaie de la modifier
  - **Then** l'accès est refusé

#### US-12 : Supprimer une tâche (Should, S)

- **Scénario 1 : suppression réussie**
  - **Given** je suis connecté et je possède une tâche
  - **When** je la supprime
  - **Then** elle n'apparaît plus dans la liste des tâches du projet
- **Scénario 2 : tâche inexistante**
  - **Given** je suis connecté
  - **When** j'essaie de supprimer une tâche qui n'existe pas
  - **Then** un message d'erreur indique que la tâche est introuvable

### Module D : Recherche et filtre

#### US-13 : Filtrer les tâches par statut (Nice, S)

- **Scénario 1 : filtre réussi**
  - **Given** je suis connecté et mon projet contient 2 tâches `TODO` et 3 tâches `DONE`
  - **When** je filtre les tâches du projet sur le statut `TODO`
  - **Then** seules les 2 tâches `TODO` sont affichées
- **Scénario 2 : aucun résultat**
  - **Given** je suis connecté et mon projet ne contient aucune tâche `IN_PROGRESS`
  - **When** je filtre sur le statut `IN_PROGRESS`
  - **Then** une liste vide est renvoyée, sans erreur

#### US-14 : Rechercher une tâche par mot-clé (Nice, M)

- **Scénario 1 : recherche réussie**
  - **Given** je suis connecté et une de mes tâches s'intitule « Rédiger le README »
  - **When** je recherche le mot-clé « readme »
  - **Then** la tâche est trouvée, quelle que soit la casse
- **Scénario 2 : isolation des données**
  - **Given** je suis connecté et un autre utilisateur possède une tâche « README final »
  - **When** je recherche « readme »
  - **Then** la tâche de l'autre utilisateur n'apparaît pas dans les résultats
- **Scénario 3 : mot-clé vide**
  - **Given** je suis connecté
  - **When** je lance une recherche sans mot-clé
  - **Then** un message d'erreur indique que le mot-clé est obligatoire

### Module E : Administration (bonus)

#### US-15 : Lister tous les utilisateurs (Nice, S)

- **Scénario 1 : liste des comptes**
  - **Given** je suis connecté avec le rôle `ADMIN`
  - **When** je consulte la liste des utilisateurs
  - **Then** tous les comptes sont affichés avec leur email et leur rôle
  - **And** les mots de passe ne sont jamais affichés
- **Scénario 2 : accès refusé à un utilisateur simple**
  - **Given** je suis connecté avec le rôle `USER`
  - **When** j'essaie de consulter la liste des utilisateurs
  - **Then** l'accès est refusé

---

## 6. Priorisation (MoSCoW simplifié)

Grille de décision : *le produit fonctionne-t-il sans cette story ?* Si non, **Must**. Si oui mais qu'elle est utile, **Should**. Sinon, **Nice**.

| Priorité | Stories | Justification |
|----------|---------|---------------|
| **Must** (MVP) | US-01, US-02, US-05, US-06, US-07, US-09, US-10 | Sans compte, sans projets ou sans tâches à suivre, l'application n'a pas d'intérêt |
| **Should** | US-03, US-04, US-08, US-11, US-12 | Confort et complétude du CRUD, à faire juste après le MVP |
| **Nice** | US-13, US-14, US-15 | Bonus : la recherche est prévue en séance 7, l'administration si le temps le permet |

---

## 7. Estimation et découpage

| Taille | Durée | Règle |
|--------|-------|-------|
| **S** | 1 à 2 h | OK, faisable dans une séance |
| **M** | 3 à 5 h | OK, à surveiller |
| **L** | Plus d'une séance | **À découper** avant de commencer |

Aucune story n'est estimée L. Exemple de découpage appliqué : la story initiale « En tant qu'utilisateur, je veux gérer mes tâches » (L) a été découpée en **US-09** (ajouter), **US-10** (changer le statut), **US-11** (modifier) et **US-12** (supprimer), chacune S ou M.

**Charge totale estimée** : 11 stories S (environ 11 à 22 h) et 4 stories M (environ 12 à 20 h), soit environ 23 à 42 h réparties sur 5 personnes.

---

## 8. Definition of Done

Une story est **Done** quand :

- [ ] Le code compile et la fonctionnalité marche.
- [ ] Tous les critères d'acceptation de la story sont vérifiés.
- [ ] Les tests passent (`./gradlew test`).
- [ ] Le README et le backlog sont mis à jour si nécessaire.
- [ ] Une Pull Request vers `develop` a été relue et fusionnée.

---

## 9. Cycle de vie d'une story

`Draft` → `Ready` (critères d'acceptation rédigés) → `In Progress` → `Review` (PR ouverte) → `Testing` → `Done`

Une story en Review ou Testing qui ne respecte pas ses critères repasse en In Progress.

---

## 10. Socle technique (hors user stories)

Tâches techniques qui ne sont pas des fonctionnalités, mais sont nécessaires au projet.

| ID | Tâche | Séance | Statut |
|----|-------|--------|--------|
| TECH-01 | Initialiser le dépôt, le wrapper Gradle et la structure (branche `feature/us-01-init`, TP 1.1) | S1 | ✅ Fait |
| TECH-02 | Pagination et tri des listes | S7/S8 | À faire |
| TECH-03 | Docker Compose (application et base de données) | S7/S8 | À faire |
| TECH-04 | Intégration continue : build et tests automatiques | S7/S8 | À faire |
| TECH-05 | Documentation de l'API avec Swagger / OpenAPI (bonus) | Bonus | À faire |

---

## 11. Suivi dans GitHub / GitLab

- Une **Issue par user story**, créée à partir du modèle `.github/ISSUE_TEMPLATE/user_story.md`.
- **Labels** : `must`, `should`, `nice` et `module/auth`, `module/project`, `module/task`, `module/search`, `module/admin`.
- **Board** avec trois colonnes : *To do*, *Doing*, *Done*.
- Le script `scripts/create-issues.sh` crée automatiquement les labels et les 15 issues (il demande GitHub CLI).
