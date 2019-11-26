import axios from 'axios';

class SampleTest {
    static getItems() {
        return axios.get(`${process.env.API_END_POINT}/api/sample/item`).then(resp => resp.data);
    }
    static getItem(itemId) {
        return axios.get(`${process.env.API_END_POINT}/api/sample/item/${itemId}`).then(resp => resp.data);
    }
    static saveItem(params) {
        return axios.post(`${process.env.API_END_POINT}/api/sample/item`,params).then(resp => resp.data);
    }
}

module.exports = SampleTest;