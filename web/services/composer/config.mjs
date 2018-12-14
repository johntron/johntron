export default () => ({
  port: 8080,
  services: [
    {
      name: 'home',
      mountPoint: '',
      url: 'http://localhost:8081',
    }
    // home: 'http://localhost:8082'
  ]
});
