const request = require('supertest');
const app = require('./app');

describe('GET /', () => {
    it('should respond with 200 and Hello, World!', async () => {
        const response = await request(app).get('/');
        expect(response.statusCode).toBe(200);
        expect(response.text).toBe('Hello, World!');
    });
});
