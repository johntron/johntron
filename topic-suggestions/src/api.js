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
    })
const johntron = grpc.loadPackageDefinition(packageDefinition).johntron;


const topics = (call, callback) => {
  callback(null, {topics: 'Hello ' + call.request.corpus});
}


if (require.main === module) {
  const server = new grpc.Server();
  server.addService(johntron.TopicSuggestions.service,
      {GetTopics: topics});
  server.bind('0.0.0.0:8080', grpc.ServerCredentials.createInsecure());
  server.start(() => console.log('started'));
}