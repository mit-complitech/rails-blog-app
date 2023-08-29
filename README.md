**Task: Implementing Polymorphic Associations**

You are building a blog platform where users can post articles and comments, and users can also comment on comments. Implement polymorphic associations to enable this hierarchical commenting system. Follow these steps:

1. **Model Setup:**
   - Create three models: `User`, `Article`, and `Comment`.
   - Set up the relationships as follows:
     - `User` has many `articles` and `comments`.
     - `Article` belongs to `user` and has many `comments`.
     - `Comment` belongs to both `user` and either an `article` or a `comment`.

2. **Polymorphic Association:**
   - Add a polymorphic association to the `Comment` model to link it with either an `Article` or another `Comment`. Name the association `commentable`.
   - Create the required migration to add the `commentable_id` and `commentable_type` columns to the `comments` table.

3. **Controllers and Views:**
   - Create controllers and views for `Users`, `Articles`, and `Comments` to manage CRUD operations.
   - Implement nested comments within the `show` action of both the `Article` and `Comment` controllers. 
	 - Display all comments related to the specific article or comment.

4. **Form Handling:**
   - Create a form for submitting new comments that includes a dropdown to select the comment's parent (`Article` or `Comment`).
   - Use Rails' `select` helper to dynamically populate the dropdown with available articles and comments.