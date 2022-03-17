import cookie from 'cookie';
import { v4 as uuid } from '@lukeed/uuid';
import type { Handle, HandleError } from '@sveltejs/kit';
import { telemetry } from './lib/telemetry';

export const handle: Handle = async ({ event, resolve }) => {
	const cookies = cookie.parse(event.request.headers.get('cookie') || '');
	event.locals.userid = cookies.userid || uuid();

	const response = await resolve(event);

	if (!cookies.userid) {
		// if this is the first time the user has visited this app,
		// set a cookie so that we recognise them when they return
		response.headers.set(
			'set-cookie',
			cookie.serialize('userid', event.locals.userid, {
				path: '/',
				httpOnly: true
			})
		);
	}

	return response;
};

export const handleError: HandleError = async ({ error, event }) => {
	telemetry.error(error, event);
};
