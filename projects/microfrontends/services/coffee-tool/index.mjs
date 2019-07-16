import fetch from 'node-fetch';
import { readFileSync } from 'fs';
import { inspect } from 'util';

const request = async (method, suffix, body) => {
	return await fetch(`https://videointelligence.googleapis.com/${suffix}`, {
		method,
		headers: {
			Authorization: `Bearer "${process.env.TOKEN}"`,
			'Content-Type': 'application/json; charset=utf-8'
		},
		body
	});
};

const submit = async (filename='espresso-shot.mp4') => {
	//const video = readFileSync('./espresso-shot.mp4');
	//const data = new Buffer(video).toString('base64');
	const response = await request('POST', 'v1p2beta1/videos:annotate', JSON.stringify({
			input_uri: `gs://johntron-web/${filename}`,
			features: ['TEXT_DETECTION'],
		    video_context: {
				textDetectionConfig: {
					languageHints: ['en-US']
				}
			}
		})
	);
console.log(await response.json());
}
const list = async () => {
	const response = await request('GET', 'v1/operations?name=us-east1');
	const json = await response.text();
console.log(json);
};

const get = async (name='us-east1.17189877580813363552') => {
	const response = await request('GET', `v1/operations/${name}`);
	const json = await response.json();
console.log(inspect(json, { depth: 8 }));
}
//submit('espresso-scale.mp4')
//list()
get('us-west1.15038661922302031290');
