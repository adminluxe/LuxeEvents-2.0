#!/usr/bin/env node
module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:4173'],
      startServerCommand: 'npm run dev',
      numberOfRuns: 3
    },
    assert: {
      assertions: { 'categories:performance': ['error', { minScore: 0.9 }] }
    },
    upload: { target: 'temporary-public-storage' }
  }
};
