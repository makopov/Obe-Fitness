# README

This application fulfills the requirements specified in the document that was sent to me. One think I'll point out that I bypassed was authentication. The user object is very minimal, and I simply wired that up to show case user tasks. In a real application we'd have authentication obviously, this can be implemented in a many ways but it was outside of the scope of this task.


### Setup

* Ruby version
    * 3.2.0

* Database creation
    * Just `rails db:migrate` I'm using sqllite

* How to run the test suite
    * The tests have an error, however you can run them with `bundle exec rspec`

### Issue with Tests

For some reason that I wasnt able to figure out in a appropriate amount of time, the response from the controller tests succeeded but returned an empty body. I have not seen this before and it must be something simple that I could figure out with some time. 

### Running the app

1. Run `bundle install`
2. Then run the rails server, `rails s`
3. Now you can hit the api endpoints using the included postman collection

### Postman collection
I have included a postman collection for hitting this api, its at the root of the project called `Obe Fitness.postman_collection`

### Performance
In this app performance isnt a big issue but as the usage would grow some things to look out for are `N+1` query issues, this can be done manually or via a gem called bullet, which makes it very nice. At the moment the app does not have `N+1` as I'm loading very minimal data.

This leads me to my next point, keep the payload as minimal as possible, espeically the views, they can grow and parsing them can take time, fragement caching can help here.

Along the lines of minimal data to return, we can try to select in our AR queries only those fields that we care about.

Batch loading is another way of returning back only a subset of data instead of all of it.