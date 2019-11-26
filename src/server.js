const { SERVER_HOST, SERVER_PORT } = require('./config/constants');
const express = require('express');
const morgan = require('morgan');
const morganBody = require('morgan-body');
const cors = require('cors');
const routes = require('./routes/index.js');
const app = express();

app.use(morgan('combined'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

morganBody(app, {
    theme: 'inverted',
});

routes(app);

app.listen(SERVER_PORT, SERVER_HOST, () =>
    console.log(`App listening on ${SERVER_HOST}:${SERVER_PORT}`)
);