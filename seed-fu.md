# Seed Fu

<https://github.com/mbleigh/seed-fu>

Seeding library.

Rails specific since it explicitly uses `ActiveRecord`.

TODO: why is it better than the built-in Rails seeding?

Seed DB using Seed Fu:

    bundle exec rake db:seed_fu

This will use `.rb` files under:

- `db/fixtures`
- `db/fixtures/ENVIRONMENT`

Therefore, files directly under `db/fixtures` are used for all environments.

Files are seeded in alphabetical order: if order matter use prefixes such as `01_`.

Files directly under `db/fixtures` are seeded before those inside `ENVIRONMENT`.

Only seed from files with name containing `users` or `articles`:

    FILTER=users,articles bundle exec rake db:seed_fu
