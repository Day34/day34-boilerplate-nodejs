const sampleRouter = require('./sample/sampleRouter');

const router = app => {
    app.use('/api/sample', sampleRouter);
};

module.exports = router;
