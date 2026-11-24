# Contribuer à TaskFlow

## 1. Branches

| Branche | Usage |
|---------|-------|
| `main` | Stable, livrée. Fusion uniquement depuis `develop` en fin de jalon (tag `vX.Y.Z`). |
| `develop` | Intégration. Fusion uniquement par Pull Request. |
| `feature/us-XX-description` | Une user story, créée depuis `develop`. |
| `fix/description` | Correction de bug, créée depuis `develop`. |

**Interdit** : committer directement sur `main` ou sur `develop`.

## 2. Démarrer une story

```bash
git checkout develop
git pull --rebase origin develop
git checkout -b feature/us-05-create-project
```

## 3. Convention de commits

Format : `type(scope): description` (en anglais, à l'impératif, sans point final).

| Type | Usage | Exemple |
|------|-------|---------|
| `feat` | Nouvelle fonctionnalité | `feat(project): add create project endpoint` |
| `fix` | Correction de bug | `fix(auth): reject empty password` |
| `test` | Ajout ou modification de tests | `test(task): cover status change` |
| `docs` | Documentation | `docs(readme): add run instructions` |
| `refactor` | Refonte sans changement fonctionnel | `refactor(service): extract validation` |
| `chore` | Outillage, configuration, build | `chore(gradle): bump junit version` |

Messages refusés : `update`, `wip`, `fix`, `modifs`, `test`...

## 4. Pull Request

1. Pousser la branche : `git push -u origin feature/us-XX-...`
2. Ouvrir une PR **vers `develop`** (le modèle se remplit automatiquement).
3. Au moins **une relecture** par un autre membre (de préférence le Lead Dev).
4. `./gradlew test` doit passer avant la fusion.
5. Supprimer la branche après la fusion.

## 5. Definition of Done

Voir la section 8 de [BACKLOG.md](BACKLOG.md).
