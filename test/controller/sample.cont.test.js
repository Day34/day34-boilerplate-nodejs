import SampleController from '../../src/controller/sample/SampleController';
const chai = require('chai')
    , expect = chai.expect
    , should = chai.should();

let sampleCont

beforeAll(() => {
    sampleCont = new SampleController();
});

test('SampleController > getItem', () => {
    return sampleCont.getItem(1).then(data => {
        expect(data.itemId).equal(1);
    });
});

test('SampleController > getItemAll', () => {
    return sampleCont.getItemAll().then(data => {
        expect(data.length).greaterThan(0);
    });
});

test('Test 추가', () => {
   expect(true).equal(true);
});

