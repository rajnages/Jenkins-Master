const request = require('supertest');
const express = require('express');
const path = require('path');

// Import the app (you might need to modify the path based on your structure)
const app = require('../app');

describe('Express App Tests', () => {
  test('GET / should return 200', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
  });

  test('GET / should contain welcome message', async () => {
    const response = await request(app).get('/');
    expect(response.text).toContain('Jenkins Sample App');
  });
});