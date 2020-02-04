#Tells Docker which image to use
FROM ruby:2.6

#Update repo listins
RUN apt-get update
#install following packages into container
RUN apt-get install --assume-yes --no-install-recommends build-essential \
    postgresql-client \
    ca-certificates \
    nodejs\
    graphviz

# Specify enviroment varible App with path
ENV APP /usr/src/app

#makes directory for app
RUN mkdir -p $APP

#Tells containerwhere we are working from
WORKDIR $APP

#THIS COPIES THE GEMFILE AND GEMFILE.LOCK TO APP FOLDER
COPY Gemfile* $APP/

#tells it to run bundle install on as many threads as possible
RUN bundle install --jobs=$(nproc)

#Tells to copy code into app folder
COPY . $APP/

#tells Container to start rails server on port 300 bind to wildcard IP
CMD ["bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]