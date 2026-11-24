# TaskFlow : Projet SI Java (L2 ESIEE-IT, 2026-2027)

## Contexte

Ce dépôt contient le projet du module **Système d'Information en Java** (L2, ESIEE-IT).
Nous développons **TaskFlow**, une application de gestion de projets et de tâches exposée sous forme d'**API REST sécurisée**.

## Objectifs

- Permettre à un utilisateur de créer un compte et de se connecter.
- Gérer ses **projets** (créer, lister, modifier, supprimer).
- Gérer les **tâches** d'un projet et suivre leur avancement (À faire, En cours, Terminée).
- Garantir que chaque utilisateur n'accède qu'à ses propres données.
- Livrer un MVP réalisable en 9 séances, avec un code testé et un workflow Git propre.

## Équipe

| Nom | Rôle |
|-----|------|
| Enzo MOREAU | Product Owner (PO) : backlog et priorités |
| Edouard BREHERET | Lead Dev : architecture et revue des PR |
| Axel BATISTA | Développeur |
| Thomas BOISSY | Développeur |
| Jenoush JEGATHEESWARAN | QA : tests et critères d'acceptation |

## Stack technique

| Élément | Choix |
|---------|-------|
| Langage | Java 21 |
| Build | Gradle 8.14.3 via le **wrapper** (`./gradlew`) |
| Tests | JUnit 5 (Jupiter) |
| À venir | Spring Boot, base de données, Docker Compose, CI |

## Prérequis

- **JDK 21** : vérifier avec `java -version` et `javac -version`
- **Git** : vérifier avec `git --version`
- Un IDE : IntelliJ IDEA Community (recommandé) ou VS Code

> Gradle n'a pas besoin d'être installé : le wrapper télécharge automatiquement la bonne version (8.14.3).

## Installation

```bash
git clone <URL_DU_REPO>
cd esieeit-projet-si-java-groupe-<X>
```

## Lancer le projet

| Action | Linux / macOS | Windows |
|--------|---------------|---------|
| Lancer les tests | `./gradlew test` | `gradlew.bat test` |
| Exécuter l'application | `./gradlew run` | `gradlew.bat run` |
| Compiler | `./gradlew build` | `gradlew.bat build` |

Résultat attendu de `./gradlew test` : `BUILD SUCCESSFUL`.
Résultat attendu de `./gradlew run` : `Projet SI Java - init OK`.

## Structure du projet

```
.
├── build.gradle / settings.gradle
├── gradlew / gradlew.bat / gradle/wrapper/
├── src/main/java/com/esiee/project/
│   ├── App.java
│   ├── api/controller/     # endpoints REST
│   ├── api/dto/            # objets requête / réponse
│   ├── domain/model/       # entités : User, Project, Task
│   ├── domain/enums/       # Role, TaskStatus
│   ├── service/            # logique métier
│   ├── repository/         # accès aux données
│   └── exception/          # erreurs métier
└── src/test/java/com/esiee/project/
    └── AppTest.java
```

## Workflow Git

| Branche | Rôle |
|---------|------|
| `main` | Version stable, livrée (tags `vX.Y.Z`) |
| `develop` | Branche d'intégration |
| `feature/us-XX-nom` | Une user story par branche, créée depuis `develop` |

Règles :

1. On ne committe **jamais** directement sur `main` ni sur `develop`.
2. Chaque story est développée sur sa branche `feature/...`, puis intégrée par une **Pull Request vers `develop`**, relue par au moins un membre.
3. Les messages de commit suivent la convention `type(scope): description` (`feat`, `fix`, `docs`, `test`, `chore`, `refactor`). Les messages `update` et `wip` sont interdits.

```bash
git checkout develop
git pull --rebase origin develop
git checkout -b feature/us-02-auth-login
# ... développement ...
git add .
git commit -m "feat(auth): add login endpoint"
git push -u origin feature/us-02-auth-login
# puis ouvrir une PR vers develop
```

Le détail se trouve dans [CONTRIBUTING.md](CONTRIBUTING.md).

## Backlog

Le backlog produit (acteurs, modules, user stories, priorités, estimations, critères d'acceptation) est dans [BACKLOG.md](BACKLOG.md).
