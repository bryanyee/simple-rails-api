# README

## Development Setup

- **Install Ruby**

First, ensure that `ruby-install` and `chruby` are installed. Then run:
```
ruby-install ruby 2.7.2
```

Then, `source` the `.bashrc` or `.zshrc` file, OR open a new terminal and check the version version:
```
chruby
```

- **Install Postgres**

```
brew install postgresql
brew services start postgresql
```

- **Create and seed the database**

```
rails db:create
rails db:migrate
rails db:seed
```

## Run the development server

```
rails server
```
