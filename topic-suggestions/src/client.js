const grpc = require('grpc');
const protoLoader = require('@grpc/proto-loader');
const packageDefinition = protoLoader.loadSync(
    __dirname + '/../topic-suggestions.proto',
    {
      keepCase: true,
      longs: String,
      enums: String,
      defaults: true,
      oneofs: true
    });
const johntron = grpc.loadPackageDefinition(packageDefinition).johntron;


var client = new johntron.TopicSuggestions('localhost:8080', grpc.credentials.createInsecure());

client.GetTopics({corpus: 'you'}, function (err, response) {
  console.log('Topics:', response.topics);
});
