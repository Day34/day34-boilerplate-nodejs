import { RESPONSE_MESSAGE, FAILED_ERROR_MESSAGE, SUCCESS_MESSAGE } from '../../config/constants';
const express = require('express');
const router = express.Router();
const SampleController = require('../../controller/sample/SampleController');
const sampleCont = new SampleController();

router.post('/item', async (req, res) => {
    const { name, age, memo } = req.body;
    try {
        const message = await sampleCont.saveItem(name, age, memo);
        RESPONSE_MESSAGE(res,true, message, { name, age, memo });
    } catch (err) {
        RESPONSE_MESSAGE(res,false, FAILED_ERROR_MESSAGE, err);
    }
});

router.get('/item', async (req, res) => {
    try {
        const list = await sampleCont.getItemAll();
        RESPONSE_MESSAGE(res,true, SUCCESS_MESSAGE, list);
    } catch (err) {
        RESPONSE_MESSAGE(res,false, FAILED_ERROR_MESSAGE, err);
    }
});

router.get('/item/:itemId', async (req, res) => {
    const {itemId} = req.params;
    try {
        const item = await sampleCont.getItem(itemId);
        RESPONSE_MESSAGE(res,true, SUCCESS_MESSAGE, item);
    } catch (err) {
        RESPONSE_MESSAGE(res,false, FAILED_ERROR_MESSAGE, err);
    }
});

router.put('/item', async (req, res) => {
    const { name, age, memo } = req.body;

    try {
        const message = await sampleCont.updateItem(name, age, memo);
        RESPONSE_MESSAGE(res,true, message, { name, age, memo });
    } catch (err) {
        RESPONSE_MESSAGE(res,false, FAILED_ERROR_MESSAGE, err);
    }
});

router.delete('/item/:itemId', async (req, res) => {
    const {itemId} = req.params;

    try {
        const item = await sampleCont.deleteItem(itemId);
        RESPONSE_MESSAGE(res,true, SUCCESS_MESSAGE, item);
    } catch (err) {
        RESPONSE_MESSAGE(res,false, FAILED_ERROR_MESSAGE, err);
    }
});

module.exports = router;