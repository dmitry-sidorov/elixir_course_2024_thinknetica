# Homework 05

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Create local database in docker container `docker run --name project_five -p 5432:5432 -e POSTGRES_USER=project_five -e POSTGRES_PASSWORD=project_five -d postgres`
- Create database `mix ecto.create`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:5544`](http://localhost:5544) from your browser.

# Homework 06

Ecto. Add many-to-many relation