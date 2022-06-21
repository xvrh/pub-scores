

void main() async {
  // A github repository: pub-stars
  // Github action cron task every 1h30:
  //  - Checkout the current version of the file
  //  - Read it as json
  //  - Fetch pub-dartlang.org/api/package-names in pub
  //  - Take 1000 packages after "last_update.end_name"
  //  - Query stargazerCount with GraphQL API and all those repo
  //  - Update/insert value in the
  //  - Set "last_update"
  //  - Commit new file on main

}