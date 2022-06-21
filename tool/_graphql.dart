
/*import 'package:graphql/client.dart';

void main() async {
    final httpLink = HttpLink(
        'https://api.github.com/graphql',
    );
    var client = GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: httpLink,
    );

    var options = QueryOptions(
        document: gql(_query)
    );

    var result = await client.query(options);

    if (result.hasException) {
        print(result.exception.toString());
    }

    print('result: $result');



// ...
}

const String _query = r'''
fragment repoProperties on Repository {
  nameWithOwner
  stargazerCount
}

{
  repo1: repository(owner: "xvrh", name: "puppeteer-dart") {
    ...repoProperties
  }
  repo2: repository(owner: "octokit", name: "aga") {
    ...repoProperties
  }
}
''';*/