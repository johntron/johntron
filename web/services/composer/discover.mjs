import fetch from 'node-fetch';
import _config from './config.mjs';

const config = _config();

console.log('>>>', import.meta)

const fetchServiceRoutes = (name, url) => {
  return fetch(url)
      .then(res => {
        if (!res.ok) {
          console.log(`Failed fetching ${name} from ${url}/routes: ${res.status} ${res.statusText}`)
          return;
        }

        return res.json()
      })
}

const discoverService = ({name, mountPoint, url}) => {
  return fetchServiceRoutes(name, `${url}/routes`)
      .then(routes => ({
          name,
          url,
          mountPoint,
          routes
        }))
}

export default async () => {
  const discoverServices = config.services.map(discoverService);
  const discovered = await Promise.all(discoverServices);
  return discovered.filter(service => Boolean(service.routes))
}

// if (require.main === module) {
//   module.exports().then(services => console.log(services))
// }