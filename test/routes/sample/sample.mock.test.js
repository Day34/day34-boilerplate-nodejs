import '../../../src/server';
import SampleTest from './SampleTest';
const chai = require('chai')
    , expect = chai.expect
    , should = chai.should();

test('getItemAll Test', () => {
    return SampleTest.getItems().then(data => {
        expect(data.success).equal(true);
    });
});

test('getOneItem Test', () => {
    return SampleTest.getItem(1).then(data => {
        expect(data.success).equal(true);
    });
});

test('saveItem Test', () => {
    return SampleTest.saveItem({ name : 'jj', age : 18, memo : 'yes'}).then(data => {
        expect(data.success).equal(true);
    });
});