**Task: Implementing Polymorphic Associations**

Building APIs for a blog platform where users can post articles and comments, and users can also comment on comments. Implemented polymorphic associations to enable this hierarchical commenting system.

1. **Model Setup:**
   - Created three models: `User`, `Article`, and `Comment`.
   - Set up the relationships as follows:
     - `User` has many `articles` and `comments`.
     - `Article` belongs to `user` and has many `comments`.
     - `Comment` belongs to both `user` and either an `article` or a `comment`.
     - Added validations in `User`, `Article`, and `Comment` models.

2. **Polymorphic Association:**
   - Added a polymorphic association to the `Comment` model to link it with either an `Article` or another `Comment`. Name the association `commentable`.
   - Created the required migration to add the `commentable_id` and `commentable_type` columns to the `comments` table.

3. **Routes, Controllers, and Serializers:**
   - Created routes and controllers for `Users`, `Articles`, and `Comments` to manage CRUD operations.
   - Added serializers to format and convert data into JSON objects (used `fast_jsonapi` gem)
  
4. **Test cases:**
   - Wrote test cases for `ArticlesController` to test CRUD operations.

5. **APIs:**
   - Created the Postman collection for available APIs
