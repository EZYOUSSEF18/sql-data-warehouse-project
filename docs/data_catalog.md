# Data Catalog for Gold Layer

## Overview
La couche Gold (Gold Layer) est la représentation des données au niveau métier, structurée pour répondre aux besoins d'analyse et de reporting. Elle est composée de tables de dimensions (dimension tables) et de tables de faits (fact tables) correspondant à des indicateurs métier spécifiques.

---

### 1. **gold.dim_customers**
- **objectif:** Stocke les informations des clients enrichies par des données démographiques et géographiques
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key     | INT           | Clé substitut (Surrogate Key) identifiant de manière unique chaque enregistrement            |
| customer_id      | INT           | Identifiant numérique unique attribué à chaque client                                        |
| customer_number  | NVARCHAR(50)  | Identifiant alphanumérique représentant le client utilisé pour le suivi et la référence 
                |
| first_name       | NVARCHAR(50)  | Le prénom du client tel qu'enregistré dans le système                                                          |
| last_name        | NVARCHAR(50)  | Le nom de famille du client                                                                          |
| country          | NVARCHAR(50)  | Le pays de résidence du client (par exemple : « Australie »)                                  |
| marital_status   | NVARCHAR(50)  | L'état civil du client (par exemple : « Marié(e) », « Célibataire »)                          |
| gender           | NVARCHAR(50)  | Le sexe du client (par exemple : « Homme », « Femme », « Non renseigné »)                     |
| birthdate        | DATE          | La date de naissance du client, au format AAAA-MM-JJ (par exemple : 1971-10-06)               |
| create_date      | DATE          | La date et l'heure de création de l'enregistrement du client dans le système |

---

### 2. **gold.dim_products**
- **Objectif:** Fournir des informations sur les produits et leurs caractéristiques
- **Columns:**

| Column Name         | Data Type     | Description                                                                                   |
|---------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_key         | INT           | Clé substitut (Surrogate Key) identifiant de manière unique chaque enregistrement produit dans la table de dimension des produits         |
| product_id          | INT           | Identifiant unique attribué au produit pour le suivi et la référence internes                 |
| product_number      | NVARCHAR(50)  | Code alphanumérique structuré représentant le produit, souvent utilisé pour la catégorisation ou la gestion des stocks |
| product_name        | NVARCHAR(50)  | Nom descriptif du produit incluant des informations importantes telles que le type la couleur et la taille        |
| category_id         | NVARCHAR(50)  | Identifiant unique de la catégorie du produit permettant de le rattacher à sa classification principale     |
| category            | NVARCHAR(50)  | Catégorie générale du produit (par exemple : Vélos, Composants) utilisée pour regrouper les produits similaires  |
| subcategory         | NVARCHAR(50)  | Sous-catégorie du produit offrant une classification plus détaillée au sein de la catégorie principale      |
| maintenance_required| NVARCHAR(50)  | Indique si le produit nécessite une maintenance ou un entretien (par exemple : «Oui », « Non»)                       |
| cost                | INT           | Coût ou prix de base du produit exprimé en unités monétaires                            |
| product_line        | NVARCHAR(50)  | Gamme ou série de produits à laquelle appartient le produit (par exemple : Route, Montagne)      |
| start_date          | DATE          | Date à laquelle le produit est devenu disponible à la vente ou à l'utilisation stockée au format date|

---

### 3. **gold.fact_sales**
- **Objectif:** Stocker les données transactionnelles des ventes à des fins d'analyse et de reporting
- **Columns:**

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | Identifiant alphanumérique unique de chaque commande de vente (par exemple : « SO54496 »)                      |
| product_key     | INT           | Clé substitut (Surrogate Key) reliant la commande à la table de dimension des produits                               |
| customer_key    | INT           | Clé substitut (Surrogate Key) reliant la commande à la table de dimension des clients                              |
| order_date      | DATE          | Date à laquelle la commande a été passée                                                           |
| shipping_date   | DATE          | Date a laquelle la commande a été expédiée au client                                          |
| due_date        | DATE          | Date d'échéance du paiement de la commande                                                     |
| sales_amount    | INT           | Montant total de la vente pour la ligne de commande, exprimé en unités monétaires entières (par exemple:25)   |
| quantity        | INT           | Nombre d'unités du produit commandées pour cette ligne de commande (par exemple :1)                       |
| price           | INT           | Prix unitaire du produit pour cette ligne de commande exprimé en unités monétaires entières (par exemple :25)      |
