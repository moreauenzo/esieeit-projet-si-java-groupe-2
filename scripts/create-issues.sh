#!/usr/bin/env bash
# Crée les labels et une issue GitHub par user story du BACKLOG.md.
# Prérequis : GitHub CLI installé et connecté (gh auth login), à lancer depuis la racine du dépôt.
set -euo pipefail

create_label() { gh label create "$1" --color "$2" --description "$3" --force >/dev/null; echo "label: $1"; }
create_label must B60205 "Indispensable au MVP"
create_label should FBCA04 "Important, après le MVP"
create_label nice 0E8A16 "Bonus"
create_label module/auth 1D76DB "Authentification et profil"
create_label module/project 5319E7 "Gestion des projets"
create_label module/task 0052CC "Gestion des tâches"
create_label module/search C5DEF5 "Recherche et filtre"
create_label module/admin D4C5F9 "Administration"

gh issue create --title "US-01 : Créer un compte" --label "must,module/auth" --body-file - <<'MD'
## User story

En tant que visiteur, je veux créer un compte avec mon email et un mot de passe afin de pouvoir utiliser l'application.

## Priorité

Must. Estimation : M

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-01"
gh issue create --title "US-02 : Se connecter" --label "must,module/auth" --body-file - <<'MD'
## User story

En tant que visiteur, je veux me connecter avec mon email et mon mot de passe afin d'accéder à mes projets.

## Priorité

Must. Estimation : M

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-02"
gh issue create --title "US-03 : Se déconnecter" --label "should,module/auth" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux me déconnecter afin de protéger mon compte sur un poste partagé.

## Priorité

Should. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : déconnexion réussie**
  - **Given** je suis connecté
  - **When** je me déconnecte
  - **Then** ma session est invalidée
  - **And** toute nouvelle requête avec l'ancien jeton est refusée
- **Scénario 2 : déconnexion sans être connecté**
  - **Given** je ne suis pas connecté
  - **When** je demande à me déconnecter
  - **Then** l'accès est refusé car aucune session n'est active

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-03"
gh issue create --title "US-04 : Modifier son profil" --label "should,module/auth" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux modifier mon profil (nom, email) afin de garder mes informations à jour.

## Priorité

Should. Estimation : S

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-04"
gh issue create --title "US-05 : Créer un projet" --label "must,module/project" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux créer un projet avec un nom et une description afin d'y regrouper mes tâches.

## Priorité

Must. Estimation : S

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-05"
gh issue create --title "US-06 : Lister ses projets" --label "must,module/project" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux lister mes projets afin d'avoir une vue d'ensemble de mon travail.

## Priorité

Must. Estimation : S

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-06"
gh issue create --title "US-07 : Modifier un projet" --label "must,module/project" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux modifier un projet afin de corriger son nom ou sa description.

## Priorité

Must. Estimation : S

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-07"
gh issue create --title "US-08 : Supprimer un projet" --label "should,module/project" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux supprimer un projet afin de retirer ce qui n'est plus utile.

## Priorité

Should. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : suppression réussie**
  - **Given** je suis connecté et je possède un projet contenant des tâches
  - **When** je supprime ce projet
  - **Then** le projet et ses tâches sont supprimés
  - **And** il n'apparaît plus dans la liste de mes projets
- **Scénario 2 : projet d'un autre utilisateur**
  - **Given** je suis connecté et le projet visé appartient à un autre utilisateur
  - **When** j'essaie de le supprimer
  - **Then** l'accès est refusé et le projet est conservé

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-08"
gh issue create --title "US-09 : Ajouter une tâche dans un projet" --label "must,module/task" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux ajouter une tâche dans un projet afin de noter ce qu'il reste à faire.

## Priorité

Must. Estimation : M

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-09"
gh issue create --title "US-10 : Changer le statut d'une tâche" --label "must,module/task" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux changer le statut d'une tâche (À faire, En cours, Terminée) afin de suivre l'avancement.

## Priorité

Must. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : changement réussi**
  - **Given** je suis connecté et une de mes tâches a le statut `TODO`
  - **When** je passe son statut à `IN_PROGRESS`
  - **Then** le nouveau statut est enregistré et visible dans la liste des tâches
- **Scénario 2 : statut invalide**
  - **Given** je suis connecté et je possède une tâche
  - **When** je lui attribue un statut qui n'existe pas (par exemple `FINISHED`)
  - **Then** un message d'erreur liste les statuts autorisés : `TODO`, `IN_PROGRESS`, `DONE`
  - **And** le statut reste inchangé

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-10"
gh issue create --title "US-11 : Modifier une tâche" --label "should,module/task" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux modifier une tâche (titre, description) afin de préciser son contenu.

## Priorité

Should. Estimation : S

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-11"
gh issue create --title "US-12 : Supprimer une tâche" --label "should,module/task" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux supprimer une tâche afin de garder une liste propre.

## Priorité

Should. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : suppression réussie**
  - **Given** je suis connecté et je possède une tâche
  - **When** je la supprime
  - **Then** elle n'apparaît plus dans la liste des tâches du projet
- **Scénario 2 : tâche inexistante**
  - **Given** je suis connecté
  - **When** j'essaie de supprimer une tâche qui n'existe pas
  - **Then** un message d'erreur indique que la tâche est introuvable

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-12"
gh issue create --title "US-13 : Filtrer les tâches par statut" --label "nice,module/search" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux filtrer les tâches d'un projet par statut afin de voir rapidement ce qui reste à faire.

## Priorité

Nice. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : filtre réussi**
  - **Given** je suis connecté et mon projet contient 2 tâches `TODO` et 3 tâches `DONE`
  - **When** je filtre les tâches du projet sur le statut `TODO`
  - **Then** seules les 2 tâches `TODO` sont affichées
- **Scénario 2 : aucun résultat**
  - **Given** je suis connecté et mon projet ne contient aucune tâche `IN_PROGRESS`
  - **When** je filtre sur le statut `IN_PROGRESS`
  - **Then** une liste vide est renvoyée, sans erreur

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-13"
gh issue create --title "US-14 : Rechercher une tâche par mot-clé" --label "nice,module/search" --body-file - <<'MD'
## User story

En tant qu'utilisateur, je veux rechercher une tâche par mot-clé afin de la retrouver sans parcourir tous mes projets.

## Priorité

Nice. Estimation : M

## Critères d'acceptation (Given / When / Then)

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

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-14"
gh issue create --title "US-15 : Lister tous les utilisateurs" --label "nice,module/admin" --body-file - <<'MD'
## User story

En tant qu'admin, je veux lister tous les utilisateurs afin de superviser les comptes de la plateforme.

## Priorité

Nice. Estimation : S

## Critères d'acceptation (Given / When / Then)

- **Scénario 1 : liste des comptes**
  - **Given** je suis connecté avec le rôle `ADMIN`
  - **When** je consulte la liste des utilisateurs
  - **Then** tous les comptes sont affichés avec leur email et leur rôle
  - **And** les mots de passe ne sont jamais affichés
- **Scénario 2 : accès refusé à un utilisateur simple**
  - **Given** je suis connecté avec le rôle `USER`
  - **When** j'essaie de consulter la liste des utilisateurs
  - **Then** l'accès est refusé

## Notes

Voir BACKLOG.md.
MD
echo "issue: US-15"
echo "Terminé. Créez ensuite un board (Projects) avec les colonnes To do / Doing / Done."
