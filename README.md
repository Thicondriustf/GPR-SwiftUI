# GitHub Public Repositories (GPR)

## Description

Cette simple application permet d'obtenir la liste de tous les projets GitHub public à travers l'API de Github et d'avoir certaines informations sur les projets ainsi que le nombre d'issues ouvertes les 28 derniers jours.

## Installation

Ouvrir le projet à l'aide du fichier *GPR.xcodeproj* avec Xcode.
Ensuite vous pouvez simplement lancer le projet en cliquant sur le bouton run de Xcode.

## Axes d'améliorations

### Design

Le design actuel est médiocre, avec principalement deux couleurs différentes, un design très simple en blocs et un manque d'icônes. Il est compréhensible mais pas vraiment attrayant. Pour l'améliorer, nous pouvons utiliser des courbes, des effets de profondeur, des icônes, des polices et des couleurs pour améliorer l'ensemble de l'application.

### Recherche

L'application affiche tous les dépôts publics en utilisant la requête /repositories de l'API Github, ce qui peut être grandement amélioré en utilisant /search/repos pour :

- implémenter un champ de texte permettant à l'utilisateur de rechercher des dépôts spécifiques
- ajouter des filtres et des options de tri

### Organisations/Users

L'application peut être améliorée pour permettre à l'utilisateur de filtrer les dépôts ou les problèmes (issues) pour des organisations ou des utilisateurs spécifiques. L'utilisateur pourra alors récupérer tous les dépôts d'une organisation.

### Traduction

J'ai mis tous les textes en anglais sur l'application, mais on peut aussi bien évidemment gérer toutes les langues souhaitées à l'aide d'un localizable.

## Tests

J'ai implémenté quelques cas de test de base pour les interacters de chaque scène, qui peuvent être améliorés en gérant plus précisément les différents cas (succès/échec). Grâce à l'architecture Clean Swift, nous pouvons ajouter davantage de tests pour chaque bloc (presenter, worker) si nécessaire. Nous pouvons également ajouter des tests UI.




